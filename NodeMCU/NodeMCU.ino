char* IPADDRESS = "192.168.1.9";

#include <ESP8266WiFi.h>
#include <WiFiClient.h>
#include <stdio.h>
#include <string.h>

const char* ssid = "WIFIname";
const char* pass = "Password";
const char* host = IPADDRESS;
#define red D1
#define blue D2
#define green D3
WiFiClient client;
char led;
int r = 0;
int g = 0;
int b = 0;

void setup() {
  pinMode(red, OUTPUT);
  pinMode(blue, OUTPUT);
  pinMode(green, OUTPUT);
  delay(1000);
  Serial.begin(38400);
  Serial.println();
  Serial.print("conecting to: ");
  Serial.println(ssid);
  
  WiFi.mode(WIFI_STA); 
  delay(1000);
  WiFi.begin(ssid, pass);
  //IPAddress subnet(255,255,255,0);
  //WiFi.config(IPAddress(192,168,1,150),IPAddress(192,168,1,10),subnet);
  
  while (WiFi.status() != WL_CONNECTED) {
    delay(1000);
    Serial.print(".");
  }

  Serial.println();
  Serial.print("My IP: ");
  Serial.println(WiFi.localIP());
  Serial.println("Try to connect to server: ");
  Serial.println(host);
  while (!client.connect(host,56666)) {
    Serial.print(".");
    delay(100);
  }
  client.println(("Node"));
  delay(100);
  String line = client.readStringUntil('\n');
  if(line.equals("kk")) {
    Serial.print("Conected to IP: ");
    Serial.println(host);
  }
}

void accendiLed(String line) {
  if(line.length() >= 1) {
    Serial.println(line);
    led = line.charAt(0);
     switch(led) {
       case 'r':
         r = line.substring(1).toInt();
         break;
       case 'g':
         g = line.substring(1).toInt();
         break;
       case 'b':
         b = line.substring(1).toInt();
         break;
     }
  } else {
    Serial.println("Nessun messaggio arrivato");
  }
  analogWrite(red, r);
  analogWrite(blue, g);
  analogWrite(green, b);
  Serial.print("Red, Green, blue: ");
  Serial.print(r);
  Serial.print(", ");
  Serial.print(g);
  Serial.print(", ");
  Serial.print(b);
  Serial.println(", ");
}

void loop() {
  String line;
  line = client.readStringUntil('\n');
  accendiLed(line);
}

