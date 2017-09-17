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
<title>戒指|银心银饰</title> 
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
<% 
	request.setCharacterEncoding("utf-8");
	Integer pgno = 0; //当前页号
	Integer pgcnt = 4; //每页行数
	String param = request.getParameter("pgno");
	if(param != null && !param.isEmpty()){
	pgno = Integer.parseInt(param);
	}
	param = request.getParameter("pgcnt");
	if(param != null && !param.isEmpty()){
	pgcnt = Integer.parseInt(param);
	}
	int pgprev = (pgno>0)?pgno-1:0;
	int pgnext;
	String judge=request.getParameter("judge");
	String SearchMsg="";
	if(judge == null || judge.equals("null"))
	{
		pgnext = pgno+1;
	}
	else
	{
		pgnext = pgno;
		SearchMsg = "当前已是最后一页！";
	}
	String connectString = "jdbc:mysql://172.18.187.234:3306/14353007"
	+ "?autoReconnect=true&useUnicode=true&characterEncoding=UTF-8";
	String user="user";
	String pwd="123";
	StringBuilder table = new StringBuilder();
	try{
	Class.forName("com.mysql.jdbc.Driver");
	Connection con=DriverManager.getConnection(connectString, user, pwd);
	Statement stmt=con.createStatement();
	String sql=String.format("select * from product where pclass='ring' limit %d,%d;", pgno*pgcnt,pgcnt);
	ResultSet rs=stmt.executeQuery(sql);
	table.append("<table>");
		for(int j=0;j<4;j++)
		{
			if(rs.next()) {
			table.append("<tr>");
			table.append(String.format("<td><img src=\"%s\"></td>",rs.getString("plink")));
			table.append("<td>");
			table.append("<div class=\"buy_price\">");
			table.append(String.format("<p>价格：%s</p>",rs.getString("pprice")));
			table.append(String.format("<p>产品编号：%s</p>",rs.getString("pname")));
			table.append("</div>");
			table.append("</td>");
			
			table.append("<td>");
			table.append("<div class=\"buy_a\">");
			table.append(String.format("<a href=\"buy.jsp?pid=%s&cid=%s&cpwd=%s\">购买</a>",rs.getString("pid"),request.getParameter("cid"),request.getParameter("cpwd")));
			table.append("</div>");
			table.append("</td>");
			
			table.append("</tr>");
			}
			else
			{
				judge="1";
				break;
			}
		}
		
		table.append("</table>");
		rs.close(); stmt.close(); con.close();
	}
	catch (Exception e){
			msg = e.getMessage();
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
		margin: 0 auto;
		position: relative;
		padding: 0px;
		margin-top: 10px;
	}
	#screen {
  	position: relative;
  	width: 1060px;
  	background: #FFF;
  	opacity: 0.9;
  	filter: alpha(opacity=90); /* 用于兼容IE低版本 */
  	border-radius: 5px;
  	-webkit-box-shadow: 0 0 1px 20px rgba(0, 0, 0, 0.1);
  	-moz-box-shadow: 0 0 1px 20px rgba(0, 0, 0, 0.1);
  	box-shadow:  0 0 1px 20px rgba(0, 0, 0, 0.1);
  	
  	margin: 0 auto;
  	margin-top: 30px;
  	/* border: 1px solid red; */ 
	}
	#main #screen .tableShow
	{
		width:90%;
		margin: 0 auto;
		text-align:center;
		margin-bottom:30px;
	}
	#main #screen .tableShow .pictureShow table
	{
	  	border-collapse:collapse;
	  	text-align:center;
	  	border:0;
	  	//background:rgb(238,238,238);
	  	margin:10px auto;
	  	margin-top:50px;
	  	margin-bottom:50px;
	  	vertical-align:middle;
	}
	#main #screen .tableShow .pictureShow table td img
	{
		width:300px;
		height:300px;
	}
	#main #screen .tableShow .pictureShow table tr td 
	{
		width:300px;
		height:300px;
		vertical-align: middle;
	}
	#main #screen .tableShow .pictureShow table tr td .buy_price p
	{
		vertical-align:middle;
		font-size:23px;
	}
	#main #screen .tableShow .pictureShow table tr td .buy_a a
	{
		vertical-align: middle;
		font-size:23px;
	}
	#main #screen .tableShow .turnPage1
	{
		display:inline-block;
		margin:0 auto;
		text-align:center;
		padding-bottom:20px;
		padding-right:50px;
	}
	#main #screen .tableShow .turnPage2
	{
		display:inline-block;
		margin:0 auto;
		text-align:center;
		padding-bottom:20px;
		padding-left:50px;
	}
	#main #screen .tableShow .turnPage1 a:link, #main #screen .tableShow .turnPage2 a:link, #main #screen .tableShow .pictureShow table tr td .buy_a a:link
	{
		color:white;	
		background-color:rgb(157,13,12);
		border-radius: 8px;
		padding:8px;
	}
	#main #screen .tableShow .turnPage1 a:visited, #main #screen .tableShow .turnPage2 a:visited, #main #screen .tableShow .pictureShow table tr td .buy_a a:visited
	{
		color:white;	
		background-color:rgb(157,13,12);
		border-radius: 8px;
		padding:8px;
	}
	#main #screen .tableShow .turnPage1 a:hover,#main #screen .tableShow .turnPage2 a:hover,#main #screen .tableShow .pictureShow table tr td .buy_a a:hover
	{
		color:white;
		background-color:rgb(189,6,0);
		border-radius: 8px;
		padding:8px;
	}
	#main #screen .tableShow .turnPage1 a:active,#main #screen .tableShow .turnPage2 a:active,#main #screen .tableShow #pictureShow table tr td .buy_a a:active
	{
		color:rgb(189,6,0);
		background-color:rgb(238,238,238);
		border-radius: 8px;
		padding:8px;
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
	
	<div id="main">
	<div id="screen">
		<div class="tableShow">
			<div class="pictureShow">
				<%=table %>
				<%=msg %>
			</div>
			<%=SearchMsg %> <br><br><br>
			<div class="turnPage1">
				<a href="ring.jsp?pgno=<%=pgprev%>&pgcnt=<%=pgcnt%>&judge=<%=judge%>">上一页</a>
			</div> 
			<div class="turnPage2">
				<a href="ring.jsp?pgno=<%=pgnext%>&pgcnt=<%=pgcnt%>&judge=<%=judge%>">下一页</a>
			</div>
		</div>
	</div>
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