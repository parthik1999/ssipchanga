<%-- 
    Document   : mailpatientupdate
    Created on : 27 Feb, 2020, 6:24:11 PM
    Author     : Parthik Shah
--%>
<%@page import="mail.sendSMS"%>
<%@page import="mail.SendEmail"%>
<%--<%@page import="ps.SendingEmail.sendMail(String, String, String, String, String)"%>--%>
<%@page import="java.sql.*"%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>

<%
    
    
    
        session = request.getSession();
        String doctorid=(String )session.getAttribute("username");
        String name = "";
        String email="";
        String address = "";
        String phone="";
        
        String pid = request.getParameter("pid");
               
        Class.forName("com.mysql.jdbc.Driver");
        Connection con = DriverManager.getConnection("jdbc:mysql://localhost:3306/doctor","root","root");
        String sql="SELECt * from detail where username='"+doctorid+"'";
        PreparedStatement ps=con.prepareStatement(sql);
        ResultSet rs = ps.executeQuery();
        if(rs.next())
        {
              name = rs.getString(2)+"   "+rs.getString(3);
              address = rs.getString(9);
        }
        con.close();
        con = DriverManager.getConnection("jdbc:mysql://localhost:3306/patient","root","root");
        sql = "select email,phone from detail where id='"+pid+"'";
        ps=con.prepareStatement(sql);
        rs = ps.executeQuery();
        if(rs.next())
        {
              email = rs.getString(1);
              phone=rs.getString(2);
        }
        String num="91"+phone;
        SendEmail se=new SendEmail();
        String send = "<h3>You visted Doctor:"+name+"<br><br>At:"+address+"<br><br></h3><h5>"+name+" are Updated your Record</h5>";
        String msg="You visted Doctor:"+name+"At:"+address+""+name+"are Updated Your Record";
        boolean x=se.sendfile("medssip@gmail.com","medssip@123",email,send);
       // sendSMS sm=new sendSMS();
        //sm.sendSms(num,msg);
        
        
//        window.location.href="http://localhost:8084/WebApplication1/sch/profile.jsp?patientid="+val;
        if(x==true)
        {
            response.sendRedirect("http://localhost:8084/WebApplication1/sch/profile.jsp?patientid="+pid);
        }
 %>