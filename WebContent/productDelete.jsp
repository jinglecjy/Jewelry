<%@ page language="java" import="java.util.*,java.sql.*"  
    contentType="text/html; charset=utf-8"
    pageEncoding="utf-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<%! public static boolean isInteger(String value) {
	  try {
		   Integer.parseInt(value);
		   return true;
		  } catch (NumberFormatException e) {
		   return false;
		  }
		 } %>
<html>
<head>
<meta charset="UTF-8">
<title>删除商品|银心银饰</title>
<% 
	String admin_cid = null;
	if(session.getAttribute("id") != null)
		admin_cid = session.getAttribute("id").toString(); // 登录界面跳转后传递用户cid 
	if(admin_cid != "1"){
		response.sendRedirect("index.jsp"); 
		return;
	}
 	request.setCharacterEncoding("UTF-8");
	String pname=request.getParameter("pname");
 	String msg="";
	String connectString = "jdbc:mysql://172.18.187.234:3306/14353007"
			+ "?autoReconnect=true&useUnicode=true"
			+ "&characterEncoding=UTF-8"; 
	Class.forName("com.mysql.jdbc.Driver");
	Connection conn = DriverManager.getConnection(connectString, "user", "123");
	Statement stmt = conn.createStatement();
	try{
		if(pname.equals("") || pname == null){
			msg = "商品编号不允许为空，操作失败！";
		}
		else{
			String fmt="delete from product where pname=\'"+pname+"\';";
			String sql = String.format(fmt, pname);
			int cnt = stmt.executeUpdate(sql);
			if(cnt>0) msg = "删除商品成功！";
			else msg = "不存在该商品！";
		}
		stmt.close();
		conn.close();
	}catch(Exception e){
		msg = e.getMessage();
	}
%>
<style>
body {
	margin-top: 50px;
}
input {
	margin-left: 100px;
}
p {
	text-align: center;
	color: #9D0D0C;
    font-weight: bold;
}
</style>

</head>
<body>
	<p><%=msg %></p> <br><br>
	<input type="button" name="close" value="确定" onclick="window.close();" /> 
</body>
</html>