#!/data/data/com.termux/files/usr/bin/bash

echo "🔧 Bootstrapping BTCwatch Protocol..."
sleep 2

# ✅ Update system
pkg update -y
pkg install python termux-api cronie -y


if ! python3 -c "import requests" &> /dev/null; then
    echo "📦 Installing Python requests module..."
    pip install requests
else
    echo "✅ Python requests module already installed."
fi

echo "$(date) - Checked Python dependencies" >> ~/potentia/logs/potentia.log
sleep 2

echo "📁 Creating base directories... ~/potentia/drops/btcwatch"
sleep 1

# 📁 Create base directories
mkdir -p ~/potentia/drops
mkdir -p ~/potentia/config
mkdir -p ~/potentia/logs

# 📦 Move current folder (drop) into btcwatch drop folder
CURRENT_DIR=$(pwd)
DROP_DEST=~/potentia/drops/btcwatch
rm -rf "$DROP_DEST"
mkdir -p "$DROP_DEST"
cp -r "$CURRENT_DIR"/* "$DROP_DEST"

# 📜 Ensure secrets and logs exist
touch "$DROP_DEST/btcwatch.log"
touch ~/potentia/logs/potentia.log

echo "🔗 Syncing BTCwatch With Potentia Grid..."
sleep 1

# 🧠 Setup cron job (hourly, silent mode)
CRON_ENTRY="0 * * * * python3 $DROP_DEST/btcwatch.py"
(crontab -l 2>/dev/null | grep -v 'btcwatch.py'; echo "$CRON_ENTRY") | crontab -

# ⚙️ Create config file if missing
CONFIG_FILE=~/potentia/config/potentia.env
if [ ! -f "$CONFIG_FILE" ]; then
    echo "# Potentia Config" > "$CONFIG_FILE"
    echo "BTCWATCH_ENABLED=true" >> "$CONFIG_FILE"
    echo "INSTALL_DATE=$(date)" >> "$CONFIG_FILE"
else
    sed -i "s/BTCWATCH_ENABLED=.*/BTCWATCH_ENABLED=true/" "$CONFIG_FILE"
fi

# 🧙 Add shell alias for btcwatch
SHELL_NAME=$(basename "$SHELL")
if [ "$SHELL_NAME" = "zsh" ]; then
    PROFILE_FILE=~/.zshrc
else
    PROFILE_FILE=~/.bashrc
fi

ALIAS_CMD='alias btcwatch="python3 ~/potentia/drops/btcwatch/btcwatch.py"'
grep -qxF "$ALIAS_CMD" "$PROFILE_FILE" || echo "$ALIAS_CMD" >> "$PROFILE_FILE"

ALIAS_ENTER='alias drops="cd ~/potentia/drops/btcwatch/"'
grep -qxF "$ALIAS_ENTER" "$PROFILE_FILE" || echo "$ALIAS_ENTER" >> "$PROFILE_FILE"

# 🔁 Reload shell profile to activate alias
source "$PROFILE_FILE"

echo "✅ BTCwatch installed and synced with Potentia Protocol."
echo "📈 You’ll receive hourly BTC updates via Termux and Telegram."
echo "💬 Type btcwatch to check price manually."
echo "✒️ Edit the drop by typing drops"
sleep 2
echo "🚀 Initiating First BTCwatch Ping..."
python3 "$DROP_DEST/btcwatch.py"
