<%@ page language="java" import="java.util.*,java.sql.*"  contentType="text/html; charset=utf-8"
    pageEncoding="utf-8"%>
<html>
<head>
<meta charset="UTF-8">
<link rel="shortcut icon" href="images/icons.ico" type="image/x-icon" />
<link rel="icon" href="images/icons.png" type="image/png" />
<link rel="stylesheet" href="css/normalize.css" type="text/css" charset="utf-8">
<link rel="stylesheet" href="css/header.css" type="text/css" charset="utf-8">
<script type="text/javascript" src="js/funcs.js"></script>
<%  /* v3: 动态显示当前用户名 */
	String header_cid = null;
	if(session.getAttribute("id") != null)
		header_cid = session.getAttribute("id").toString(); // 登录界面跳转后传递用户header_cid 
	String notLogin = "style=\"display:block\"";
	String Login = "style=\"display:none\"";
	String userName = "";
	String msg ="";
	if(header_cid != null){
		request.setCharacterEncoding("utf-8");
		String connectString = "jdbc:mysql://localhost:3306/jewelry"
						+ "?autoReconnect=true&useUnicode=true"
						+ "&characterEncoding=UTF-8"; 
		try{
		  Class.forName("com.mysql.jdbc.Driver");
		  Connection con=DriverManager.getConnection(connectString, 
		                 "root", "root");
		  Statement stmt=con.createStatement();
		  ResultSet rs=stmt.executeQuery("select cname from customer where cid="+header_cid+";");
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

</head>
<body>
	<div id="top">
		<div id="signupLogin"> 
			<ul>
				<li <%=notLogin %>>
					<span>立即注册以访问专有内容</span>&nbsp;&nbsp;&nbsp;
					<a href="register.jsp">注册</a>&nbsp;&nbsp;&nbsp;|&nbsp;&nbsp;&nbsp;<a href="login.jsp">登录</a> 
				</li>
				<li <%=Login %>>
					<span><%=userName %></span> <a href="update_customer.jsp">用户中心</a>
				</li>
			</ul>
		</div>
	</div>
	<div id="header">
		<div id="container">
			<div id="logo">
				<a title="Jewelry" href="index.jsp"><img src="images/logo.png"></a>
			</div>
			<!-- end of logo -->
			<ul id="menu">
				<li id="home"><a href="index.jsp">首页</a></li>				
				<li id="product" ><a href="main.jsp" >产品</a></li>							
				<li id="order"><a href="order_list.jsp">订单</a></li>
			</ul>
			<!-- end of menu -->		
		</div>
		<!-- end of container -->
		<div class="subnav">
			<ul>
				<li><a href="ring.jsp">戒指</a></li> 
				<li><a href="earring.jsp">耳环</a></li> 
				<li><a href="bracelent.jsp">手镯</a></li>
				<li><a href="necklace.jsp">项链</a></li> 
			</ul>
		</div>
		<!-- end of subnav -->
	</div>
	<!-- end of header -->
</body>
</html>