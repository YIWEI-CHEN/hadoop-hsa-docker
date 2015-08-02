import java.io.*;
import java.net.*;
import java.util.*;

public class runstart{
    public static void main(String[] args) throws Exception{
        String host = args[0];
        String slaveId = args[1];
        String deviceType = args[2];
        Process pl = Runtime.getRuntime().exec("/bin/bash start-node.sh " + host + 
                " " + slaveId + " " + deviceType);
        String line = "";
        BufferedReader p_in = new BufferedReader(new InputStreamReader(pl.getInputStream()));
        while((line = p_in.readLine()) != null){
            System.out.println(line);
                                                    
        }
        p_in.close();
    }
}
