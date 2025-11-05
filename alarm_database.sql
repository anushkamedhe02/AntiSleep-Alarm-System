import tkinter as tk 
from tkinter import ttk, messagebox 
from PIL import Image, ImageTk 
import mysql.connector 
from mysql.connector import Error 
 
# ---------------- DATABASE CONFIG ---------------- 
DB_CONFIG = { 
    'host': 'localhost', 
    'user': 'root', 
    'password': 'root', 
    'database': 'anti_sleep_db' 
} 
 
# Ensure database and table exist 
def ensure_database_exists(): 
    try: 
        conn = mysql.connector.connect( 
            host=DB_CONFIG['host'], user=DB_CONFIG['user'], 
password=DB_CONFIG['password'] 
        ) 
        cursor = conn.cursor() 
        cursor.execute("CREATE DATABASE IF NOT EXISTS anti_sleep_db") 
        conn.commit() 
        cursor.close() 
        conn.close() 
    except Error as e: 
        print(f"Database creation error: {e}") 
 
def create_connection(): 
    try: 
        return mysql.connector.connect(**DB_CONFIG) 
    except Error as e: 
        print(f"Connection error: {e}") 
        return None 
 
def create_table(): 
    conn = create_connection() 
    if conn: 
        cursor = conn.cursor() 
        cursor.execute(""" 
            CREATE TABLE IF NOT EXISTS alarm_info ( 
                id INT AUTO_INCREMENT PRIMARY KEY, 
                sensitivity VARCHAR(50), 
                alarm_type VARCHAR(50), 
                mode VARCHAR(100), 
                interval_time VARCHAR(50), 
                status VARCHAR(50) 
            ) 
        """) 
        conn.commit() 
        cursor.close() 
        conn.close() 
 
# Insert or update alarm settings 
def save_alarm_settings(sensitivity, alarm_type, mode, interval_time, 
status): 
    conn = create_connection() 
    if conn: 
        cursor = conn.cursor() 
        cursor.execute("SELECT COUNT(*) FROM alarm_info") 
        exists = cursor.fetchone()[0] 
        if exists == 0: 
            cursor.execute( 
                "INSERT INTO alarm_info (sensitivity, alarm_type, mode, 
interval_time, status) VALUES (%s, %s, %s, %s, %s)", 
                (sensitivity, alarm_type, mode, interval_time, status) 
            ) 
        else: 
            cursor.execute( 
                "UPDATE alarm_info SET sensitivity=%s, alarm_type=%s, 
mode=%s, interval_time=%s, status=%s WHERE id=1", 
                (sensitivity, alarm_type, mode, interval_time, status) 
            ) 
        conn.commit() 
        cursor.close() 
        conn.close() 
 
