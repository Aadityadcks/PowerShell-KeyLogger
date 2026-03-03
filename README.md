PowerShell Keylogging Techniques
Educational Proof of Concept (PoC) – Defensive Security Research

⚠️ Disclaimer

This project is strictly for educational, academic, and authorized security research purposes only.
It does not contain functional keylogging code.

The purpose of this repository is to explain how certain Windows API calls can be abused by malicious actors, how persistence mechanisms work, and how defenders can detect and mitigate such threats.

Unauthorized monitoring of user activity without explicit consent is illegal and unethical.

🎯 Project Objective

This repository documents:

How keyboard state monitoring works at a conceptual level

How Windows API functions (e.g., those within user32.dll) may be abused

How PowerShell can be leveraged for post-exploitation techniques

How persistence can be achieved through common Windows startup locations

Most importantly — how defenders can detect and prevent these techniques

This project is written from a defensive cybersecurity perspective.

🧠 Educational Topics Covered
1. Windows API Interaction via PowerShell

PowerShell can dynamically interface with unmanaged Windows libraries.
Attackers sometimes leverage this capability to call low-level API functions to:

Monitor keyboard state

Interact with system processes

Query hardware input states

Understanding this behavior helps defenders recognize suspicious script activity.

2. Keyboard State Polling (Conceptual)

Malicious scripts may:

Continuously check virtual key codes

Convert hardware input into readable text

Write captured data to local files

From a detection standpoint, this often results in:

High-frequency polling loops

Repeated API calls to input-related functions

Unusual file write behavior in user directories

3. Persistence via Startup Folder

A common persistence method involves placing a shortcut or executable inside:

%APPDATA%\Microsoft\Windows\Start Menu\Programs\Startup

This ensures execution at user login.

Defensive monitoring should include:

Auditing the Startup folder

Monitoring shortcut creation

Reviewing suspicious PowerShell execution flags

🔍 How Attackers Attempt Stealth

Common stealth techniques include:

Running PowerShell with hidden window styles

Bypassing execution policies

Avoiding profile loading

Logging to inconspicuous text files in user directories

Security tools often flag combinations of these behaviors.

🛡️ Defensive Detection Strategies
1. Monitor Suspicious PowerShell Execution

Look for:

Hidden window execution

Execution policy bypass flags

Long-running background PowerShell processes

Tools:

Windows Event Viewer (Event ID 4688 – Process Creation)

Sysmon (Event ID 1)

EDR telemetry

2. Detect API Abuse Patterns

Antimalware systems may flag:

Dynamic imports of Windows API libraries

Calls to keyboard state functions

Rapid polling loops

Modern Windows Defender and AMSI provide behavioral analysis for such patterns.

3. Startup Persistence Auditing

Regularly inspect:

Startup folder contents

Task Scheduler entries

Registry Run keys

Also review the Startup tab in Task Manager for anomalies.

4. File Integrity Monitoring

Watch for:

Unexpected text files appearing in user directories

Rapid append operations to hidden log files

Repeated write activity from PowerShell processes
