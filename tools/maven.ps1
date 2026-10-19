$ErrorActionPreference = 'Stop'
$javaCommand = (Get-Command java.exe -ErrorAction Stop).Source
$env:JAVA_HOME = Split-Path (Split-Path $javaCommand -Parent) -Parent
$mavenVersion = '3.9.11'
$cacheRoot = Join-Path $env:USERPROFILE '.m2/counselor-tools'
$mavenRoot = Join-Path $cacheRoot "apache-maven-$mavenVersion"
$mavenCommand = Join-Path $mavenRoot 'bin/mvn.cmd'
if (!(Test-Path -LiteralPath $mavenCommand)) {
    New-Item -ItemType Directory -Force -Path $cacheRoot | Out-Null
    $archivePath = Join-Path $cacheRoot "apache-maven-$mavenVersion-bin.zip"
    $downloadUrl = "https://repo.maven.apache.org/maven2/org/apache/maven/apache-maven/$mavenVersion/apache-maven-$mavenVersion-bin.zip"
    Write-Host "Preparing Maven $mavenVersion (first run only)..."
    Invoke-WebRequest -Uri $downloadUrl -OutFile $archivePath -UseBasicParsing
    $expectedHash = ([string](Invoke-WebRequest -Uri "$downloadUrl.sha512" -UseBasicParsing).Content).Trim().Split(' ')[0]
    $stream = [IO.File]::OpenRead($archivePath)
    $hasher = [Security.Cryptography.SHA512]::Create()
    try {
        $actualHash = [BitConverter]::ToString($hasher.ComputeHash($stream)).Replace('-', '')
    } finally {
        $stream.Dispose()
        $hasher.Dispose()
    }
    if ($actualHash -ne $expectedHash) { throw 'Maven download checksum mismatch.' }
    Add-Type -AssemblyName System.IO.Compression.FileSystem
    [IO.Compression.ZipFile]::ExtractToDirectory($archivePath, $cacheRoot)
}
& $mavenCommand --settings (Join-Path $PSScriptRoot '../.mvn/settings.xml') @args
exit $LASTEXITCODE
