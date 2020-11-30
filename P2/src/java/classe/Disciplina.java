/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package classe;
import java.util.ArrayList;
import listener.DbListener;
import java.sql.*;
/**
 *
 * @author milena
 */
public class Disciplina {
       private String nome;
     private String ementa;
     private int ciclo;
    private double nota;

    public Disciplina(String nome, String ementa, int ciclo, double nota) {
        this.nome = nome;
        this.ementa = ementa;
        this.ciclo = ciclo;
        this.nota = nota;
    }

    
   

    public String getNome() {
        return nome;
    }

    public void setNome(String nome) {
        this.nome = nome;
    }

    public String getEmenta() {
        return ementa;
    }

    public void setEmenta(String ementa) {
        this.ementa = ementa;
    }

    public int getCiclo() {
        return ciclo;
    }

    public void setCiclo(int ciclo) {
        this.ciclo = ciclo;
    }

    public double getNota() {
        return nota;
    }

    public void setNota(double nota) {
        this.nota = nota;
    }
 public static ArrayList<Disciplina> getList() throws Exception{
        ArrayList<Disciplina> list = new ArrayList<>();
        Connection con = DbListener.getConnection();
        Statement stmt = con.createStatement();
        ResultSet rs = stmt.executeQuery("SELECT * FROM disciplinas");
        while(rs.next()){
            list.add(new Disciplina(
                    rs.getString("nome"),
                    rs.getString("ementa"),
                    rs.getInt("ciclo"),
                    rs.getDouble("nota")
            ));
        }
        rs.close();
        stmt.close();
        con.close();
        return list;
    }
   public static void InserirDisciplina(String nome, String ementa, int ciclo, double nota) throws Exception{
        Connection con = DbListener.getConnection();
        PreparedStatement stmt = con.prepareStatement
        ("INSERT INTO disciplinas VALUES(?,?,?,?)");
        stmt.setString(1, nome);
        stmt.setString(2, ementa);
        stmt.setInt(3, ciclo);
        stmt.setDouble(4, nota);
        stmt.execute();
        stmt.close();
        con.close();
    }
      
     public static void ExcluirDisciplina(String nome) throws Exception{
        Connection con = DbListener.getConnection();
        PreparedStatement stmt = con.prepareStatement ("DELETE FROM disciplinas WHERE nome = ?");
        stmt.setString(1, nome);
        stmt.execute();
        stmt.close();
        con.close();
    }
      public static void AlterarNota(String nome, double nota) throws Exception{
        Connection con = DbListener.getConnection();
        PreparedStatement stmt = con.prepareStatement
        ("UPDATE disciplinas SET nota= ? WHERE nome = ?");
        stmt.setDouble(1, nota);
        stmt.setString(2, nome);
        stmt.execute();
        stmt.close();
        con.close();
    }

    
      
    public static String getCreateStatement (){
    
    return "CREATE TABLE IF NOT EXISTS disciplinas("
            + "nome VARCHAR (100) PRIMARY KEY,"
            + "ementa VARCHAR (300) NOT NULL,"
            + "ciclo INTEGER (2) NOT NULL,"
            + "nota NUMERIC (2,2)"
            + ")";
    }
}

