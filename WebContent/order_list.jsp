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
<title>我的订单|银心银饰</title> 
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
		width: 800px;
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
	#order_list {
		position: relative;
		width: 500px;
		height: 320px;
		margin: 0 auto;
		box-sizing:border-box;
	}
	
	#order_list_item {
		position: relative;
		width: 400px;
		height: 170px;
		margin: 0 auto;
		color: black;
		box-sizing:border-box;
		box-shadow: 0px 10px 50px white, 5px 5px 10px #9D0D0C;
		background-color:white;
	}
	
	#left {
		width: 150px;
		height: 150px;
		float:left;
		margin-left:25px;
		padding:10px;
	}
	#right {
		width: 150px;
		height: 150px;
		float:right;
		margin-left:25px;
		padding:10px;
	}
	#state_box {
		width:250px;
		height:10px;
		left:80px;
		margin:0 auto;
	}
	#state {
		font-family:华文行楷;
		text-align:center;
		margin:0 auto;
		color:black;
		/* border:solid 2px #EEEEEE; */
	}
	#shadow {
		width:300px;
		height:1px;
		margin:0 auto;
		border:solid 1px #9D0D0C;
		background-color:#9D0D0C;
		box-shadow:5px 5px 10px #9D0D0C;
	}
	#paging a {
		color: black;
		text-align: center;
		font-size: 20px;
		font-weight: 200;
		text-shadow:-1px 0px 1px #888888;
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
	
	<div id="main">
		<div id="order_list">
		<%
			String id = session.getAttribute("id").toString();
			//String id = "3";
			//翻页
			int pgno = 0;
			int pgcnt = 2;
			String param = request.getParameter("pgno");
			if (param != null && !param.isEmpty()) {
				pgno = Integer.parseInt(param);
			}
			param = request.getParameter("pgcnt");
			if (param != null && !param.isEmpty()) {
				pgcnt = Integer.parseInt(param);
			}
			int pgprev = (pgno > 0) ? pgno - 1 : 0;
			int pgnext = pgno + 1;
			
			String connectString = "jdbc:mysql://172.18.187.234:3306/14353007" + "?autoReconnect=true&useUnicode=true"
					+ "&characterEncoding=UTF-8";
			int order_list_oid, order_list_pid, order_list_num, order_list_sumprice; 
			String  order_list_customer="",order_list_product="", order_list_pprice="", order_list_phone="", order_list_address=""; 
			try {
				Class.forName("com.mysql.jdbc.Driver");
				Connection con = DriverManager.getConnection(connectString, "user", "123");
				Statement stmt = con.createStatement();
				String sql = String.format("select * from customer, product, orders where customer.cid = orders.cid and product.pid = orders.pid and customer.cid = '%s' limit %d, %d", id, pgno * pgcnt, pgcnt);
				ResultSet rs = stmt.executeQuery(sql);
				if (!rs.next()) {
					if (id != ""){
			%>
				
					<div id="state_box">
						<p id="state" style="width:18em;">您目前还没有订单，赶紧下单吧！</p>
						<p id="shadow"></p>
					</div>
			<%
					}
					else {
			%>
						
					<div id="state_box">
						<p id="state" style="width:18em;">您尚未登录！</p>
						<p id="shadow"></p>
					</div>
			<%
					}
				}
				else {
					rs = stmt.executeQuery(sql);
					while (rs.next()) {
						order_list_oid = rs.getInt("oid");
						order_list_num = rs.getInt("num");
						order_list_sumprice = rs.getInt("sumprice");
						order_list_product = rs.getString("pname");
						order_list_pprice = rs.getString("pprice");
						order_list_customer = rs.getString("cname");
						order_list_phone = rs.getString("cphone");
						order_list_address = rs.getString("caddr");
			%>
						<div id="order_list_item">
							<div id="left">
								<p>订单号： <%=order_list_oid %></p>
								<p>客户： <%=order_list_customer %></p>
								<p>电话： <%=order_list_phone %></p>
								<p>地址： <%=order_list_address %></p>
							</div>
							<div id="right">
								<p>银饰编号： <%=order_list_product %></p>
								<p>银饰单价： <%=order_list_pprice %></p>
								<p>银饰数量： <%=order_list_num %></p>
								<p>银饰总价： <%=order_list_sumprice %></p>
							</div>
						</div>
						<br><br><br>
			<%
					}
			%>
					
					<div id="paging" style="float: right">
						<a href="order_list.jsp?pgno=<%=pgprev%>&pgcnt=<%=pgcnt%>">上一页</a> 
						<a href="order_list.jsp?pgno=<%=pgnext%>&pgcnt=<%=pgcnt%>">下一页</a>
					</div>
			<%
				}
				
			} catch (Exception e) {
				out.write(e.getMessage());
			}
		%>
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