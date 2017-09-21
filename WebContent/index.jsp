<%@ page language="java" contentType="text/html; charset=utf-8"
    pageEncoding="utf-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">

<title>首页 | Jewelry</title> 
<style> 
	#main {
		width: 1100px;
		/* border: solid 1px black; */
		margin: 0 auto;
		position: relative;
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
		margin-right: 20px;
	}

	.photo img{
		max-width: 540px;
	}
	span.photo.title {
		display: block;
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
	<%@include file="header.jsp" %>
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

	<%@include file="footer.jsp" %>
	<script type="text/javascript">
		addLoadEvent(sliderChange); // 开始运行幻灯片
	</script>
</body>
</html>