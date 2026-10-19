"""Offline MySQL v1 -> six-table migration. Source is never modified.

Stop the application before running. MYSQL_PWD must be set in the environment.
Example: python -S tools/migrate-six-tables.py --source counselor_db --target counselor_db_v2
The target must not exist. The script backs up the source, creates the target,
copies every source field, verifies row counts and field equality, and exports IDs.
It deliberately does not change application configuration or delete databases.
"""
import argparse
import atexit
import csv
import datetime
import json
import os
from pathlib import Path
import re
import shutil
import subprocess
import tempfile

ROOT = Path(__file__).resolve().parents[1]
STUDENT_SPECS = [
    ('reward_punishment', 'REWARD', {'student_id':'student_id', 'type':'category', 'level':'reward_level', 'name':'title', 'reason':'reason', 'occur_date':'occur_date', 'operator':'operator', 'status':'status', 'create_time':'create_time'}),
    ('leave_request', 'LEAVE', {c:c for c in ['student_id','start_date','end_date','days','reason','status','counselor_id','approve_time','create_time']} | {'leave_type':'category'}),
    ('financial_aid', 'AID', {c:c for c in ['student_id','amount','semester','family_income','difficulty_level','reason','status','counselor_id','create_time']} | {'aid_type':'category'}),
    ('student_archive', 'ARCHIVE', {c:c for c in ['student_id','file_path','description','operator','create_time']} | {'archive_type':'category','archive_name':'title','upload_date':'occur_date'}),
    ('employment_track', 'EMPLOYMENT', {c:c for c in ['student_id','company','position','salary','city','school','major','remark','counselor_id','create_time']} | {'employment_status':'status','track_date':'occur_date'}),
]
WORK_SPECS = [
    ('work_reminder', 'TASK', {c:c for c in ['title','content','priority','due_date','status','counselor_id','create_time']} | {'type':'category'}),
    ('workflow_minutes', 'MINUTES', {c:c for c in ['title','category','content','participants','meeting_date','location','summary','counselor_id','create_time']}),
]