def load_alarm_settings(): 
    conn = create_connection() 
    settings = None 
    if conn: 
        cursor = conn.cursor() 
        cursor.execute("SELECT sensitivity, alarm_type, mode, 
interval_time, status FROM alarm_info LIMIT 1") 
        settings = cursor.fetchone() 
        cursor.close() 
        conn.close() 
    return settings 
 
# Create DB 
ensure_database_exists() 
create_table() 
 
# ---------------- MAIN WINDOW ---------------- 
root = tk.Tk() 
root.title("Anti-Sleep Alarm System") 
root.geometry("1100x750") 
root.config(bg="#9bb3f1") 
 
# ---------------- HEADER ---------------- 
header_frame = tk.Frame(root, bg="#9bb3f1") 
header_frame.pack(fill="x", pady=10, padx=20) 
 
try: 
    logo_img = Image.open(r"C:\Users\HP\Desktop\anti-sleep 
alarm\logo.jpeg")  # Update your path 
    logo_img = logo_img.resize((100, 100)) 
    logo = ImageTk.PhotoImage(logo_img) 
    logo_label = tk.Label(header_frame, image=logo, bg="#9bb3f1") 
    logo_label.image = logo 
    logo_label.pack(side="left", padx=10) 
except Exception: 
    tk.Label(header_frame, text="[Logo Missing]", bg="#9bb3f1", 
font=("Arial", 10, "italic")).pack(side="left", padx=10) 
 
college_label = tk.Label( 
    header_frame, 
    text=("Maratha Vidya Prasarak Samaj's Karmaveer Adv. Baburao Ganpatrao 
Thakare " 
          "College of Engineering."), 
    bg="#9bb3f1", fg="black", font=("Arial", 12, "bold"), justify="left", 
wraplength=700 
) 
college_label.pack(side="left", padx=20) 
 
# ---------------- TITLE ---------------- 
tk.Label(root, text="Anti-Sleep Alarm System", bg="#9bb3f1", 
         fg="black", font=("Arial", 24, "bold")).pack(pady=(10, 2)) 
tk.Label(root, text="Stay alert, stay safe on the road.", bg="#9bb3f1", 
         fg="black", font=("Arial", 12)).pack(pady=(0, 15)) 
 
# ---------------- CONTENT ---------------- 
content = tk.Frame(root, bg="#9bb3f1") 
content.pack(fill="both", expand=True, padx=30, pady=10) 
content.columnconfigure(0, weight=3) 
content.columnconfigure(1, weight=2) 
 
# ---------------- LEFT: CONFIGURATION ---------------- 
config_frame = tk.LabelFrame(content, text="Alarm Configuration", 
bg="white", 
                             font=("Arial", 14, "bold"), padx=20, pady=15) 
config_frame.grid(row=0, column=0, sticky="nsew", padx=10, pady=10) 
 
tk.Label(config_frame, text="Sensitivity Level", bg="white", 
         font=("Arial", 10, "bold")).grid(row=0, column=0, sticky="w") 
tk.Label(config_frame, text="Alarm Type", bg="white", 
         font=("Arial", 10, "bold")).grid(row=0, column=1, sticky="w", 
padx=40) 
 
sensitivity_cb = ttk.Combobox(config_frame, values=["Low", "Medium - 
balanced", "High"], width=25) 
sensitivity_cb.current(1) 
sensitivity_cb.grid(row=1, column=0, sticky="w", pady=5) 
 
alarm_cb = ttk.Combobox(config_frame, values=["Beep - Audio Alert", "Voice 
Alert", "Vibration"], width=25) 
alarm_cb.current(0) 
alarm_cb.grid(row=1, column=1, sticky="w", pady=5, padx=40) 
 
tk.Label(config_frame, text="Balanced detection for most drivers", 
bg="white", fg="gray").grid(row=2, column=0, sticky="w") 
tk.Label(config_frame, text="Loud beeping sound to wake you up", 
bg="white", fg="gray").grid(row=2, column=1, sticky="w", padx=40) 
 
tk.Label(config_frame, text="Monitoring Mode", bg="white", font=("Arial", 
10, "bold")).grid(row=3, column=0, columnspan=2, sticky="w", pady=(10, 5)) 
 
mode_var = tk.StringVar(value="Eye Tracking Only") 
tk.Radiobutton(config_frame, text="Eye Tracking Only – Monitors eye 
closure duration and blink rate", 
               variable=mode_var, value="Eye Tracking Only", 
bg="white").grid(row=4, column=0, columnspan=2, sticky="w") 
tk.Radiobutton(config_frame, text="Head Position Only – Detects head 
nodding and tilted movement", 
               variable=mode_var, value="Head Position Only", 
bg="white").grid(row=5, column=0, columnspan=2, sticky="w") 
tk.Radiobutton(config_frame, text="Combined Detection (recommended) – 
Maximum accuracy with both eye and head tracking", 
               variable=mode_var, value="Combined Detection", 
bg="white").grid(row=6, column=0, columnspan=2, sticky="w") 
 
tk.Label(config_frame, text="Monitoring Time Interval", bg="white", 
font=("Arial", 10, "bold")).grid(row=7, column=0, columnspan=2, 
sticky="w", pady=(10, 5)) 
 
interval_var = tk.StringVar(value="1 Minute") 
for i, val in enumerate(["30 Seconds", "1 Minute", "2 Minutes"]): 
    tk.Radiobutton(config_frame, text=val, variable=interval_var, 
value=val, bg="white").grid(row=8, column=i, sticky="w", padx=15) 
 
def start_monitoring(): 
    save_alarm_settings( 
        sensitivity_cb.get(), 
        alarm_cb.get(), 
        mode_var.get(), 
        interval_var.get(), 
        status_button["text"] 
    ) 
    messagebox.showinfo("Saved", "Alarm settings saved successfully!") 
 
tk.Button(config_frame, text="Start Monitoring", bg="#1d4ed8", fg="white", 
          font=("Arial", 12, "bold"), width=30, 
command=start_monitoring).grid(row=9, column=0, columnspan=3, pady=20) 
 
# ---------------- RIGHT: STATUS ---------------- 
status_frame = tk.LabelFrame(content, text="Status Dashboard", bg="white", 
                             font=("Arial", 14, "bold"), padx=20, pady=15) 
status_frame.grid(row=0, column=1, sticky="nsew", padx=10, pady=10) 
 
def toggle_status(): 
    if status_button["text"].startswith("SAFE"): 
        status_button.config(text="ALERT!", bg="#ef4444", 
activebackground="#ef4444") 
    else: 
        status_button.config(text="SAFE - All Clear", bg="#3b82f6", 
activebackground="#3b82f6") 
    save_alarm_settings( 
        sensitivity_cb.get(), 
        alarm_cb.get(), 
        mode_var.get(), 
        interval_var.get(), 
        status_button["text"] 
    ) 
 
status_button = tk.Button( 
    status_frame, 
    text="SAFE - All Clear", 
    bg="#3b82f6", 
    fg="white", 
    font=("Arial", 12, "bold"), 
    width=20, 
    pady=10, 
    command=toggle_status 
) 
status_button.pack(pady=10) 
 
 
tips_frame = tk.LabelFrame(status_frame, text="Quick Tips", bg="white", 
                           font=("Arial", 12, "bold"), padx=10, pady=10) 
tips_frame.pack(fill="x", pady=20) 
 
tips = [ 
    "→ Take breaks every 2 hours during long drives", 
    "→ Avoid driving during your usual sleep hours", 
    "→ Keep your vehicle well-ventilated" 
] 
for t in tips: 
    tk.Label(tips_frame, text=t, bg="white", font=("Arial", 
10)).pack(anchor="w", pady=2) 
 
# ---------------- LOAD EXISTING SETTINGS ---------------- 
saved = load_alarm_settings() 
if saved: 
    sensitivity_cb.set(saved[0]) 
    alarm_cb.set(saved[1]) 
    mode_var.set(saved[2]) 
    interval_var.set(saved[3]) 
    status_button.config(text=saved[4]) 
 
# ---------------- RUN APP ---------------- 
root.mainloop()