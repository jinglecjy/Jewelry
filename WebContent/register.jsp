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
<title>注册|银心银饰</title> 
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
	#register {
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
					String connectString = "jdbc:mysql://172.18.187.234:3306/14353007" + "?autoReconnect=true&useUnicode=true"
							+ "&characterEncoding=UTF-8";
					Connection con;
					try {
						Class.forName("com.mysql.jdbc.Driver");
						con = DriverManager.getConnection(connectString, "user", "123");
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
	
		<div id="register">
			<form action="register.jsp" method="post">
			
				<div id="left">
					<label for="icon_size"><i class="fa fa-user"></i></label>
					<input id="register_user" type="text" name="register_user" placeholder="请输入用户名！" value=<%=register_user %>></input><br><br>
				
					<label for="icon_size"> <i class="fa fa-phone"></i></label>
					<input id="register_phone" type="text" name="register_phone" placeholder="请输入联系电话！" value=<%=register_phone %>></input><br><br>
				
					<label for="icon_size"><i class="fa fa-home"></i> </label>
					<textarea id="register_address" name="register_address" placeholder=" 请输入联系地址！" rows="1" cols="15" ><%=register_address %></textarea>
				</div>
				
				<div id="right">
					<label for="icon_size"><i class="fa fa-star-o"></i></label>
					<input id="register_new_password" type="password" name="register_new_password" placeholder="请输入密码！" value=<%=register_new_password %>></input><br><br>
					
					<label for="icon_size"><i class="fa fa-star"></i></label>
					<input id="register_confirm_password" type="password" name="register_confirm_password" placeholder="请确认密码!" value=<%=register_confirm_password %>></input><br><br>
					
					<label for="icon_size"><i class="fa fa-map-signs"></i></label>
					<input id="register_submit" name="register_submit" type="submit" value="注册"/>
				</div>
				
			</form>
			
		</div>
		<!-- end of register -->
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