# Simple string program. Writes and updates strings.
# Demo program for the I2C 16x2 Display from Ryanteck.uk
# Created by Matthew Timmons-Brown for The Raspberry Pi Guy YouTube channel

# Import necessary libraries for communication and display use
import lcddriver
import time
from pythonosc.dispatcher import Dispatcher
from pythonosc.osc_server import BlockingOSCUDPServer



def change_handler(address, *args):
    yes = ("  [" + str(args[0])[2] + ","+str(args[0])[5] + ","+str(args[0])[8] + ","+str(args[0])[11] + ","+str(args[0])[14] + "]")
    yes = yes.replace("0","X")
    yes = yes.replace("1","A")
    yes = yes.replace("2","B")
    yes = yes.replace("3","C")
    display.lcd_display_string(yes, 1)
    display.lcd_display_string(" "*(8-(len(str(args[1])))//2)+str(args[1]), 2)


def default_handler(address, *args):
    print(f"DEFAULT {address}: {args}")
    
dispatcher = Dispatcher()
dispatcher.map("/values", change_handler)
dispatcher.set_default_handler(default_handler)

ip = "127.0.0.1"
port = 1507



# Load the driver and set it to "display"
# If you use something from the driver library use the "display." prefix first
display = lcddriver.lcd()
display.lcd_clear()
display.lcd_display_string("loading", 1)
# Main body of code
try:
    while True:
        # Remember that your sentences can only be 16 characters long!
                                        # Give time for the message to be read
        
    
        server = BlockingOSCUDPServer((ip, port), dispatcher)
        server.serve_forever()  # Blocks forever
except KeyboardInterrupt: # If there is a KeyboardInterrupt (when you press ctrl+c), exit the program and cleanup
    print("Cleaning up!")
    display.lcd_clear()

