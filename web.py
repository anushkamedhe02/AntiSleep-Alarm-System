import tkinter as tk
from tkinter import ttk
from tkinter import font as tkfont
from PIL import Image, ImageTk

def start_monitoring():
    # Placeholder for start monitoring functionality
    print("Monitoring started")


root = tk.Tk()
root.title("Anti-Sleep Alarm System")
root.geometry("980x560")
root.configure(bg="#8aaae0")  # Light blue background

# Set icon logo image path here:
logo_path = "path/to/your/logo.png"

# Top frame for logo and heading
top_frame = tk.Frame(root, bg="#8aaae0")
top_frame.pack(fill=tk.X, padx=10, pady=10)

# Logo image
try:
    logo_img = Image.open("college_logo.png")
    logo_img = logo_img.resize((80, 80))
    logo_photo = ImageTk.PhotoImage(logo_img)
    logo_label = tk.Label(top_frame, image=logo_photo, bg="white")
    logo_label.pack(side=tk.LEFT, padx=5)
except Exception as e:
    logo_label = tk.Label(top_frame, text="[Logo Image]", bg="#8aaae0")
    logo_label.pack(side=tk.LEFT, padx=5)

# Institution name label
inst_text = ("Maratha Vidya Prasarak Samaj's Karmaveer Adv. Baburao Ganpatrao Thakare College of Engineering.")
inst_label = tk.Label(top_frame, text=inst_text, font=("Helvetica", 10, "bold"), bg="#8aaae0", anchor='w', justify=tk.LEFT)
inst_label.pack(side=tk.LEFT, padx=15)

# Main title
title_label = tk.Label(root, text="Anti-Sleep Alarm System", font=("Helvetica", 16, "bold"), bg="#8aaae0")
title_label.pack(pady=(10,0))

# Subtitle
subtitle_label = tk.Label(root, text="Stay alert, stay safe on the road.", font=("Helvetica", 10), bg="#8aaae0")
subtitle_label.pack()

# Frame for main content
main_frame = tk.Frame(root, bg="#8aaae0")
main_frame.pack(fill=tk.BOTH, expand=True, padx=12, pady=10)

# Left Frame - Alarm Configuration
alarm_config_frame = tk.LabelFrame(main_frame, text="Alarm Configuration", font=("Helvetica", 9, "bold"), bg="white", padx=15, pady=15)
alarm_config_frame.pack(side=tk.LEFT, fill=tk.BOTH, expand=True, padx=(0,12))

# Sensitivity Level
sens_frame = tk.Frame(alarm_config_frame, bg="white")
sens_frame.grid(row=0, column=0, sticky="w", pady=(5,5))

sens_label = tk.Label(sens_frame, text="Sensitivity Level", font=("Helvetica", 9), bg="white")
sens_label.pack(anchor="w")

sens_var = tk.StringVar(value="Medium - balanced")
sens_combo = ttk.Combobox(sens_frame, textvariable=sens_var, state="readonly", width=20)
sens_combo['values'] = ("Low - less sensitive", "Medium - balanced", "High - very sensitive")
sens_combo.pack(anchor="w", pady=(3,0))

sens_note = tk.Label(sens_frame, text="Balanced detection for most drivers", font=("Helvetica", 7), fg="grey", bg="white")
sens_note.pack(anchor="w")

# Alarm Type
alarm_type_frame = tk.Frame(alarm_config_frame, bg="white")
alarm_type_frame.grid(row=0, column=1, padx=50, sticky="w", pady=(5,5))

alarm_type_label = tk.Label(alarm_type_frame, text="Alarm Type", font=("Helvetica", 9), bg="white")
alarm_type_label.pack(anchor="w")

alarm_type_var = tk.StringVar(value="Beep - Audio Alert")
alarm_type_combo = ttk.Combobox(alarm_type_frame, textvariable=alarm_type_var, state="readonly", width=20)
alarm_type_combo['values'] = ("Beep - Audio Alert", "Vibration Alert", "Visual Alert")
alarm_type_combo.pack(anchor="w", pady=(3,0))

alarm_type_note = tk.Label(alarm_type_frame, text="Loud beeping sound to wake you up", font=("Helvetica", 7), fg="grey", bg="white")
alarm_type_note.pack(anchor="w")

