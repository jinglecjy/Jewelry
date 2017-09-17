<%@ page language="java" import="java.util.*,java.sql.*"  
    contentType="text/html; charset=utf-8"
    pageEncoding="utf-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta charset="UTF-8">
<title>查询商品信息|银心银饰</title>
<% 
	String admin_cid = null;
	if(session.getAttribute("id") != null)
		admin_cid = session.getAttribute("id").toString(); // 登录界面跳转后传递用户cid 
	if(admin_cid != "1"){
		response.sendRedirect("index.jsp"); 
		return;
	}
	request.setCharacterEncoding("utf-8");
	String pname = request.getParameter("pname");
	String msg="";
	Integer pgno=0;   // 当前页号
	Integer pgcnt=4;  // 每页行数
	String param=request.getParameter("pgno");
	// System.out.println(param);
	if(param!=null && !param.isEmpty()){
		pgno=Integer.parseInt(param);
	}
	param=request.getParameter("pgcnt");
	if(param!=null && !param.isEmpty()){
		pgcnt=Integer.parseInt(param);
	}
	int pgprev=(pgno>0)?pgno-1:0;
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
	String connectString="jdbc:mysql://172.18.187.234:3306/14353007"
			+ "?autoReconnect=true&useUnicode=true"
			+ "&characterEncoding=UTF-8";
	StringBuilder table=new StringBuilder();
	try{
		Class.forName("com.mysql.jdbc.Driver");
		Connection conn=DriverManager.getConnection(connectString, "user", "123");
		Statement stmt=conn.createStatement();
		// 从pgno*pgcnt开始，向后移动pgcnt行
		String sql=String.format("select * from product limit %d,%d", pgno*pgcnt, pgcnt); 
		if(pname != null && !pname.equals("")) sql=String.format("select * from product where pname=\'"+pname+"\';"); 
		ResultSet rs=stmt.executeQuery(sql);
		table.append("<table border=\"1\" cellspacing=\"0\"><th>商品编号</th>"
			+"<th>商品名称</th><th>商品价格</th><th>商品分类</th><th>图片链接</th></tr>");
		judge="1";
		while(rs.next()){
			table.append(String.format(
					"<tr><td>%s</td><td>%s</td><td>%s</td><td>%s</td><td>%s</td></tr>",
					rs.getString("pid"), rs.getString("pname"), rs.getString("pprice"),
					rs.getString("pclass"), rs.getString("plink")));
			judge="null";
		}
		
		table.append("</table>");
		rs.close(); stmt.close(); conn.close();
	} catch(Exception e){
		msg=e.getMessage();
	}
%>
<style>
body {
	margin-top: 50px;
}
input {
	margin-left: 200px;
}
p {
	text-align: center;
	color: #9D0D0C;
    font-weight: bold;
}
input[type="text"] {
	width: 450px;
}
table {
     border: solid 1px black;
     cellspacing: 0;
     margin: 0 auto;
 }
td {
	text-align: center;
}
</style>

</head>
<body>
	<%=table %>
	<br><br>
	<p><%=SearchMsg %></p> <br>
	<div style="float:right">
		<a href="productQuery.jsp?pgno=<%=pgprev%>&pgcnt=<%=pgcnt %>&judge=<%=judge%>">上一页</a>
		<a href="productQuery.jsp?pgno=<%=pgnext%>&pgcnt=<%=pgcnt %>&judge=<%=judge%>">下一页</a>
	</div>
	<br><br>
	<%=msg %><br><br>
</body>
</html>