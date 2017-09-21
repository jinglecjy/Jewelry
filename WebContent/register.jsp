<%@ page language="java" import="java.util.*,java.sql.*"  
    contentType="text/html; charset=utf-8"
    pageEncoding="utf-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta charset="UTF-8">
<link rel="shortcut icon" href="images/logo_icon.ico" type="image/x-icon" />
<link rel="icon" href="images/logo_icon.ico" type="image/x-icon" />

<title>注册 | Jewelry</title> 
<style>
	#logo, #register_user, #register_phone, #register_new_password, 
	#register_confirm_password, #register_submit {
		margin: 0 auto;
		width: 250px;
	}
	body {
		background-color: #D65A6F;
	}
	#logo{
		margin-top: 100px;
	}

	input:not(#register_submit) {
		height:30px;
		text-align:center;
		box-shadow:3px 3px 2px #a0a0a0, inset 1px 1px 1px #a0a0a0, 4px 4px 1px #9D0D0C;
	}
	input#register_submit {
		height:40px;
		text-align:center;
		box-shadow:2px 2px 2px #808080;
	}
	textarea {
		height:30px;
		border-radius:5px;
		text-align:center;
		box-shadow:3px 3px 2px #808080, inset 1px 1px 1px #808080, 4px 4px 1px #9D0D0C;
	}

	#state_box {
		height:10px;
	}
	#state {
		text-align:center;
		color:black;
	}
	#shadow {
		height:1px;
		border:solid 1px #9D0D0C;
		background-color:#9D0D0C;
		box-shadow:5px 5px 10px #9D0D0C;
	}
	
</style>
</head>
<body>
	<div id="main">
		<div id="logo">
			<img src="images/logo.png">
		</div>
	    <%
		String Button = request.getParameter("register_submit");
		request.setCharacterEncoding("utf-8");
		String register_user = request.getParameter("register_user"); if (register_user == null) register_user = "";
		String register_phone = request.getParameter("register_phone"); if (register_phone == null) register_phone = "";
		String register_address = request.getParameter("register_address"); if (register_address == null) register_address = "";
		String register_new_password = request.getParameter("register_new_password"); if (register_new_password == null) register_new_password = "";
		String register_confirm_password = request.getParameter("register_confirm_password"); if (register_confirm_password == null) register_confirm_password = "";
		
		if (Button != null) {
				if ((!register_user.equals("")) && (!register_phone.equals("")) && (!register_address.equals("")) && (!register_new_password.equals("")) && (!register_confirm_password.equals(""))) {
				if (register_confirm_password.equals(register_new_password)) {
					String connectString = "jdbc:mysql://localhost:3306/jewelry" + "?autoReconnect=true&useUnicode=true"
							+ "&characterEncoding=UTF-8";
					Connection con;
					try {
						Class.forName("com.mysql.jdbc.Driver");
						con = DriverManager.getConnection(connectString, "root", "root");
						Statement stmt = con.createStatement();
						String sql = String.format("insert into customer(cname, cpwd, caddr, cphone) values ('%s', '%s', '%s', '%s');", register_user, register_confirm_password, register_address, register_phone);
						int result = stmt.executeUpdate(sql);
						if (result > 0) {
							response.sendRedirect("login.jsp");
						}
						else {
		%>
							<div id="state_box">
								<p id="state" style="width:13em;">注册失败，请重新进行注册！</p>
								<p id="shadow"></p>
							</div>
		<%
						}
						  stmt.close();
						  con.close();
					} catch (Exception e) {
						out.write(e.getMessage());
		%>
						<div id="state_box">
							<p id="state" style="width:13em;">注册失败，请重新进行注册！</p>
							<p id="shadow"></p>
						</div>
		<%
					} finally {
						
					}
					
				}
				else {
		%>		
					<div id="state_box">
						<p id="state" style="width:6em;">密码不一致！</p>
						<p id="shadow"></p>
					</div>
		<%
				}
			}
			else {
		%>
				<div id="state_box">
					<p id="state" style="width:9em;">请完善个人信息！</p>
					<p id="shadow"></p>
				</div>
		<%
			}
		}
		%>
	
		<form action="register.jsp" method="post">
			用户<input id="register_user" type="text" name="register_user" placeholder="请输入用户名！" value=<%=register_user %>></input><br><br>
			电话<input id="register_phone" type="text" name="register_phone" placeholder="请输入联系电话！" value=<%=register_phone %>></input><br><br>
			地址<textarea id="register_address" name="register_address" placeholder=" 请输入联系地址！" rows="1" cols="15" ><%=register_address %></textarea>
			新密码<input id="register_new_password" type="password" name="register_new_password" placeholder="请输入密码！" value=<%=register_new_password %>></input><br><br>
			确认密码<input id="register_confirm_password" type="password" name="register_confirm_password" placeholder="请确认密码!" value=<%=register_confirm_password %>></input><br><br>
			<input id="register_submit" name="register_submit" type="submit" value="注册"/>
		</form>
		<!-- end of register -->
	</div>
	<!-- end of main -->
</body>
</html>