# Monitoring Mode
monitor_mode_label = tk.Label(alarm_config_frame, text="Monitoring Mode", font=("Helvetica", 9, "bold"), bg="white")
monitor_mode_label.grid(row=1, column=0, sticky="w", pady=(15,0), columnspan=2)

monitor_mode_var = tk.StringVar(value="Eye Tracking Only")

mode1 = tk.Radiobutton(alarm_config_frame, text="Eye Tracking Only – Monitors eye closure duration and blink rate",
                       variable=monitor_mode_var, value="Eye Tracking Only", font=("Helvetica", 8), bg="white")
mode1.grid(row=2, column=0, sticky="w", pady=(2,2), columnspan=2)

mode2 = tk.Radiobutton(alarm_config_frame, text="Head Position Only – Detects head nodding and tilted movement",
                       variable=monitor_mode_var, value="Head Position Only", font=("Helvetica", 8), bg="white")
mode2.grid(row=3, column=0, sticky="w", pady=(2,2), columnspan=2)

mode3 = tk.Radiobutton(alarm_config_frame, text="Combined Detection (recommended) – Maximum accuracy with both eye and head tracking",
                       variable=monitor_mode_var, value="Combined Detection", font=("Helvetica", 8), bg="white")
mode3.grid(row=4, column=0, sticky="w", pady=(2,2), columnspan=2)

# Monitoring Time Interval
monitor_time_label = tk.Label(alarm_config_frame, text="Monitoring Time Interval", font=("Helvetica", 9, "bold"), bg="white")
monitor_time_label.grid(row=5, column=0, sticky="w", pady=(15,2), columnspan=2)

interval_var = tk.StringVar(value="1 Minute")

interval1 = tk.Radiobutton(alarm_config_frame, text="30 Seconds", variable=interval_var, value="30 Seconds", font=("Helvetica", 8), bg="white")
interval1.grid(row=6, column=0, sticky="w", pady=(2,2))

interval2 = tk.Radiobutton(alarm_config_frame, text="1 Minute", variable=interval_var, value="1 Minute", font=("Helvetica", 8), bg="white")
interval2.grid(row=6, column=1, sticky="w", pady=(2,2))

interval3 = tk.Radiobutton(alarm_config_frame, text="2 Minutes", variable=interval_var, value="2 Minutes", font=("Helvetica", 8), bg="white")
interval3.grid(row=6, column=2, sticky="w", pady=(2,2))

# Start Monitoring Button
start_btn = tk.Button(alarm_config_frame, text="Start Monitoring", bg="#2460d3", fg="white", font=("Helvetica", 10, "bold"), width=25, command=start_monitoring)
start_btn.grid(row=7, column=0, columnspan=3, pady=(20, 0))

# Right Frame - Status Dashboard
status_frame = tk.LabelFrame(main_frame, text="Status Dashboard", font=("Helvetica", 9, "bold"), bg="white", padx=15, pady=15)
status_frame.pack(side=tk.LEFT, fill=tk.BOTH, expand=True)

# Status Button
status_btn = tk.Button(status_frame, text="SAFE - All Clear", font=("Helvetica", 10), bg="#2a71f9", fg="white", width=20)
status_btn.pack(pady=(5, 15))

# System Status Details
status_text = (
    "System Status: Inactive\n"
    "Sensitivity: Medium\n"
    "Alarm Type: Beep\n"
    "Interval: 1 min"
)
status_label = tk.Label(status_frame, text=status_text, justify=tk.LEFT, bg="white", font=("Helvetica", 9))
status_label.pack(anchor="w")

# Quick Tips Frame
tips_frame = tk.LabelFrame(status_frame, text="Quick Tips", font=("Helvetica", 9, "bold"), bg="white", padx=5, pady=5)
tips_frame.pack(fill=tk.BOTH, pady=(15, 5))

tips = [
    "→ Take breaks every 2 hours during long drives",
    "→ Avoid driving during your usual sleep hours",
    "→ Keep your vehicle well-ventilated"
]

for tip in tips:
    tip_label = tk.Label(tips_frame, text=tip, font=("Helvetica", 8), bg="white", anchor="w", justify=tk.LEFT)
    tip_label.pack(anchor="w", pady=1)

root.mainloop()

