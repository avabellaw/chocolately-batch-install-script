param (
    [string] $ProgramName
)

if ([string]::IsNullOrWhiteSpace($ProgramName)) {
    Write-Host "No program name provided.`n" -ForegroundColor Blue
    $ProgramName = Read-Host "Enter the name of the program you want to install and add to the list"
}

Write-Host "Attempting install of $ProgramName...`n" -ForegroundColor Yellow

choco install $ProgramName -y

Write-Host "`n"

function PrintHighlightedMessage {
    param (
        [string] $ProgramName,
        [string] $Message,
        [string] $Colour
    )

    Write-Host "$ProgramName" -ForegroundColor White -NoNewline
    Write-Host "$Message" -ForegroundColor $Colour
}

if (Select-String -Path "$PSScriptRoot\programs.txt" -Pattern "^$ProgramName$") {
    PrintHighlightedMessage -ProgramName $ProgramName -Message " is already in program list" -Colour Blue
    Exit
}

if ($($LASTEXITCODE) -ne 0) {
    Write-Host "Failed to install $ProgramName.`n" -ForegroundColor Red
    Write-Host "Add to list anyway? y/n`n" -ForegroundColor White

    $KeyPressed = [System.Console]::ReadKey($true)

    if ($KeyPressed.KeyChar.ToString().ToLower() -ne 'y') {
        PrintHighlightedMessage -ProgramName $ProgramName -Message " has not been added to program list" -Colour Red
        Exit
    }
}

Add-Content "$PSScriptRoot\programs.txt" "$ProgramName"
PrintHighlightedMessage -ProgramName $ProgramName -Message " has been added to program list" -Colour Green