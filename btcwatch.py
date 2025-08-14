#!/data/data/com.termux/files/usr/bin/python3

import requests
import datetime
import os

# === Setup ===
url = "https://api.coingecko.com/api/v3/simple/price?ids=bitcoin&vs_currencies=usd"
log_path = "/data/data/com.termux/files/home/potentia/drops/btcwatch/btcwatch.log"

BOT_TOKEN = os.getenv("BOT_TOKEN")
CHAT_ID = os.getenv("CHAT_ID")

try:
    response = requests.get(url)
    data = response.json()
    price = data["bitcoin"]["usd"]

    now = datetime.datetime.now().strftime("%Y-%m-%d %H:%M:%S")
    message = f"[{now}] BTC Price: ${price:,.2f}"
    print(f"📈 {message}")

    # Save to log file
    with open(log_path, "a") as f:
        f.write(message + "\n")

    # Local notification
    os.system(f'termux-notification --title "BTCwatch Update" --content "{message}"')

    # Telegram notification
    if BOT_TOKEN and CHAT_ID:
        tg_url = f"https://api.telegram.org/bot{BOT_TOKEN}/sendMessage"
        payload = {
            "chat_id": CHAT_ID,
            "text": f"📈 {message}"
        }
        requests.post(tg_url, data=payload)

except Exception as e:
    error_msg = f"[ERROR] {e}"
    print(error_msg)
