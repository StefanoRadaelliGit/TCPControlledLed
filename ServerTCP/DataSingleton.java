import java.net.Socket;
import java.util.HashMap;

class DataSingleton {
	
	private static DataSingleton instance=null;
	private HashMap<String,Socket> data = new HashMap<String,Socket>();
	
	public static DataSingleton getInstance() {
		if(instance==null) {
			synchronized (DataSingleton.class) {
				if(instance==null)
					instance = new DataSingleton();
			}
		}
		return instance;
	}
	
	public synchronized void setData(String str, Socket socket) {
		data.put(str, socket);
	}
	
	public Socket getData(String str) {
		return data.get(str);
	}
}
