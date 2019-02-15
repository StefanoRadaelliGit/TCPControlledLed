public static String IPADDRESS = "192.168.1.9";

import java.net.*;
import java.util.Scanner;
import java.io.*;
Socket sClient=null;
InetAddress ia = null;
String messaggio = null;
PrintWriter output = null;
Scanner input = null;
int page;
int red = 0;
int green = 0;
int blue = 0;
String mR="";
String mG="";
String mB="";
void setup() {
  fullScreen();
  background(50);
  connessione();
  page = 0;
}

void draw() {
  switch(page) {
    case 0:
    fill(150);
    rectMode(CORNER);
    ellipseMode(CENTER);
    rect((width/3), (1*height/10), width/3, height/8);
    rect((width/3), (4*height/10), width/3, height/8);
    rect((width/3), (7*height/10), width/3, height/8);
    fill(255,0,0);
    ellipse((width/4), ((height/16)+(1*height/10)), height/10, height/10);
    fill(0,255,0);
    ellipse((width/4), (height/16+(4*height/10)), height/10, height/10);
    fill(0,0,255);
    ellipse((width/4), (height/16+(7*height/10)), height/10, height/10);
    if(mousePressed && (mouseButton == LEFT) && mouseX>=width/3 && mouseX<=width/3+width/3 && mouseY>=(1*height/10) && mouseY<=(1*height/10)+height/8) {
      red = mouseX-(width/3);
      int misura = red*255/(width/3);
      invia("r" +new Integer(misura).toString());
      //mR = messaggio;
    }
    if(mousePressed && (mouseButton == LEFT) && mouseX>=width/3 && mouseX<=width/3+width/3 && mouseY>=(4*height/10) && mouseY<=(4*height/10)+height/8) {
      green = mouseX-(width/3);
      int misura = green*255/(width/3);
      invia("g" +new Integer(misura).toString());
      //mG = messaggio;
    }
    if(mousePressed && (mouseButton == LEFT) && mouseX>=width/3 && mouseX<=width/3+width/3 && mouseY>=(7*height/10) && mouseY<=(7*height/10)+height/8) {
      blue = mouseX-(width/3);
      int misura = blue*255/(width/3);
      invia("b" +new Integer(misura).toString());
      //mB = messaggio;
    }
    fill(255,0,0);
    rect((width/3), (1*height/10), red, height/8);
    fill(0,255,0);
    rect((width/3), (4*height/10), green, height/8);
    fill(0,0,255);
    rect((width/3), (7*height/10), blue, height/8);
    /*fill(255);
    textAlign(LEFT);
    textSize(height/30);
    text(mR + " " + red, width/3, height/11);
    text(mG + " " + green, width/3, 4*height/11);
    text(mB + " " + blue, width/3, 7*height/11);*/
    break;
  }
}

void connessione() {
    try {
      ia = InetAddress.getByName(IPADDRESS);
    } catch (UnknownHostException e) {
      e.printStackTrace();
    }
    int port = Integer.parseInt("56666");
    InetSocketAddress isa = new InetSocketAddress(ia, port);
    sClient = new Socket();
    try {
      sClient.connect(isa);
    } catch (IOException e) {
      e.printStackTrace();
    }
    try {
      output = new PrintWriter(sClient.getOutputStream(), true);
      output.println("Client");
    } catch (IOException e1) {
      e1.printStackTrace();
    }
    try {
      input = new Scanner(sClient.getInputStream());
      messaggio = input.nextLine();
    } catch (IOException e2) {
      e2.printStackTrace();
    }
}

void invia(String risposta) {
  try {
    output = new PrintWriter(sClient.getOutputStream(), true);
    output.println(risposta);
  } catch (IOException e1) {
    e1.printStackTrace();
  }
  try {
    input = new Scanner(sClient.getInputStream());
    messaggio = input.nextLine();
    if(messaggio.contains("not")) {
      }else {
        messaggio="Inviato con successo";
      }
  } catch (IOException e2) {
    e2.printStackTrace();
  }
}
