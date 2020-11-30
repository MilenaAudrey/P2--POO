<%-- 
    Document   : disciplina
    Created on : 30 de nov de 2020, 13:48:40
    Author     : milen
--%>
<%@page import="classe.Disciplina" %>
<%@page import="listener.DbListener" %>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<%
    String exceptionMessage = null;
    if(request.getParameter("Cancelar")!=null){
        response.sendRedirect(request.getRequestURI());
    }
   if(request.getParameter("formInserir")!=null){
       try{
       String nome = request.getParameter("nome");
       String ementa = request.getParameter("ementa");
       int ciclo = Integer.parseInt(request.getParameter("ciclo"));
       double nota = Double.parseDouble(request.getParameter("nota"));
       Disciplina.InserirDisciplina(nome, ementa, ciclo, nota);
       
        response.sendRedirect(request.getRequestURI());
       }catch(Exception ex){
           exceptionMessage = ex.getLocalizedMessage();
       } 
   }
   if(request.getParameter("formExcluir")!= null){
       try{
       String nome = request.getParameter("nome");
            Disciplina.ExcluirDisciplina(nome);
        response.sendRedirect(request.getRequestURI());
       }catch(Exception ex){
           exceptionMessage = ex.getLocalizedMessage();
       } 
   }
   
    try{
        if(request.getParameter("nota")!= null ){
        double nota = Double.parseDouble(request.getParameter("no"));
        String nome = request.getParameter("nome2");
        Disciplina.AlterarNota(nome, nota);
        }
    }catch(Exception ex){
        exceptionMessage = ex.getLocalizedMessage();
    }
%>
<html>
    <head>
        
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
     
         <title>Página Inicial </title>
        
    </head>
    <body>

        <%@include file="WEB-INF/jspf/menu.jspf" %>

        
            <h1>Disciplinas</h1>
            
         <%if(request.getParameter("PrepararInsert")!=null){%>
         <fieldset>
             <legend>Inserir Disciplina</legend>
         <form method="post">
             <div>Nome da disciplina </div>
             
             <div><input type="text" name="nome"></div>
             
             <div>Ementa</div>
             
             <div><input type="text" name="ementa"/></div>
             
             <div>Ciclo</div>
             
             <div>
                 <input type="number" name="ciclo" min="1" max="6">
             </div>
             
              <div>Nota</div>
             
             <div>
                 <input type="number" name="nota"  step="0.01" min="0.00" max="10.00"/>
             </div>
             
             <hr/>
             <input type="submit" name="formInserir" value="Inserir Disciplina"/>
             <input type="submit" name="Cancelar" value="Cancelar"/>

         </form>
         </fieldset>
           
         
        <%}else if(request.getParameter("PrepararDelete")!= null){%>
                <fieldset>
             <legend>Excluir disciplina</legend>
             <%String nome = request.getParameter("nome");%>
             <br>
         <form method="post">
             <div>Deseja realmente excluir a Disciplina <b><%=nome %></b>?</div>
             <br>
             <div><input type="hidden" name="nome" value="<%=nome%>"/></div>
             <input type="submit" name="formExcluir" value="Excluir disciplina"/>
             <input type="submit" name="Cancelar" value="Cancelar"/>
             <br>
             <br>
         </form>
         </fieldset>
             
    

              <%}else if(request.getParameter("PrepararNota")!= null){%>
                <fieldset>
             <legend>Alterar Nota</legend>
             <%String nome = request.getParameter("nome");%>
             <br>
        <form method="post">
            <div> Insira a nova nota para a disciplina <b><%= nome%></b></div>
            <br>
            <div><input type="hidden" name="nome2" value="<%=nome%>"></div>
                    <input type="number" name="n" step="0.01" min="0.00" max="10.00">
                    <input type="submit" name="nota" value="Confirmar">
                    <input type="submit" name="Cancelar" value="Cancelar"/>
                    <br>
                    <br>
                </form>
         </fieldset>

            <%}else{%>
            
             <form method="post">
                
                <input type="submit" name="PrepararInsert" value="adicionar disciplina">
            </form>
            <%}%>
            
    <table border="3" >
        <tr>
            <th>Disciplina</th>
            <th>Ementa</th>
            <th>Ciclo</th>
            <th>Nota</th>
            <th style="text-align: center">Comandos</th>
        </tr>        
       
        <%for(Disciplina disc:Disciplina.getList()){%>
        <tr>
            <td><%=disc.getNome() %></td>
            <td><%=disc.getEmenta() %></td>
            <td><%=disc.getCiclo() %></td>
            <td><%=disc.getNota() %></td>
            <td>
                <form method="post">
                     <input type="hidden" name="nome" value="<%=disc.getNome() %>">
                     <div><input type="submit" name="PrepararDelete" value="Excluir Disciplina"></div>
                     <div><input type="submit" name="PrepararNota" value="Alterar Nota"></div>
                </form>
            </td>
        </tr>
        <%}%>
    </table>

        
    </body>
        
</html>
