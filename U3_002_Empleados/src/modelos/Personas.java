/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */

package modelos;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.util.logging.Level;
import java.util.logging.Logger;

/**
 *
 * @author Juan Yáñez (Brujo)
 */
public class Personas {
    
    private String rut;
    private String nombre;
    private String apellido;
    
    // Se agregan los 3 objetos
    
    private Connection con;     // Permite conectar BD
    private Statement state;    // Permite ejecutar Query
    private ResultSet res;      // Permite guardar una consulta de Select (arreglo)

    public Personas(String rut, String nombre, String apellido) {
        try {
            this.rut = rut;
            this.nombre = nombre;
            this.apellido = apellido;
            
            Class.forName("com.mysql.jdbc.Driver"); //Driver
            
            con = DriverManager.getConnection("jdbc:mysql://localhost:3306/Empleados?zeroDateTimeBehavior=convertToNull",
                    "root",
                    "jBy=Flash"); // URL user pass
        } catch (ClassNotFoundException | SQLException ex) {
            Logger.getLogger(Personas.class.getName()).log(Level.SEVERE, null, ex);
        }
    }

    public Personas(String rut) {
        this.rut = rut;
    }

    public Personas() {
    }

    public String getRut() {
        return rut;
    }

    public void setRut(String rut) {
        this.rut = rut;
    }

    public String getNombre() {
        return nombre;
    }

    public void setNombre(String nombre) {
        this.nombre = nombre;
    }

    public String getApellido() {
        return apellido;
    }

    public void setApellido(String apellido) {
        this.apellido = apellido;
    }

    public Connection getCon() {
        return con;
    }

    public void setCon(Connection con) {
        this.con = con;
    }

    public Statement getState() {
        return state;
    }

    public void setState(Statement state) {
        this.state = state;
    }

    public ResultSet getRes() {
        return res;
    }

    public void setRes(ResultSet res) {
        this.res = res;
    }
    
    

}
