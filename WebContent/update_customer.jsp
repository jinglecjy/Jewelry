<%@ page language="java" import="java.util.*,java.sql.*"  
    contentType="text/html; charset=utf-8"
    pageEncoding="utf-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta charset="UTF-8">
<link rel="shortcut icon" href="images/logo_icon.ico" type="image/x-icon" />
<link rel="icon" href="images/logo_icon.ico" type="image/x-icon" />
<link rel="stylesheet" type="text/css" href="font-awesome-4.7.0/css/font-awesome.css" />
<link rel="stylesheet" type="text/css" href="font-awesome-4.7.0/css/font-awesome.min.css" />
<link rel="stylesheet" href="css/header1.css">
<link rel="stylesheet" href="css/header.css">
<link rel="stylesheet" href="css/index_main.css">
<link rel="stylesheet" href="css/footer.css">
<script type="text/javascript" src="js/nav.js"></script>
<script type="text/javascript" src="js/ad.js"></script>

<!-- v3:修改title -->
<title>用户中心|银心银饰</title> 
<%  /* v3: 动态显示当前用户名 */
	String cid = null;
	if(session.getAttribute("id") != null)
		cid = session.getAttribute("id").toString(); // 登录界面跳转后传递用户cid 
	String notLogin = "style=\"display:block\"";
	String Login = "style=\"display:none\"";
	String userName = "";
	String msg ="";
	if(cid != null){
		request.setCharacterEncoding("utf-8");
		String connectString = "jdbc:mysql://172.18.187.234:3306/14353007"
						+ "?autoReconnect=true&useUnicode=true"
						+ "&characterEncoding=UTF-8"; 
		try{
		  Class.forName("com.mysql.jdbc.Driver");
		  Connection con=DriverManager.getConnection(connectString, 
		                 "user", "123");
		  Statement stmt=con.createStatement();
		  ResultSet rs=stmt.executeQuery("select cname from customer where cid="+cid+";");
		  if(rs.next()){
			  userName = rs.getString("cname");
		  }
		  if(userName != null && !userName.equals("")){ // 成功获取到用户名
		      notLogin = "style=\"display:none\"";
			  Login = "style=\"display:block\"";
		  }
		  else{
			  userName = "";
		  }
		  rs.close();
		  stmt.close();
		  con.close();
		}
		catch (Exception e){
		  msg = e.getMessage();
		}
	} 
%>
<style>
    body {
    	margin: 0px;
        padding: 0px;  
        font-size: 16px;
        font-family: 方正隶书简体, 隶书, 微软雅黑, 楷体;
        background-color: #F5F5F5;
        background-image: url('images/logo.png');
        background-repeat: no-repeat;
        background-attachment: fixed;
        background-size: 10%;
        background-position: 100% 66%;
    }   
    #header1_outer {
	    width: 100%;
	    min-width: 1100px;
	    height: 18px;
		position: relative;
		background-color: #CACACA;
		/* border: 1px solid black;  */
	}
	     
	#header {
		width: 1100px;
		height: 168px;
		margin: 0 auto;		
		position: relative;
		padding: 0px;		
		/* border: solid 1px black; */
	} 
	
	#main {
		width: 1100px;
		min-height: 500px;
		/* border: solid 1px black; */
		margin: 0 auto;
		position: relative;
		padding: 0px;
		margin-top: 10px;
	}
	#footer_outer {
		width: 100%;
		min-width: 1100px;
	    height: 160px;
		background-color: #CACACA;
		background-size: 100%;
		margin-top: 10px;
		font-size: 0.7rem;
		color: #000000;
	}
	
	/* 本页面专用CSS */
	#update_customer {
		position: relative;
		width: 600px;
		height: 320px;
		margin: 0 auto;
		box-sizing:border-box;
		box-shadow: 0px 10px 50px white, 5px 5px 10px #9D0D0C;
		background-color:white;
	}
	form {
		position:absolute;
		left:40px;
		width: 400px;
		height: 220px;
		margin:0 auto;
		padding:20px;
	}
	#left {
		width: 110px;
		height: 218px;
		float:left;
	}
	#right {
		width: 110px;
		height: 218px;
		float:right;
	}
	input:not(#register_submit) {
		width:200px;
		height:30px;
		margin:3px;
		border-radius:5px;
		text-align:center;
		box-shadow:3px 3px 2px #a0a0a0, inset 1px 1px 1px #a0a0a0, 4px 4px 1px #9D0D0C;
	}
	input#register_submit {
		width:212px;
		height:40px;
		border-radius:5px;
		text-align:center;
		box-shadow:2px 2px 2px #808080;
	}
	textarea {
		width:205px;
		height:30px;
		border-radius:5px;
		text-align:center;
		box-shadow:3px 3px 2px #808080, inset 1px 1px 1px #808080, 4px 4px 1px #9D0D0C;
	}
	label {
		width:30px;
		height:30px;
		font-size:30px;
		text-align:center;
	}
	#state_box {
		width:250px;
		height:10px;
		position:absolute;
		top:380px;
		left:420px;
	}
	#state {
		font-family:华文行楷;
		text-align:center;
		margin:0 auto;
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
	input#exit {
		width:100px;
		height:30px;
		position:absolute;
		left:600px;
		top:330px;
		margin:0 auto;
		box-shadow:1px 1px 1px #808080;
	}
	
