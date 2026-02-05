#!/bin/bash
set -e

PYTHON_BIN="python3"
# ATTENTION: Replace the URL below with your actual GitHub raw URL
INSTALLER_URL="https://raw.githubusercontent.com/Dnt3e/P-Tunnel/refs/heads/main/Source/p-tunnel.py"
INSTALLER_PATH="/usr/local/bin/install_pingtunnel.py"

check_root() {
  if [[ $EUID -ne 0 ]]; then
    echo "❌ Run as root"
    exit 1
  fi
}

download_installer() {
  echo "⬇️ Downloading Python installer..."
  apt update && apt install python3 python3-pip wget curl -y || true
  
  # Install colorama without --break-system-packages if it fails
  pip3 install colorama || pip3 install colorama --break-system-packages || echo "Notice: colorama install handled"
  
  # Download with error checking
  HTTP_CODE=$(curl -s -w "%{http_code}" -L "$INSTALLER_URL" -o "$INSTALLER_PATH")
  
  if [ "$HTTP_CODE" -ne 200 ]; then
    echo "❌ Error: Download failed with HTTP $HTTP_CODE"
    echo "Please check if INSTALLER_URL is correct."
    exit 1
  fi
  
  chmod +x "$INSTALLER_PATH"
  echo "✅ Installer saved at $INSTALLER_PATH"
}

install_pingtunnel() {
  check_root
  download_installer
  echo "🚀 Running installer..."
  $PYTHON_BIN "$INSTALLER_PATH" install
}

uninstall_pingtunnel() {
  check_root
  if [ -f "$INSTALLER_PATH" ]; then
    echo "🗑️ Running uninstaller..."
    $PYTHON_BIN "$INSTALLER_PATH" uninstall || true
    rm -rf /opt/pingtunnel /var/log/pingtunnel
    rm -f /usr/local/bin/pingtunnel "$INSTALLER_PATH"
    echo "✅ Uninstall finished"
  else
    echo "❌ Installer not found, performing manual cleanup..."
    rm -rf /opt/pingtunnel /var/log/pingtunnel
    rm -f /usr/local/bin/pingtunnel
  fi
}

check_status() {
  echo "📡 Checking status..."
  if [ -f "$INSTALLER_PATH" ]; then
    $PYTHON_BIN "$INSTALLER_PATH" status
  else
    echo "⚠️ Pingtunnel not installed."
  fi
}

view_logs() {
  echo "📜 Last 100 log lines..."
  if [ -f "/var/log/pingtunnel/pingtunnel.log" ]; then
    tail -n 100 /var/log/pingtunnel/pingtunnel.log
  else
    echo "⚠️ No logs yet."
  fi
}

restart_service() {
  echo "🔄 Restarting..."
  if [ -f "$INSTALLER_PATH" ]; then
    $PYTHON_BIN "$INSTALLER_PATH" restart
  else
    echo "⚠️ Pingtunnel not installed."
  fi
}

show_menu() {
  clear
  echo "============================"
  echo "   Pingtunnel Manager"
  echo "============================"
  echo "1) Install / Update"
  echo "2) Uninstall"
  echo "3) Check Status"
  echo "4) View Logs"
  echo "5) Restart"
  echo "6) Exit"
  echo "============================"
  echo -n "Choose [1-6]: "
}

while true; do
  show_menu
  read -r choice
  case "$choice" in
    1) install_pingtunnel ;;
    2) uninstall_pingtunnel ;;
    3) check_status ;;
    4) view_logs ;;
    5) restart_service ;;
    6) echo "Bye 👋"; exit 0 ;;
    *) echo "❌ Invalid choice"; sleep 1 ;;
  esac
  echo -n "Press Enter to continue..."
  read -r
done
