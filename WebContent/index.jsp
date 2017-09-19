<%@ page language="java" import="java.util.*,java.sql.*"  contentType="text/html; charset=utf-8"
    pageEncoding="utf-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<link rel="shortcut icon" href="images/icons.ico" type="image/x-icon" />
<link rel="icon" href="images/icons.png" type="image/png" />
<link rel="stylesheet" href="css/normalize.css" type="text/css" charset="utf-8">
<link rel="stylesheet" type="text/css" href="font-awesome-4.7.0/css/font-awesome.css" />
<link rel="stylesheet" type="text/css" href="font-awesome-4.7.0/css/font-awesome.min.css" />
<link rel="stylesheet" href="css/header1.css" type="text/css" charset="utf-8">
<link rel="stylesheet" href="css/header.css" type="text/css" charset="utf-8">
<link rel="stylesheet" href="css/index_main.css" type="text/css" charset="utf-8">
<link rel="stylesheet" href="css/footer.css" type="text/css" charset="utf-8">
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
	#main {
		width: 1100px;
		/* border: solid 1px black; */
		margin: 0 auto;
		position: relative;
		padding: 0px;
		margin-top: 130px;
	}
	
	/* 幻灯片上方的文字标题 */
	div#sliderIndex{
		width: 1100px;
		flex: 1;
		display: flex;
		flex-wrap: wrap;
	}
	div#sliderIndex .sliderName {
		height: 40px;
		text-align: center;
		line-height: 40px;
		float: left;
		flex: 1 1 auto;
		background: url('images/sliderBackground.png') #EEE left repeat-y;
		background-size: 0%;
	}
	div#sliderIndex .sliderName:nth-child(-n+3) {
		margin-right: 2px;
	}
	div#sliderIndex div.active {
		animation: sliderIndexColor 5s linear; 
		-webkit-animation: sliderIndexColor 5s linear; /* Safari, Chrome */
	}
	@keyframes sliderIndexColor {
		0% {background-size: 0%;}
		20% {background-size: 20%;}
		40% {background-size: 40%;}
		60% {background-size: 60%;}
		80% {background-size: 80%;}
		100% {background-size: 100%;}
	}
	div#sliderIndex div.actived {
		background-size: 100%;
	}
	/* 幻灯片 */
	#sliderMain { /* 备用外层div，用于之后添加文字 */
		width: 1100px;
		height: 300px;
		background: white;
		border-bottom: 1px solid rgba(50, 50, 50, 0.2);
	}
	#sliderImg {
		/* 设置为单幅图片的宽高 */
		width: 300px;
		height: 300px;
		position: relative;
		/* 只显示一幅图片 */
		overflow: hidden;
		left: 100px;
	}
	#wrapper {
		position: absolute;
		/* 设置为所有图片的宽度之和，容纳所有图片 */
		width: 1200px;
		height: 300px;
		top: 0px;
		background: white;
	}
	#wrapper>img{
		float: left;
		height: 300px;
		width: 300px;
	}
	#sliderContent {
		float: right;
		margin-right: 200px;
		margin-top: 100px;
		text-align: center;
	}
	#sliderContent>div:nth-child(n+2) {
		display: none;
	}
	.sliderHeader{
		font-size: 2em;
	}
	
	/* 照片墙 */
	#photoWall{
		height: 990px;
		width: 1100px;
		display: -webkit-box;   /* OLD - iOS 6-, Safari 3.1-6 */
		display: -moz-box;  /* OLD - Firefox 19- H5不用考虑 */
		display: -mz-flexbox; /* TWEENER IE 10 */
		display: -webkit-flex; /* Safari */
		display: flex;
		flex-flow: column wrap;
		justify-content: flex-start;
		align-items: flex-start;
		margin-top: 10px;
		margin-right: -20px;
	}
	div.photo {
		width: 540px;
		margin-right: 20px;
	}

	.photo img{
		max-width: 540px;
	}
	span.photo.title {
		display: inline-block;
		width: 100%;
		max-width: 540px;
		height: 40px;
		line-height: 40px;
		background: white;
		text-align: center;
		font-size: 1.5em;
	}
	span.photo.description {
		display: inline-block;
		width: 100%;
		max-width: 540px;
		height: 20px;
		line-height: 20px;
		background: white;
		text-align: center;
		font-size: 0.5em;
		color: #808080;
		padding-bottom: 10px;
		margin-bottom: 10px;
	}
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
		<!-- 配合幻灯片的切换而切换的标题 -->
		<div id="sliderIndex">
			<div class="sliderName active">戒指</div>
			<div class="sliderName">耳环</div>
			<div class="sliderName">手链</div>
			<div class="sliderName">项链</div>
		</div>
		<div id="sliderMain"> <!-- 幻灯片内容区 -->
			<div id="sliderContent"> <!-- 幻灯片文本介绍 -->
				<div><span class="sliderHeader">戒指</span><br><br>
					 <span class="sliderText">经典戒指样式与流行的玫瑰金色碰撞</span></div>
			    <div><span class="sliderHeader">耳环</span><br><br>
					 <span class="sliderText">粉色珍珠彰显年轻本色</span></div>
			    <div><span class="sliderHeader">手链</span><br><br>
					 <span class="sliderText">与众不同的金属质感</span></div>
				<div><span class="sliderHeader">项链</span><br><br>
					 <span class="sliderText">共享欢乐与泪水</span></div>
			</div>
			<div id="sliderImg"> <!-- 幻灯片图片 -->
				<div id="wrapper">
					<img src="images/ring.jpg">
					<img src="images/earring.jpg">
					<img src="images/bracelet.jpg">
					<img src="images/necklace.jpg">
				</div>
			</div>
		</div>
		<!-- end of slider --> 
		<div id="photoWall">
			<div class="photo">
				<img src="images/photoWall1.jpg"/><br>
				<span class="photo title">乐观生活</span>
				<span class="photo description">心态决定想法，想法决定做法，做法决定结果。</span>
			</div>
			<div class="photo">
				<img src="images/photoWall4.jpg"/>
				<span class="photo title">善待自己</span>
				<span class="photo description">一生中，总会有一个人让你笑得最甜，也总会有一个人让你痛得最深。</span>
			</div>
			<div class="photo">
				<img src="images/photoWall3.jpg"/><br>
				<span class="photo title">宽容他人</span>
				<span class="photo description">宽容是送给他人的最好礼物。</span>
			</div>
			<div class="photo">
				<img src="images/photoWall2.jpg"/>
				<span class="photo title">等待惊喜</span>
				<span class="photo description">一无所知的世界，走下去，才有惊喜。</span>
			</div>
			<!-- end of photoWall --> 
		</div>
	</div>
	<!-- end of main -->

	<div style="background-color: #D65A6F; height: 3px; width: 100%;"></div>
	<div id="footer_outer">
		<div id="footer_inner">
			<p>版权所有 &copy; SYSU-移动Web应用设计第100小组</p>
			<p>移动信息工程14级：谢梓莹、蔡洁莹、陈晓琪</p>
			<p>建议使用IE9.0及以上、Firefox、Google Chrome、360浏览器极速模式或其它兼容浏览器访问本网站</p>
		</div>
	</div>
	<!-- end of footer_outer -->
</body>
</html>