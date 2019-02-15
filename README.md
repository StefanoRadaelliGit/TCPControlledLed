# Led NodeMCU via TCP

This repo contains codes for control leds via tcp
What do you need:
-Esp8266 (See the Fritzing schema)
-A PC with Processing
-Internet connection

###################INSTRUCTIONS#################
-Compile and run Server.java in ServerTCP
-Find the IP Address of the pc where Server.java is running
-Set IPADDRESS variable of NodeMCU.ino and AccendiLed.pde with that IP Address
-set your wifi name and password in NodeMCU.ino (ssid and pass) and load it in your esp8266, wait until Server.java prints the Node is connected
-run AccendiLed.pde
-Have fun
################################################
