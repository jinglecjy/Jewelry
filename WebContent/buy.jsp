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
<title>下订单|银心银饰</title> 
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
	String result="";
	String weblogin="<div class=\"weblogin\"><br><br><p>请点击登陆页面登陆账户!</p><br></div>";
	StringBuilder tobuy = new StringBuilder();
	String havebuy="";
	String pid=request.getParameter("pid");
	String connectString = "jdbc:mysql://172.18.187.234:3306/14353007"
	+ "?autoReconnect=true&useUnicode=true&characterEncoding=UTF-8";
	String user="user";
	String pwd="123";
	String pprice="";
	String plink="";
	String pclass="";
	String pname="";
	String cname="";
	String sql="";
	String submit=request.getParameter("submit");
	StringBuilder table = new StringBuilder();
	int i=0;
	try{
		
		if(cid==null||cid.equalsIgnoreCase("null"))
		{
			result=weblogin;
		}
		else
		{
			Class.forName("com.mysql.jdbc.Driver");
			Connection con=DriverManager.getConnection(connectString, user, pwd);
			Statement stmt=con.createStatement();
			
			sql=String.format("select * from product where pid='%s';",pid);
			ResultSet rs=stmt.executeQuery(sql);
			
			while(rs.next()) {
				pprice=rs.getString("pprice");
				plink=rs.getString("plink");
				pclass=rs.getString("pclass");
				pname=rs.getString("pname");
			}
			
			sql=String.format("select * from customer where cid=%s;",cid);
			rs=stmt.executeQuery(sql);
			
			while(rs.next()) {
				cname=rs.getString("cname");
			}
			
			if(submit==null)
			{
				tobuy.append("<div class=\"tobuy\">");
				tobuy.append(String.format("<form action=\"buy.jsp?cid=%s\" method=\"post\">",cid));
				tobuy.append("<fieldset>");
				tobuy.append("<legend>下订单</legend>");
				tobuy.append(String.format("<p>客户名字：%s</p>",cname));
				tobuy.append(String.format("<input type=\"hidden\" name=\"cid\" value=\"%s\" />",cname));
				tobuy.append(String.format("<p>所购产品编码：%s</p>",pname));
				tobuy.append(String.format("<input type=\"hidden\" name=\"pid\" value=\"%s\" />",pid));
				tobuy.append("数量：");
				tobuy.append("<select name=\"num\">" );
				tobuy.append("<option value=\"1\">1</option>");
				tobuy.append("<option value=\"2\">2</option>");
				tobuy.append("<option value=\"3\">3</option>");
				tobuy.append("<option value=\"4\">4</option>");
				tobuy.append("<option value=\"5\">5</option>");
				tobuy.append("<option value=\"6\">6</option>");
				tobuy.append("</select><br><br>");	
				tobuy.append("<input name=\"submit\" type=\"submit\" value=\"提交\">");
				tobuy.append("</fieldset>");
				tobuy.append("</form>");
				tobuy.append("</div>");
				rs.close();
				result=tobuy.toString();
			}
			else
			{
				i=1;
				String num=request.getParameter("num");
				int sumprice=Integer.parseInt(pprice)*Integer.parseInt(num);
				sql=String.format("insert into orders(cid,pid,num,sumprice) values(%s,%s,%s,%s);",cid,pid,num,sumprice);
				int cnt=stmt.executeUpdate(sql);
				  if(cnt <= 0)
				  {
					    msg = "update failed";
				  } 
				  else {
					  	msg = "update success!";
					  	havebuy="<div class=\"havebuy\"><p>订单提交成功，<br>可从订单栏中查看自己已下订单。<p></div><br>";
					  	result=havebuy;
				  }
			}
				 stmt.close(); con.close();
		}
		
		
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
		border: solid 1px rgb(238,238,238); 
		margin: 0 auto;
		position: relative;
		padding: 0px;
		margin-top: 10px;
		vertical-align:middle;
	}
	#screen {
  	position: relative;
  	width: 1060px;
  	min-height:200px;
  	background: #FFF;
  	opacity: 0.9;
  	filter: alpha(opacity=90); /* 用于兼容IE低版本 */
  	border-radius: 5px;
  	-webkit-box-shadow: 0 0 1px 20px rgba(0, 0, 0, 0.1);
  	-moz-box-shadow: 0 0 1px 20px rgba(0, 0, 0, 0.1);
  	box-shadow:  0 0 1px 20px rgba(0, 0, 0, 0.1);
  	
  	margin: 0 auto;
  	margin-top: 30px;
  	margin-bottom:10px;
  	vertical-align:middle;
  	/* border: 1px solid red; */ 
	}
	#main .weblogin 
	{
		vertical-align:middle;
		height:50px;
		margin:0 auto;
		text-align:center;
		font-size:22px;
	}
	#main .havebuy 
	{
		padding-top:45px;
		vertical-align:middle;
		text-align:center;
		height:30px;
	}
	#main .havebuy p
	{
		vertical-align:middle;
		text-align:center;
		font-size:22px;
	}
	#main .tobuy
	{
		margin-bottom:10px;
	}
	#main .tobuy form
	{
		vertical-align:middle;
		text-align:center;
	}
	#main .tobuy input
	{
		color:white;	
		background-color:rgb(157,13,12);
		border-radius: 8px;
		border-color:white;
		padding:8px;
	}
	#main .tobuy input:hover
	{
		color:white;
		background-color:rgb(189,6,0);
		border-radius: 8px;
		padding:8px;
	}
	#main .tobuy input:active
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
							
			<a href="main.html" id="product" 
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
		<%=result %>
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