from gpiozero import MCP3008
from time import sleep
import alsaaudio


scanCards = alsaaudio.cards()
#print("cards:", scanCards)

for card in scanCards:
    scanMixers = alsaaudio.mixers(scanCards.index(card))
    print("mixers:", scanMixers)

m = alsaaudio.Mixer('Headphone',cardindex=1)
current_volume = m.getvolume()
pot = MCP3008(0)
#led = PWMLED(17)

minTo = 0
maxTo = 85
minFrom = 1
maxFrom = 0.0004885197850512668


#m.setvolume(50)

while True:
    #print(pot.value)
    mapped_value = minTo + (maxTo - minTo) * ((pot.value - minFrom) / (maxFrom - minFrom))
    #print(mapped_value)
    m.setvolume(int(mapped_value))

#print(pot.value)
sleep(0.1)