
# 🛰️ Pingtunnel Multi-Port Manager

A professional, high-performance wrapper for **Pingtunnel** that enables tunneling network traffic through **ICMP (Ping)**. This version is specifically enhanced to support **Multi-Port** management within a single system service.

## ✨ Key Features

* **🚀 Multi-Port Forwarding:** Forward multiple ports (e.g., 80, 443, 8080) simultaneously using a single configuration.
* **🛠️ Automated Deployment:** One-click Bash/Python installer that handles all dependencies (Python3, Pip, Colorama).
* **🔄 Intelligent Self-Healing:** Built-in monitor loop that automatically detects process crashes and restarts them.
* **🛡️ Systemd Integration:** Fully integrated as a Linux service (`pingtunnel.service`) for automatic boot-start.
* **🧠 Resource Management:** Optional memory limits to ensure stability on low-end VPS instances.
* **🔐 Encryption:** Supports secure Key/Password authentication for all tunnel traffic.

---

## ⚙️ Quick Installation

Run the following command to install or manage your Pingtunnel instances:

```bash
curl -Ls https://raw.githubusercontent.com/Dnt3e/P-Tunnel/main/bash.sh | bash

```

---

## 📖 How to Use Multi-Port Support

During the installation process, when prompted for the **Type**, choose `client`. When the script asks for the **Forward Ports**, you can enter multiple ports separated by a **comma (,)**.

> **Input Example:** `443, 8080, 2082`

The script will automatically spawn individual tunnel processes for each port and manage them under one centralized service.

---

## 🛠️ Management Menu

Once installed, you can access the management menu anytime by typing:

```bash
pingtunnel

```

The CLI menu provides the following options:

1. **Start/Stop/Restart:** Control the tunnel status.
2. **Status:** Check if the binary is running and view active ports.
3. **Logs:** Real-time view of the `/var/log/pingtunnel/pingtunnel.log`.
4. **Edit Config:** Modify your ports, server IP, or keys without re-installing.
5. **Uninstall:** Completely remove all files and system services.

---

## ⚠️ Requirements

* **OS:** Linux (Ubuntu 20.04+ recommended).
* **Privileges:** Root access is required to manage ICMP raw sockets.
* **Firewall:** Ensure the server allows ICMP traffic (Ping) and the specific ports you wish to forward.

---

## 📜 Technical Structure

| Component | Path |
| --- | --- |
| **Binaries** | `/opt/pingtunnel/bin` |
| **Configuration** | `/opt/pingtunnel/conf/config.json` |
| **Logs** | `/var/log/pingtunnel/pingtunnel.log` |
| **Service File** | `/etc/systemd/system/pingtunnel.service` |

---

### 👨‍💻 Developer

Developed and maintained by **hoseinlolready**. Optimized for bypassing network restrictions via ICMP protocols.

---

Would you like me to add a **Troubleshooting** section or a **Comparison Table** between standard Pingtunnel and this Multi-Port version?
