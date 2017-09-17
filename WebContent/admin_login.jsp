<%@ page language="java" import="java.util.*,java.sql.*"  
	contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<link rel="shortcut icon" href="images/logo_icon.ico" type="image/x-icon" />
<link rel="icon" href="images/logo_icon.ico" type="image/x-icon" />
<link rel="stylesheet" type="text/css" href="font-awesome-4.7.0/css/font-awesome.css" />
<link rel="stylesheet" type="text/css" href="font-awesome-4.7.0/css/font-awesome.min.css" />
<link rel="stylesheet" href="css/header1.css">
<link rel="stylesheet" href="css/header.css">
<link rel="stylesheet" href="css/footer.css">
<script type="text/javascript" src="js/nav.js"></script>
<title>管理员登录|银心银饰</title>
<%  
	String admin_name = request.getParameter("admin_name");
	String admin_pwd = request.getParameter("admin_pwd");
	String second = request.getParameter("second");
	
	String notLogin = "style=\"display:block\"";
	String Login = "style=\"display:none\"";
	String msg = "";
	
	String userName = "";
	boolean isSuccess = false;
	if((admin_name == null || admin_pwd == null) && second != null) msg = "用户名和密码不能为空！";
	else if(second != null){
		request.setCharacterEncoding("utf-8");
		String connectString = "jdbc:mysql://172.18.187.234:3306/14353007"
						+ "?autoReconnect=true&useUnicode=true"
						+ "&characterEncoding=UTF-8"; 
		try{
		  Class.forName("com.mysql.jdbc.Driver");
		  Connection con=DriverManager.getConnection(connectString, 
		                 "user", "123");
		  Statement stmt=con.createStatement();
		  ResultSet rs=stmt.executeQuery("select * from customer where cid=1;");
		  String correct_pwd = "";
		  String correct_name = "";
		  if(rs.next()){
			  correct_pwd = rs.getString("cpwd");
			  correct_name = rs.getString("cname");
		  }
		  if(correct_name != null && correct_name.equals(admin_name) &&
				  correct_pwd != null && correct_pwd.equals(admin_pwd)){ // 成功登录
			  userName = admin_name;
		      notLogin = "style=\"display:none\"";
			  Login = "style=\"display:block\"";
			  msg = "登陆成功！";
			  isSuccess = true;
		  }
		  else{
			  userName = "";
			  msg = "用户名或者密码错误！";
		  }
		  rs.close();
		  stmt.close();
		  con.close();
		}
		catch (Exception e){
		  msg = e.getMessage();
		}
		
		if(isSuccess){
			session.setAttribute("id", "1");
			response.sendRedirect("admin_operations.jsp"); 
			return;
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
		width: 1060px;
		/* border: solid 1px black; */
		margin: 0 auto;
		position: relative;
		padding: 0px;
		margin-top: 40px;
		margin-bottom: 40px;
		background-color: rgba(210,210,210, 0.2);
		-webkit-box-shadow: 0 0 1px 20px rgba(0, 0, 0, 0.1);
  		-moz-box-shadow: 0 0 1px 20px rgba(0, 0, 0, 0.1);
  		box-shadow: 0 0 1px 20px rgba(0, 0, 0, 0.1);
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
	
	/* 本页专属CSS */
	#main{
		text-align: center;
		padding: 40px 0; 
	}
	#main span {
		white-space: pre;
	}
	input {
		width: 200px;
		border: 0px;
		-webkit-box-shadow: 0px 1px 2px rgba(0, 0, 0, 0.2),  
  							0px -1px 2px rgba(0, 0, 0, 0.2),
  							0px -2px 2px rgba(0, 0, 0, 0.05) inset;
  		-moz-box-shadow: 0px 1px 2px rgba(0, 0, 0, 0.2),  
  						 0px -1px 2px rgba(0, 0, 0, 0.2),
  						 0px -2px 2px rgba(0, 0, 0, 0.05) inset;
  		box-shadow: 0px 1px 2px rgba(0, 0, 0, 0.2),  
  					0px -1px 2px rgba(0, 0, 0, 0.2),
  					0px -2px 2px rgba(0, 0, 0, 0.05) inset;
	}
	input:hover {
		-webkit-box-shadow: 0px 1px 2px rgba(0, 0, 0, 0.3), 
  							0px 2px 2px rgba(0, 0, 0, 0.1), 
  							0px -1px 2px rgba(0, 0, 0, 0.3),
  							0px -2px 2px rgba(0, 0, 0, 0.1);
  		-moz-box-shadow: 0px 1px 2px rgba(0, 0, 0, 0.3), 
  						 0px 2px 2px rgba(0, 0, 0, 0.1), 
  						 0px -1px 2px rgba(0, 0, 0, 0.3),
  						 0px -2px 2px rgba(0, 0, 0, 0.1);
  		box-shadow: 0px 1px 2px rgba(0, 0, 0, 0.3), 
  					0px 2px 2px rgba(0, 0, 0, 0.1), 
  					0px -1px 2px rgba(0, 0, 0, 0.3),
  					0px -2px 2px rgba(0, 0, 0, 0.1);
	}
	button {
		background-color: #CACACA;
		-webkit-box-shadow: 0px 1px 2px rgba(0, 0, 0, 0.5), 
  							0px 2px 2px rgba(0, 0, 0, 0.3), 
  							0px -1px 2px rgba(0, 0, 0, 0.5),
  							0px -2px 2px rgba(0, 0, 0, 0.3);
  		-moz-box-shadow: 0px 1px 2px rgba(0, 0, 0, 0.3), 
  					 	 0px 2px 2px rgba(0, 0, 0, 0.1), 
  					     0px -1px 2px rgba(0, 0, 0, 0.3),
  					 	 0px -2px 2px rgba(0, 0, 0, 0.1);
  		box-shadow: 0px 1px 2px rgba(0, 0, 0, 0.3), 
  					0px 2px 2px rgba(0, 0, 0, 0.1), 
  					0px -1px 2px rgba(0, 0, 0, 0.3),
  					0px -2px 2px rgba(0, 0, 0, 0.1);
  		border: 0px;
  		padding: 5px 10px;
  		font-family: 微软雅黑;
  		font-size: 0.7rem;
	}
</style>
</head>
<body>
	<div id="header1_outer">
		<div id="header1_inner">
			<a href="admin_login.jsp">管理员入口</a> 
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
	
	<div id="main">
		<form action="admin_login.jsp?second=true" method="post">
			<span>用户名：</span><input type="text" name="admin_name"> <br><br>
			<span>密码：   </span><input type="password" name="admin_pwd"> <br><br>
			<button type="submit" name="login">登录</button>
		</form>
		<br><br>
		<%=msg %>
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