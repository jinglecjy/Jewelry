<%@ page language="java" import="java.util.*,java.sql.*"  contentType="text/html; charset=utf-8"
    pageEncoding="utf-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<link rel="shortcut icon" href="images/icons.ico" type="image/x-icon" />
<link rel="icon" href="images/icons.png" type="image/png" />
<link rel="stylesheet" type="text/css" href="font-awesome-4.7.0/css/font-awesome.css" />
<link rel="stylesheet" type="text/css" href="font-awesome-4.7.0/css/font-awesome.min.css" />
<link rel="stylesheet" href="css/header1.css">
<link rel="stylesheet" href="css/header.css">
<link rel="stylesheet" href="css/index_main.css">
<link rel="stylesheet" href="css/footer.css">
<script type="text/javascript" src="js/header.js"></script>

<!-- v3:修改title -->
<title>首页 | Jewelry</title> 
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
        font-size: 0.8em;
        font-family: "Times New Roman",Georgia,Serif;
        background-color: #F8F8F8;
    }   
	
	#main {
		width: 1100px;
		height: 720px;
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
	
</style>
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
	<div id="main">
		<div id="ad_screen">
			<div id="ad_list">
				<ul>
					<li><img id="ad_img" src="" width=350px height=350px></li>
					<li><img id="ad_img" src="" width=350px height=350px></li>
					<li><img id="ad_img" src="" width=350px height=350px></li>
					<li><img id="ad_img" src="" width=350px height=350px></li>
				</ul>
			</div>
		</div> 
		<!-- end of ad -->
		<div id=cols>
			<div id="new_message">
				<span> 最新资讯 </span>
				<hr/>
				<ul>
					<li><p><span>2016/12/10：圣诞节狂欢满赠季，圣诞礼物选它就对了</span>
					       <span>！满2080送新款价格520元手镯!</span></p></li>
					<li><p><span>2016/12/01：双十二特惠场3折起</span>
					       <span>！优惠券满1100减20，打折商品限量销售，先到先得！</span></p></li>
					<li><p><span>2016/11/05：双十一限量秒杀</span>
					       <span>！即日起至11月11日，整点限量秒杀，价格低至999元！</span></p></li>
				</ul>
			</div>
			<div id="about_me">
				<span> 关于我们 </span>
				<hr/>
				<ul>
					<li><b>电话：</b>12345678909</li>
					<li><b>官方微博：</b>http://weibo.com/Jewelry</li>
					<li><b>微信公众号：</b>loveJewelry</li>
				</ul>
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