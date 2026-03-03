⌨️ PowerShell Keylogger PoC 
An Educational Proof of Concept for Windows API Interaction and Persistence.


⚠️ Ethical & Legal Warning:
This project is for educational and authorized security research purposes only.
Monitoring keystrokes on a machine you do not own or without explicit, written consent is illegal and a violation of privacy. Use this responsibly to understand how malware functions and how to defend against it.



🎯 Project Overview
This project demonstrates how a simple PowerShell script can interface with low-level Windows APIs to monitor hardware states. It showcases:

API Hooking: Using user32.dll to detect key presses globally.

Stealth Execution: Running processes in a hidden window state.

Persistence: Automatically starting the script upon user login via the Windows Startup folder.

File,Description:

📄 kl.ps1                  The core logic script that captures and logs keystrokes.(presented in Documents folder)
📂 kl.txt                  The output log file (generated in your Documents folder).
🔗 kl_auto.lnk             The startup shortcut for persistent execution.(presented in startup folder)

🚀 Getting Started:

1️⃣ Setup the Core Script
Ensure kl.ps1 is located in your Documents folder.

Path: C:\Users\<YourUser>\Documents\kl.ps1

3️⃣ Enable Auto-Start (Persistence):
Execute the block present inside Persistent.txt file to ensure the script survives a reboot:

🧹 Cleanup & Removal
If you are finished with your research, follow these steps to remove all traces:

Stop the Process:(more discription inside Stoping-Process file)
Get-Process powershell | Where-Object {$_.CommandLine -like "*kl.ps1*"} | Stop-Process -Force
Delete Persistence: Navigate to shell:startup and delete kl_auto.lnk.

Delete Logs: Remove kl.ps1 and kl.txt from your Documents.


Author: [Aadi]

Topic: KeyLogging Research

Year: 2026
