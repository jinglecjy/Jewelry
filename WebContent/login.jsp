<%@ page language="java" import="java.util.*,java.sql.*"  
    contentType="text/html; charset=utf-8"
    pageEncoding="utf-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<link rel="shortcut icon" href="images/logo_icon.ico" type="image/x-icon" />
<link rel="icon" href="images/logo_icon.ico" type="image/x-icon" />
<title>登录 | Jewelry</title> 
<style>
	#logo, #login, #login_user, #login_password, #login_submit {
		margin: 0 auto;
		width: 250px;
	}
	body {
		background-color: #D65A6F;
	}
	#logo{
		margin-top: 100px;
	}
	input:not(#login_submit) {
		height:30px;
		box-shadow: inset 1px 1px 1px #AAA;
		margin-top: 10px;
		text-align: center;
	}
	input#login_submit {
		height:40px;
		text-align:center;
		margin-top: 20px;
	}
	#state_box {
		height:10px;
		margin-top: 20px;
	}
	#state {
		text-align:center;
		color:black;
		/* border:solid 2px #EEEEEE; */
	}
	#shadow {
		width:200px;
		height:1px;
		margin:0 auto;
		border:solid 1px #9D0D0C;
		background-color:#9D0D0C;
		box-shadow:5px 5px 10px #9D0D0C;
	}
</style>
</head>
<body>
	<div id="logo">
		<img src="images/logo.png">
	</div>
	<div id="main">
	<%
		String Button = request.getParameter("login_submit");
		request.setCharacterEncoding("utf-8");
		String login_user = request.getParameter("login_user"); if(login_user==null) login_user="";
		String login_password = request.getParameter("login_password"); if(login_password==null) login_password="";
	%>
	
		<div id="login">
			<form action="login.jsp" method="post">
				<input id="login_user" type="text" name="login_user" placeholder="用户名" value=<%=login_user %>>
				<input id="login_password" type="password" name="login_password" placeholder="密码" value=<%=login_password %>>
				<br><input id="login_submit" type="submit" name="login_submit" value="登录">
			</form>
		</div>
		<%
		if (Button != null) {
			String connectString = "jdbc:mysql://localhost:3306/jewelry" + "?autoReconnect=true&useUnicode=true"
					+ "&characterEncoding=UTF-8";
			try {
				Class.forName("com.mysql.jdbc.Driver");
				Connection con = DriverManager.getConnection(connectString, "root", "root");
				Statement stmt = con.createStatement();
				String sql = String.format("select * from customer where cname = '%s'", login_user);
				ResultSet rs =  stmt.executeQuery(sql);
				if (rs.next()) {
					if (rs.getString("cpwd").equals(login_password)) {
						session.setAttribute("id", rs.getInt("cid"));
						response.sendRedirect("index.jsp");
					}
					else {
		%>
						<div id="state_box">
							<p id="state" style="width:9em;">用户名或密码出错！</p>
							<p id="shadow"></p>
						</div>
		<%
					}
				}
				else {
		%>
						<div id="state_box">
							<p id="state" style="width:6em;">您尚未注册！</p>
							<p id="shadow"></p>
						</div>
		<%
				}
				rs.close();
				stmt.close();
				con.close();
			} catch (Exception e) {
				System.out.println(e.getMessage());
			}
		}
		%>
		<!-- end of login -->
	</div>
	<!-- end of main -->
	<%@include file="footer.jsp" %>
</body>
</html>