import RPi.GPIO as GPIO # Import Raspberry Pi GPIO library
import time
import subprocess
import lcddriver

import psutil

display = lcddriver.lcd()

time.sleep(10) 

proc = subprocess.Popen([sclang, homepiDesktopsound.scd])


killedx = False

def kill(proc_pid)
    process = psutil.Process(proc_pid)
    for proc in process.children(recursive=True)
        proc.kill()
    process.kill()


        
GPIO.setwarnings(False) # Ignore warning for now
GPIO.setmode(GPIO.BCM) # Use physical pin numbering
GPIO.setup(21, GPIO.IN, pull_up_down=GPIO.PUD_UP) # Set pin 10 to be an input pin and set initial value to be pulled low (off)




def button_callback(channel)
    if GPIO.input(21) == GPIO.LOW
        print(button pressed)
        global killedx
        killedx = True
        display.lcd_clear()
        display.lcd_display_string(restarting, 1)
        kill(proc.pid)
    

GPIO.add_event_detect(21,GPIO.FALLING,callback=button_callback) # Setup event on pin 10 risingedge

while True
    if killedx == True
        time.sleep(5)
        killedx = False
        proc = subprocess.Popen([sclang, homepiDesktopexperiment-Copy.scd])