def main():
    parser = argparse.ArgumentParser(description=__doc__)
    parser.add_argument('--source', default='counselor_db')
    parser.add_argument('--target', default='counselor_db_v2')
    parser.add_argument('--host', default='127.0.0.1')
    parser.add_argument('--port', default='3306')
    parser.add_argument('--user', default='root')
    parser.add_argument('--mysql', default=shutil.which('mysql') or 'C:/mysql/bin/mysql.exe')
    parser.add_argument('--resume-empty-target', action='store_true', help='Resume only when all six target tables exist and are empty.')
    parser.add_argument('--verify-only', action='store_true', help='Verify an already copied target without writing database rows.')
    args = parser.parse_args()
    for name in (args.source, args.target):
        if not re.fullmatch(r'[A-Za-z][A-Za-z0-9_]{0,63}', name):
            parser.error('Database names must be simple ASCII identifiers.')
    if args.source == args.target:
        parser.error('Source and target must differ.')
    if 'MYSQL_PWD' not in os.environ:
        parser.error('Set MYSQL_PWD in the environment; do not pass passwords as arguments.')
    common = [f'--host={args.host}', f'--port={args.port}', f'--user={args.user}', '--default-character-set=utf8mb4', '--protocol=TCP']
    # One connection avoids repeated client startup and preserves transaction semantics.
    errors = tempfile.TemporaryFile(mode='w+b')
    connection = subprocess.Popen([args.mysql, *common, '--batch', '--skip-column-names',
                                   '--unbuffered', '--connect-timeout=10'],
                                  stdin=subprocess.PIPE, stdout=subprocess.PIPE, stderr=errors,
                                  text=True, encoding='utf-8')
    def close():
        if connection.poll() is None:
            connection.stdin.close()
            try:
                connection.wait(timeout=5)
            except subprocess.TimeoutExpired:
                connection.kill()
                connection.wait()
        errors.close()
    atexit.register(close)
    def sql(query):
        marker = '__COUNSELOR_MIGRATION_QUERY_END__'
        connection.stdin.write(query.rstrip() + f"\nSELECT '{marker}';\n")
        connection.stdin.flush()
        rows = []
        while True:
            line = connection.stdout.readline()
            if not line:
                errors.seek(0)
                raise RuntimeError(errors.read().decode('utf-8', errors='replace') or 'MySQL connection closed unexpectedly.')
            line = line.rstrip('\r\n')
            if line == marker:
                return '\n'.join(rows).strip()
            rows.append(line)
    def scalar(query):
        result = sql(query)
        if not result:
            raise RuntimeError('MySQL returned no scalar result for: ' + query)
        return int(result)
    src, dst = f'`{args.source}`', f'`{args.target}`'
    target_exists = scalar(f"SELECT COUNT(*) FROM information_schema.schemata WHERE schema_name='{args.target}';") > 0
    if target_exists:
        target_tables = set(sql(f"SELECT table_name FROM information_schema.tables WHERE table_schema='{args.target}';").splitlines())
        if not (args.resume_empty_target or args.verify_only) or target_tables != {'sys_user','student','visitor_log','student_record','work_record','operation_log'}:
            raise RuntimeError('Target already exists. Refusing to overwrite it.')
        if not args.verify_only:
            for table in target_tables:
                if scalar(f'SELECT COUNT(*) FROM {dst}.{table};') != 0:
                    raise RuntimeError('Resume requires every target table to be empty.')
    elif args.verify_only:
        raise RuntimeError('Verification requires an existing target database.')
    tables = set(sql(f"SELECT table_name FROM information_schema.tables WHERE table_schema='{args.source}' AND table_type='BASE TABLE';").splitlines())
    expected = {'sys_user','student','visitor_log','operation_log','operation_log_detail'} | {s[0] for s in STUDENT_SPECS + WORK_SPECS}
    if tables != expected:
        raise RuntimeError(f'Expected the twelve v1 tables; missing={expected-tables}, unexpected={tables-expected}')
    backup = ROOT / '.backups' / ('six-tables-' + datetime.datetime.now().strftime('%Y%m%d-%H%M%S'))
    backup.mkdir(parents=True)
    dump = Path(args.mysql).with_name('mysqldump.exe' if os.name == 'nt' else 'mysqldump')
    subprocess.run([str(dump), *common, '--single-transaction', '--routines', '--triggers',
                    '--set-gtid-purged=OFF', f'--result-file={backup / "source.sql"}', '--databases', args.source], check=True)
    if (backup / 'source.sql').stat().st_size == 0:
        raise RuntimeError('Empty backup; migration stopped.')
    print(f'Backup saved: {backup}', flush=True)
    if not target_exists:
        sql(f'CREATE DATABASE {dst} CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci;')
        schema = (ROOT / 'src/main/resources/db/schema.sql').read_text(encoding='utf-8')
        sql(f'USE {dst};\n' + schema)
    statements = ['START TRANSACTION;']
    verification = []
    counts = {}
    missing_students = sql('SELECT DISTINCT r.student_id FROM (' + ' UNION '.join(
        f'SELECT student_id FROM {src}.{table}' for table,_,_ in STUDENT_SPECS)
        + f') r LEFT JOIN {src}.student s ON s.id=r.student_id WHERE s.id IS NULL ORDER BY r.student_id;').splitlines()
    for table in ['sys_user','student','visitor_log']:
        columns = sql(f"SELECT column_name FROM information_schema.columns WHERE table_schema='{args.source}' AND table_name='{table}' ORDER BY ordinal_position;").splitlines()
        cols = ','.join(f'`{c}`' for c in columns)
        statements.append(f'INSERT INTO {dst}.{table} ({cols}) SELECT {cols} FROM {src}.{table};')
        checks = ' AND '.join(f'BINARY n.`{c}` <=> BINARY o.`{c}`' for c in columns)
        verification.append((table, f'SELECT COUNT(*) FROM {src}.{table} o LEFT JOIN {dst}.{table} n ON n.id=o.id WHERE NOT ({checks});'))
        counts[table] = scalar(f'SELECT COUNT(*) FROM {src}.{table};')
        if table == 'student':
            for missing in missing_students:
                student_id = int(missing)
                # Explicit tombstone only; no guessed personal or academic information.
                statements.append(f"INSERT INTO {dst}.student (id,student_no,name,gender,college,major,class_name,status) "
                    + f"VALUES ({student_id},'__missing_{student_id}','历史资料缺失#{student_id}','未知','历史资料缺失','历史资料缺失','历史资料缺失','历史缺失');")
    id_rows = []
    for target, specs in [('student_record', STUDENT_SPECS), ('work_record', WORK_SPECS)]:
        offset = 0
        for table, kind, mapping in specs:
            maximum = scalar(f'SELECT COALESCE(MAX(id),0) FROM {src}.{table};')
            count = scalar(f'SELECT COUNT(*) FROM {src}.{table};')
            counts[kind] = count
            cols = ','.join(f'`{c}`' for c in mapping.values())
            oldcols = ','.join(f'`{c}`' for c in mapping)
            statements.append(f"INSERT INTO {dst}.{target} (id,record_type,{cols}) SELECT id+{offset},'{kind}',{oldcols} FROM {src}.{table};")
            checks = ' AND '.join(f'BINARY n.`{new}` <=> BINARY o.`{old}`' for old,new in mapping.items())
            verification.append((kind, f"SELECT COUNT(*) FROM {src}.{table} o LEFT JOIN {dst}.{target} n ON n.id=o.id+{offset} AND n.record_type='{kind}' WHERE n.id IS NULL OR NOT ({checks});"))
            for old in sql(f'SELECT id FROM {src}.{table} ORDER BY id;').splitlines():
                if old:
                    id_rows.append((table, int(old), target, int(old)+offset))
            offset += maximum
    logcols = sql(f"SELECT column_name FROM information_schema.columns WHERE table_schema='{args.source}' AND table_name='operation_log' ORDER BY ordinal_position;").splitlines()
    cols = ','.join(f'`{c}`' for c in logcols)
    statements.append(f'INSERT INTO {dst}.operation_log ({cols},details) SELECT ' + ','.join('l.`'+c+'`' for c in logcols) + f', d.details FROM {src}.operation_log l LEFT JOIN {src}.operation_log_detail d ON d.log_id=l.id;')
    checks = ' AND '.join(f'BINARY n.`{c}` <=> BINARY o.`{c}`' for c in logcols)
    verification.append(('operation_log', f'SELECT COUNT(*) FROM {src}.operation_log o LEFT JOIN {src}.operation_log_detail d ON d.log_id=o.id LEFT JOIN {dst}.operation_log n ON n.id=o.id WHERE n.id IS NULL OR NOT ({checks} AND BINARY n.details <=> BINARY d.details);'))
    counts['operation_log'] = scalar(f'SELECT COUNT(*) FROM {src}.operation_log;')
    statements.append('COMMIT;')
    if not args.verify_only:
        sql('\n'.join(statements))
    for label, query in verification:
        mismatches = scalar(query)
        if mismatches:
            raise RuntimeError(f'Field verification failed for {label}: {mismatches} rows. Do not switch configuration.')
    for table in ['sys_user','student','visitor_log','operation_log']:
        expected_count = counts[table] + (len(missing_students) if table == 'student' else 0)
        if scalar(f'SELECT COUNT(*) FROM {dst}.{table};') != expected_count:
            raise RuntimeError(f'Count mismatch: {table}')
    for table, specs in [('student_record', STUDENT_SPECS),('work_record', WORK_SPECS)]:
        for _,kind,_ in specs:
            if scalar(f"SELECT COUNT(*) FROM {dst}.{table} WHERE record_type='{kind}';") != counts[kind]:
                raise RuntimeError(f'Count mismatch: {kind}')
    if scalar(f"SELECT COUNT(*) FROM information_schema.tables WHERE table_schema='{args.target}' AND table_type='BASE TABLE';") != 6:
        raise RuntimeError('Target must contain exactly six tables.')
    with (backup / 'id-map.csv').open('w', encoding='utf-8-sig', newline='') as stream:
        writer = csv.writer(stream)
        writer.writerow(['old_table','old_id','new_table','new_id'])
        writer.writerows(id_rows)
    report = {'source':args.source, 'target':args.target, 'counts':counts,
              'missing_student_placeholders':[int(value) for value in missing_students],
              'verified':'All mapped source fields, log details, counts and six-table schema match.',
              'historical_ids':'Old audit text remains unchanged. Resolve old business IDs with id-map.csv.',
              'files':'Upload files and stored paths are unchanged.'}
    (backup / 'verification.json').write_text(json.dumps(report, ensure_ascii=False, indent=2), encoding='utf-8')
    print(json.dumps(report, ensure_ascii=False, indent=2))

if __name__ == '__main__':
    main()
