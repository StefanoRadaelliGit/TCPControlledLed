import java.io.*;
import java.net.*;
import java.util.Scanner;

public class ErogaServizio extends Thread {
	
	private Socket toClient;
	private boolean exit = false;
	
	public ErogaServizio(Socket ssClient) {
		toClient = ssClient;
	}
	
	public void run() {
		PrintWriter output = null;
        Scanner input = null;
        String msg1 = null;
        String msg2 = null;

        try {
			input = new Scanner(toClient.getInputStream());
		} catch (IOException e2) {
			e2.printStackTrace();
		}
        try {
			output = new PrintWriter(toClient.getOutputStream(), true);
		} catch (IOException e1) {
			e1.printStackTrace();
		}
        
        msg1 = input.nextLine();
        DataSingleton.getInstance().setData(msg1, toClient);
        output.println("kk");
        System.out.println("Connesso dispositivo di tipo " + msg1);
        System.out.println("Socket: " + toClient);

        do {
        	switch(msg1) {
        	case "Client":
        		if(!toClient.equals(DataSingleton.getInstance().getData("Client"))) {
        			exit = true;
        			break;
        		}
        		try {
        			msg2 = input.nextLine();
        		} catch (Exception e) {
        			break;
        		}
        		System.out.println("Message received: " + msg2);
        		Socket node = DataSingleton.getInstance().getData("Node");
        		if(node==null) {
        			System.out.println("No Node found");
        			msg2 = "No Node found";
        		} else {
        			try {
        				output = new PrintWriter(node.getOutputStream(), true);
        				output.println(msg2);
        			} catch (IOException e1) {
        				e1.printStackTrace();
        			}
        			System.out.println("Sent");
        		}
        		try {
    				output = new PrintWriter(toClient.getOutputStream(), true);
    				output.println(msg2);
    			} catch (IOException e1) {
    				e1.printStackTrace();
    			}
        		break;
        	case "Node":
        		if(!toClient.equals(DataSingleton.getInstance().getData("Node"))) {
        			exit = true;
        		}
        		break;
        	}
        	if("bye".equals(msg2) || exit==true) break;
        } while (true);
        try {
			toClient.close();
			System.out.println("Connessione chiusa con " + toClient);
		} catch (IOException e) {
			e.printStackTrace();
		}
	}

}