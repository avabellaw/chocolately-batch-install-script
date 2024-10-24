$programs = Get-Content -Path ".\programs.txt"

if ($programs -is [string]) {
    $programs = $programs -split "`n"
}
			
$ProgramsLen = $programs.Length
			
$FailedInstalls = @()

$Seperator = "--------------------------------------------------------"

Write-Host "`n[You are about to install all $ProgramsLen programs included in this script using Chocolately]`n" -ForegroundColor Yellow
Write-Host "Add NORDVPN and NORDPASS manually`n" -ForegroundColor Red

Write-Host "Press enter to continue..." -ForegroundColor White
$KeyPressed = [System.Console]::ReadKey($true)
if ($KeyPressed.Key -ne [System.ConsoleKey]::Enter) {
	Write-Host "`nExiting script..." -ForegroundColor Red
	Exit
}

Write-Host "$Seperator`n" -ForegroundColor Blue

if (Get-Command -Name choco.exe -ErrorAction SilentlyContinue) {
	Write-Host "Chocolately already installed." -ForegroundColor Green
} else {
	Set-ExecutionPolicy Bypass -Scope Process -Force; [System.Net.ServicePointManager]::SecurityProtocol = [System.Net.ServicePointManager]::SecurityProtocol -bor 3072; iex ((New-Object System.Net.WebClient).DownloadString('https://community.chocolatey.org/install.ps1'))
}

function Install-Program {

param (
        $ProgramName
    )

choco install $ProgramName -y
}

for ($i=0; $i -lt $programs.Length; $i++) {
	Write-Host "`n$Seperator`nInstalling program $($i + 1) of $($ProgramsLen): [" -ForegroundColor Blue -NoNewline
	Write-Host "$($programs[$i])" -ForegroundColor Yellow -NoNewline
	Write-Host "]`n$Seperator`n" -ForegroundColor Blue
    Install-Program $programs[$i] 
	if ($($LASTEXITCODE) -ne 0) {
		$FailedInstalls += $programs[$i]
	}
}

Write-Host "`n$Seperator`n" -ForegroundColor White
if ($FailedInstalls.Length -gt 0) {
	Write-Host "$($FailedInstalls.Length) program(s) failed to install:`n" -ForegroundColor Red
	$Counter = 1
	foreach ($Install in $FailedInstalls){
		Write-Host "$Counter. $Install"
		$Counter += 1
	}
} else {
	Write-Host "`nNo failed installs.`n" -ForegroundColor Green
}
Write-Host "`n$Seperator`n" -ForegroundColor Blue

