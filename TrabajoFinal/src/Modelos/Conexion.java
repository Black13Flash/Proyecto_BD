/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */

package Modelos;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.SQLException;
import java.util.logging.Level;
import java.util.logging.Logger;

/**
 *
 * @author Juan Yáñez (Brujo)
 */
public class Conexion {
    private Connection con;

    public Conexion() {
        
        try {
            String url="jdbc:mysql://localhost:3306/TrabajoFinal?zeroDateTimeBehavior=convertToNull";
            Class.forName("com.mysql.jdbc.Driver"); // Driver de Conexión
            con = DriverManager.getConnection(url, "admin_TrabajoFinal", ""); // URL,user,pass
        } catch (ClassNotFoundException | SQLException ex) {
            Logger.getLogger(Conexion.class.getName()).log(Level.SEVERE, null, ex);
        }
    }
    
    public Connection usaConexion(){
        return con;
    }
    
    public void cierraConexion(){
        try {
            con.close();
        } catch (SQLException ex) {
            Logger.getLogger(Conexion.class.getName()).log(Level.SEVERE, null, ex);
        }
    }
    

}
