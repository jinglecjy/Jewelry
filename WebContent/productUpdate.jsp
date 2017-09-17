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
<title>更新商品信息|银心银饰</title>
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
	String pprice=request.getParameter("pprice");
	String pclass=request.getParameter("pclass");
	String pclasses[] = {"", "", "", ""};
	String plink=request.getParameter("plink");
 	String msg="";
	String connectString = "jdbc:mysql://172.18.187.234:3306/14353007"
			+ "?autoReconnect=true&useUnicode=true"
			+ "&characterEncoding=UTF-8"; 
	Class.forName("com.mysql.jdbc.Driver");
	Connection conn = DriverManager.getConnection(connectString, "user", "123");
	Statement stmt = conn.createStatement();
	if(request.getMethod().equalsIgnoreCase("post")){
		try{
			boolean isNum = isInteger(pprice);
			if(pname.equals("") || pprice.equals("") || pclass.equals("") || plink.equals("")){
				msg = "所有项都不允许为空，操作失败！";
			}
			else if(!isNum){
				msg = "价格输入必须为数字，操作失败！";
			}
			else{
				String fmt="update product set pprice="+pprice+", pclass=\'"+pclass+"\', plink=\'"+plink
						+"\' where pname=\'"+pname+"\';";
				String sql = String.format(fmt, pname, pprice, pclass, plink);
				int cnt = stmt.executeUpdate(sql);
				if(cnt>0) msg = "更新商品信息成功！";
			}
			stmt.close();
			conn.close();
		}catch(Exception e){
			msg = e.getMessage();
		}
	}
	else if(!pname.equals("")){
		try{
			String fmt="select * from product where pname=\'"+pname+"\';";
			String sql = String.format(fmt, pname, pprice, pclass, plink);
			ResultSet rs=stmt.executeQuery(sql);
			if(rs.next()){
				  pprice = rs.getString("pprice");
				  pname = rs.getString("pname");
				  pclass = rs.getString("pclass");
				  plink = rs.getString("plink");
			}
			if(pclass.equals("ring")) pclasses[0] = "checked";
			else if(pclass.equals("earring")) pclasses[1] = "checked";
			else if(pclass.equals("bracelent")) pclasses[2] = "checked";
			else if(pclass.equals("necklace")) pclasses[3] = "checked";
			stmt.close();
			conn.close();
		}catch(Exception e){
			msg = e.getMessage();
		}
	}else{
		pname = "";
		pprice = "";
		pclass = "";
		plink = "";
	}
%>
<style>
body {
	margin-top: 50px;
}
input[type="text"] {
	width: 450px;
}
button {
	margin-left: 230px;
}
p {
	text-align: center;
	color: #9D0D0C;
    font-weight: bold;
}
b {
	font-weight: bold;
}
</style>

</head>
<body>
<form action="productUpdate.jsp" method="post">
	<b>商品编号：</b><input type="text" name="pname" value=<%=pname %>> <br><br>
	<b>商品价格：</b><input type="text" name="pprice" value=<%=pprice %>> <br><br>
	<b>商品分类：</b>
		<input type="radio" name="pclass" value="ring" <%=pclasses[0] %>>戒指 
		<input type="radio" name="pclass" value="earring" <%=pclasses[1] %>>耳环 
		<input type="radio" name="pclass" value="bracelent" <%=pclasses[2] %>>手镯 
		<input type="radio" name="pclass" value="necklace" <%=pclasses[3] %>>项链 <br><br>
	<b>图片链接：</b><input type="text" name="plink" value=<%=plink %>> <br><br>
	<button type="submit" name="login">提交</button> &nbsp&nbsp&nbsp&nbsp&nbsp
	<input type="button" name="close" value="取消" onclick="window.close();" /> <br>
	<p><%=msg %></p>
</form>
</body>
</html>