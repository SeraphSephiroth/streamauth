Set-Location (Split-Path $MyInvocation.MyCommand.Path)
$scriptdir = Split-Path $MyInvocation.MyCommand.Path
$streamurl = Read-Host -Prompt 'Stream URL'
$channel = Read-Host -Prompt 'Channel Name'
if (-not (Test-Path -LiteralPath $scriptdir\Recordings\$channel\)) {
    
    try {
        New-Item -Path $scriptdir\Recordings\$channel\ -ItemType Directory -ErrorAction Stop | Out-Null #-Force
    }
    catch {
        Write-Error -Message "Unable to create directory '$channel'. Error was: $_" -ErrorAction Stop
    }
    "Successfully created directory '$channel'."

}
streamlink-auth $scriptdir\Resources\cookies.txt --player-no-close --retry-streams 10 -o "'$scriptdir\Recordings\$channel\stream.ts'" $streamurl best
