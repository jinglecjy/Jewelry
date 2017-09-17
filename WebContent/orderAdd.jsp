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
<title>添加订单|银心银饰</title>
<% 
	String admin_cid = null;
	if(session.getAttribute("id") != null)
		admin_cid = session.getAttribute("id").toString(); // 登录界面跳转后传递用户cid 
	if(admin_cid != "1"){
		response.sendRedirect("index.jsp"); 
		return;
	}
 	request.setCharacterEncoding("UTF-8");
	String oid=request.getParameter("oid");
	String cid=request.getParameter("cid");
	String pid=request.getParameter("pid");
	String num=request.getParameter("num");
	String sumprice=request.getParameter("sumprice");
 	String msg="";
	String connectString = "jdbc:mysql://172.18.187.234:3306/14353007"
			+ "?autoReconnect=true&useUnicode=true"
			+ "&characterEncoding=UTF-8"; 
	if(request.getMethod().equalsIgnoreCase("post")){
		Class.forName("com.mysql.jdbc.Driver");
		Connection conn = DriverManager.getConnection(connectString, "user", "123");
		Statement stmt = conn.createStatement();
		try{
			boolean isNum = isInteger(num);
			if(!sumprice.equals("") && sumprice != null)isNum = isNum? isInteger(sumprice):isNum;
			if(cid.equals("") || pid.equals("") || num.equals("")){
				msg = "除订单编号和总价外均不允许为空，操作失败！";
			}
			else if(!isNum){
				msg = "数量和总价必须为数字，操作失败！";
			}
			else{
				if(sumprice.equals("")){
					String sql="select * from product where pid=\'"+pid+"\';";
					ResultSet rs=stmt.executeQuery(sql);
					String pprice="0";
					if(rs.next()){
						  pprice = rs.getString("pprice");					  
					}
					int all_price =  Integer.parseInt(pprice) *  Integer.parseInt(num);
					sumprice = ""+all_price;
				}
				String fmt, sql;
				if(oid.equals("") || oid==null){
					fmt="insert into orders(cid, pid, num, sumprice) values('%s', '%s', '%s', '%s')";
					sql = String.format(fmt, cid, pid, num, sumprice);
				}
				else {
					fmt="insert into orders(oid, cid, pid, num, sumprice) values('%s', '%s', '%s', '%s', '%s')";
					sql = String.format(fmt, oid, cid, pid, num, sumprice);
				}
				int cnt = stmt.executeUpdate(sql);
				if(cnt>0){
					msg = "增加订单成功！";
				}
				else {
					msg = "增加订单失败！";
				}
			}
			stmt.close();
			conn.close();
		}catch(Exception e){
			msg = e.getMessage();
		}
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
<p>*除订单编号和商品总价外均不许为空</p>
<form action="orderAdd.jsp" method="post">
	<b>订单编号：</b><input type="text" name="oid" value=<%=oid %>> <br><br>
	<b>客户编号：</b><input type="text" name="cid"> <br><br>
	<b>商品编号：</b><input type="text" name="pid"> <br><br>
	<b>商品数量：</b><input type="text" name="num"> <br><br>
	<b>商品总价：</b><input type="text" name="sumprice"> <br><br>
	<button type="submit" name="login">提交</button> &nbsp&nbsp&nbsp&nbsp&nbsp
	<input type="button" name="close" value="取消" onclick="window.close();" /> <br>
	<p><%=msg %></p>
</form>
</body>
</html>