</style>
</head>
<body>
	<div id="header1_outer"> <!-- v3 -->
		<div id="header1_inner">
			<a href="admin_login.jsp">管理员入口</a> 
			<div id="header1_right_notLogin" <%=notLogin %>>
				<a href="login.jsp">登录</a> | <a href="register.jsp">注册</a>
			</div>
			<div id="header1_right_Login" <%=Login %>>
				<span><%=userName %></span> <a href="update_customer.jsp">用户中心</a>
			</div>
		</div>
	</div>
	
	<div id="header">
		<div id="logo">
			<a href="index.jsp"><img alt="银心" src="images/logo.png" width="98px" height="150px"></a>
		</div>
		<!-- end of logo -->
		<div id="slogon">
			<p>想用整个<b>银</b>河</p>
			<p>            换你一颗真<b>心</b></p>
		</div>
		<!-- end of slogon -->		
		<div id="nav">
			<a href="index.jsp" id="home">
				<i class="fa fa-home navIcon"></i>
				<p>首页</p>
			</a>
							
			<a href="main.jsp" id="product" 
				onmouseenter="javascript:delay_appear()" 
				onmouseover="javascript:delay_appear()" 
				onmouseleave="javascript:delay_disappear()">
				<i class="fa fa-search navIcon"></i>
				<p>产品</p>
			</a>			
			<div class="subnav">
				<ul id="product_class"
					onmouseenter="javascript:appearNav(); product_class.mouseOn=true" 
					onmouseleave="javascript:delay_disappear(); product_class.mouseOn=false"
					onmouseover="javascript:appearNav(); product_class.mouseOn=true"
					onmouseout="javascript:delay_disappear(); product_class.mouseOn=false">
					<li><a href="ring.jsp">戒指</a></li> <!-- v3 -->
					<li><a href="earring.jsp">耳环</a></li> <!-- v3 -->
					<li><a href="bracelent.jsp">手镯</a></li> <!-- v3 -->
					<li><a href="necklace.jsp">项链</a></li> <!-- v3 -->
				</ul>
			</div>
			<!-- end of subnav -->
			
			<a href="order_list.jsp" id="order"> <!-- v3 -->
				<i class="fa fa-file-text-o navIcon"></i>
				<p>订单</p>
			</a>
		</div>
		<!-- end of nav -->		
	</div>
	<!-- end of header -->
	
