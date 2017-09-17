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
<link rel="stylesheet" href="css/footer.css">
<link rel="stylesheet" href="css/admin_operation_main.css">
<script type="text/javascript" src="js/nav.js"></script>

<!-- v3:修改title -->
<title>管理员操作|银心银饰</title> 
<%  /* v3: 动态显示当前用户名 */
	String cid = null;
	if(session.getAttribute("id") != null)
		cid = session.getAttribute("id").toString(); // 登录界面跳转后传递用户cid 
	if(cid != "1"){
		response.sendRedirect("index.jsp"); 
		return;
	}
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
	else {
		response.sendRedirect("index.jsp"); 
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
		height: 450px;
		/* border: solid 1px black; */
		margin: 0 auto;
		position: relative;
		padding: 0px;
		margin-top: 80px;
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
<script type="text/javascript">
function product_add(){
	var pname = document.getElementById('pname').value; 
	window.open("productAdd.jsp?pname="+pname, "newwindow", "height=300, width=600, top=100px,left=400px,"
			+"toolbar=no, menubar=no, scrollbars=no, resizable=no,location=no, status=no");
}
function product_delete(){
	var pname = document.getElementById('pname').value; 
	window.open("productDelete.jsp?pname="+pname, "newwindow", "height=200, width=250, top=100px,left=600px,"
			+"toolbar=no, menubar=no, scrollbars=no, resizable=no,location=no, status=no");
}
function product_update(){
	var pname = document.getElementById('pname').value; 
	window.open("productUpdate.jsp?pname="+pname, "newwindow", "height=300, width=600, top=100px,left=400px,"
			+"toolbar=no, menubar=no, scrollbars=no, resizable=no,location=no, status=no");
}
function product_query(){
	var pname = document.getElementById('pname').value; 
	window.open("productQuery.jsp?pname="+pname, "newwindow", "height=400, width=650, top=100px,left=350px,"
			+"toolbar=no, menubar=no, scrollbars=no, resizable=no,location=no, status=no");
}

function order_add(){
	var oid = document.getElementById('oid').value; 
	window.open("orderAdd.jsp?oid="+oid, "newwindow", "height=400, width=600, top=100px,left=400px,"
			+"toolbar=no, menubar=no, scrollbars=no, resizable=no,location=no, status=no");
}
function order_delete(){
	var oid = document.getElementById('oid').value; 
	window.open("orderDelete.jsp?oid="+oid, "newwindow", "height=200, width=250, top=100px,left=600px,"
			+"toolbar=no, menubar=no, scrollbars=no, resizable=no,location=no, status=no");
}
function order_update(){
	var oid = document.getElementById('oid').value; 
	window.open("orderUpdate.jsp?oid="+oid, "newwindow", "height=400, width=600,top=100px,left=400px,"
			+"toolbar=no, menubar=no, scrollbars=no, resizable=no,location=no, status=no");
}
function order_query(){
	var oid = document.getElementById('oid').value; 
	window.open("orderQuery.jsp?oid="+oid, "newwindow", "height=300, width=350, top=100px,left=500px,"
			+"toolbar=no, menubar=no, scrollbars=no, resizable=no,location=no, status=no");
}
</script>
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
		<div id="cols">
			<div id="products">
				<h1>商品</h1><br>
				饰品名称：<input type="text" name="pname" id="pname"><br><br>
				<button id="padd" onclick="product_add();">增加</button>
				<button id="pdelete" onclick="product_delete();">删除</button>
				<button id="pupdate" onclick="product_update();">修改</button>
				<button id="pquery" onclick="product_query();">查找</button>
			</div>
			<div id="block1">
			</div>
			<div id="orders">
				<h1>订单</h1><br>
				订单编号：<input type="text" name="oid" id="oid"><br><br>
				<button id="oadd" onclick="order_add();">增加</button>
				<button id="odelete" onclick="order_delete();">删除</button>
				<button id="oupdate" onclick="order_update();">修改</button>
				<button id="oquery" onclick="order_query();">查找</button>
			</div>
			<div id="block2">
			</div>
			<div id="block3">
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