/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package listener;
import classe.Disciplina;
        
import javax.servlet.ServletContextEvent;
import javax.servlet.ServletContextListener;
import java.sql.*;

/**
 * Web application lifecycle listener.
 *
 * @author milena
 */
public class DbListener implements ServletContextListener {
    public static final String CLASS_NAME="org.sqlite.JDBC";
    public static final String URL="jdbc:sqlite:disciplinas.db ";
    
    public static String Message;
    public static String exceptionMessage;
    
    public static Connection getConnection() throws Exception{
     return DriverManager.getConnection(URL);
    } 

    @Override
    public void contextInitialized(ServletContextEvent sce) {
        Connection con = null;
        Statement stmt = null;
        
        try{
          Class.forName(CLASS_NAME);
          con = DriverManager.getConnection(URL);
          Message = "funcionou!!";
          stmt = con.createStatement();
                    Message += " funcionou 1";

          stmt.execute(Disciplina.getCreateStatement());
                    Message += " funcionou 2";
                    
              if(Disciplina.getList().isEmpty()){
                            Message += " funcionou 3";

              }      
            
            
        }catch(Exception ex){
            exceptionMessage = ex.getLocalizedMessage();
            
        }finally{
            try{stmt.close();}catch(Exception ex2){}
            try{con.close();}catch(Exception ex2){}
        }
    }

    @Override
    public void contextDestroyed(ServletContextEvent sce) {
    }
}