<br><br>
	<div id="main">
	    <%
		String Button = request.getParameter("update_customer_submit");
		request.setCharacterEncoding("utf-8");
		String update_user = request.getParameter("update_user"); if (update_user == null) update_user = "";
		String update_phone = request.getParameter("update_phone"); if (update_phone == null) update_phone = "";
		String update_address = request.getParameter("update_address"); if (update_address == null) update_address = "";
		String update_new_password = request.getParameter("update_new_password"); if (update_new_password == null) update_new_password = "";
		String update_confirm_password = request.getParameter("update_confirm_password"); if (update_confirm_password == null) update_confirm_password = "";
		if (request.getParameter("exit") != null) {
			session.setAttribute("id", "");
			response.sendRedirect("index.jsp");
		}
		String id = session.getAttribute("id").toString();
		//String id = "3";
		if (Button == null && id != null) {
			String connectString = "jdbc:mysql://172.18.187.234:3306/14353007" + "?autoReconnect=true&useUnicode=true"
					+ "&characterEncoding=UTF-8";
				
			try {
				Class.forName("com.mysql.jdbc.Driver");
				Connection con = DriverManager.getConnection(connectString, "user", "123");
				Statement stmt = con.createStatement();
				String sql = String.format("select * from customer where cid = '%s'", id);
				ResultSet rs = stmt.executeQuery(sql);
				if (rs.next()) {
					update_user = rs.getString("cname");
					update_phone = rs.getString("cphone");
					update_address = rs.getString("caddr");
					update_new_password = rs.getString("cpwd");
					update_confirm_password = rs.getString("cpwd");
				}
				else {
		%>		
					<div id="state_box">
						<p id="state" style="width:6em;">您尚未登录！</p>
						<p id="shadow"></p>
					</div>
		<%
				}
				  rs.close();
				  stmt.close();
				  con.close();
			} catch (Exception e) {
				out.write(e.getMessage());
				
			}
		}
		
		else if (Button != null && id != null){
			if ((!update_user.equals("")) && (!update_phone.equals("")) && (!update_address.equals("")) && (!update_new_password.equals("")) && (!update_confirm_password.equals(""))) {
				if (update_confirm_password.equals(update_new_password)) {
					String connectString = "jdbc:mysql://172.18.187.234:3306/14353007" + "?autoReconnect=true&useUnicode=true"
							+ "&characterEncoding=UTF-8";
					Connection con;
					try {
						Class.forName("com.mysql.jdbc.Driver");
						con = DriverManager.getConnection(connectString, "user", "123");
						Statement stmt = con.createStatement();
						String sql = String.format("update customer set cname='%s', cpwd='%s', caddr='%s', cphone='%s' where cid = '%s';", update_user, update_confirm_password, update_address, update_phone, id);
						int result = stmt.executeUpdate(sql);
						if (result > 0) {
		%>
							<div id="state_box">
								<p id="state" style="width:5em;">修改成功！</p>
								<p id="shadow"></p>
							</div>
		<%
						}
						else {
		%>
							<div id="state_box">
								<p id="state" style="width:13em;">修改失败，请重新进行修改！</p>
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
							<p id="state" style="width:13em;">修改失败，请重新进行修改！</p>
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
		else {
		%>		
			<div id="state_box">
				<p id="state" style="width:6em;">您尚未登录！</p>
				<p id="shadow"></p>
			</div>
		<%
		}
		%>
	
		<div id="update_customer">
			<form action="update_customer.jsp" method="post">
			
				<div id="left">
					<label for="icon_size"><i class="fa fa-user"></i></label>
					<input id="update_user" type="text" name="update_user" placeholder="请输入用户名！" value=<%=update_user %>></input><br><br>
				
					<label for="icon_size"> <i class="fa fa-phone"></i></label>
					<input id="update_phone" type="text" name="update_phone" placeholder="请输入联系电话！" value=<%=update_phone %>></input><br><br>
				
					<label for="icon_size"><i class="fa fa-home"></i> </label>
					<textarea id="update_address" name="update_address" placeholder=" 请输入联系地址！" rows="1" cols="15"><%=update_address %></textarea>
				</div>
				
				<div id="right">
					<label for="icon_size"><i class="fa fa-star-o"></i></label>
					<input id="update_new_password" type="password" name="update_new_password" placeholder="请输入密码！" value=<%=update_new_password %> ></input><br><br>
					
					<label for="icon_size"><i class="fa fa-star"></i></label>
					<input id="update_confirm_password" type="password" name="update_confirm_password" placeholder="请确认密码!" value=<%=update_confirm_password %>></input><br><br>
					
					<label for="icon_size"><i class="fa fa-map-signs"></i></label>
					<input id="update_customer_submit" name="update_customer_submit" type="submit" value="修改"/>
					<input id="exit" name="exit" type="submit" value="退出"/>
				</div>
				
			</form>
			
		</div>
		<!-- end of update_customer -->
	</div>
	<!-- end of main -->
	
	<div id="footer_outer">
		<div id="footer_inner">
			<p>版权所有 &copy 移动Web应用设计第100小组</p>
			<p>组长：谢梓莹</p>
			<p>组员：蔡洁莹、陈晓琪</p>
			<p>建议使用IE9.0及以上、Firefox、Google Chrome、360浏览器极速模式或其它兼容浏览器访问本网站</p>
		</div>
	</div>
	<!-- end of footer_outer -->
</body>
</html>