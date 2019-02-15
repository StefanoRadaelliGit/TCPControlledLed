import java.io.*;
import java.net.*;

public class Server {

	public static void main(String[] args) {
		ServerSocket sServer = null;
		Socket sClient = null;
		try {
			sServer = new ServerSocket(56666);
		} catch (IOException e) {
			e.printStackTrace();
		}
		System.out.println("Server acceso, porta " + sServer.getLocalPort());
		try {
			while(true) {
				try {
					sClient = sServer.accept();
				} catch (IOException e) {
					e.printStackTrace();
				}
				Thread t = new ErogaServizio(sClient);
				t.start();
			}
		} catch(Exception e) {
			e.printStackTrace();
		} finally {
			try {
				sServer.close();
			} catch (IOException e) {
				e.printStackTrace();
			}
		}
	}
}