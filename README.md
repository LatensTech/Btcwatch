# **BTCwatch — Potentia Drop**  
*Signal without noise.*  

---

## **Why This Exists**  
Most crypto price trackers want you to:  
- Sign up for an account  
- Sit through ads  
- Give away your data to some cloud service  

We think that’s dumb.  
You don’t need Wall Street’s permission to know the price of Bitcoin.  

BTCwatch is your **personal stealth node** — it logs Bitcoin prices **hourly**, **locally**, and **privately**.  
No cloud. No backend. No gatekeepers.  

---

## **What It Does**  
Every hour (auto-cron) BTCwatch will:  
- 📡 **Fetch live Bitcoin price** from CoinGecko  
- 📲 **Send a notification** to your phone  
- 📬 **Send a Telegram alert** (optional — if you configure it)  
- 🗂 **Log every update** to your private Potentia intel vault  

You own the data. Always.  

---

## **Why It Matters**  
- **No middleman:** All runs on your device — not someone else’s server.  
- **Offline-proof:** Logs remain even if you lose internet.  
- **Modular:** Built on the Potentia Protocol — can live alongside other drops without conflict.  

---

## **How to Install**  
You do this once. After that, BTCwatch runs on its own.  

### 1. Get the files  
Clone or download this repo into Termux.  

### 2. Run the installer  
```bash
bash install.sh
```
### 3. Allow storage access in Termux (only once)
```bash
termux-setup-storage
```
### 4. Done

BTCwatch is now synced with your Potentia grid.
You can run it anytime manually:
```bash
btcwatch
```
### Where It Stores Data

All logs are in:
```bash
~/potentia/drops/btcwatch/btcwatch.log
```

This is your private intel vault — not uploaded anywhere.

### Telegram Alerts (Optional)

If you want Telegram notifications:
```markdown
Create a Telegram bot via @BotFather

Get your bot token and your chat ID

Add them to your Potentia config file:

nano ~/potentia/config/potentia.env


Add these lines:

BOT_TOKEN=your_bot_token
CHAT_ID=your_chat_id

```
Save & exit. BTCwatch will now send updates to Telegram.

### Potentia Promise

This isn’t “just another crypto tracker.”
It’s signal without noise — and once you have it, it’s yours.
No upgrades. No expiry. No upsell.

💡 Built on the Potentia Protocol — ready for future drops without reinstalling.
