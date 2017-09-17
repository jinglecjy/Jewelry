window.onload = function(){
	bind();
	var adScreen = document.getElementById("ad_screen");
	var adList = adScreen.getElementsByTagName("ul")[0];
	var allImg = adScreen.getElementsByTagName("img");
	var timer = null;
	var playTimer = null;
	var index = i = 0;
	var increOrder = true;
	var allTmp = [];
	var allButton = null;
	// 生成数字按钮
	for(i=0; i<allImg.length; i++) allTmp.push("<li>"+(i+1)+"</li>");
	// 将数字按钮插入到html代码中
	var adCount = document.createElement("ul");
	adCount.className = "count";
	adCount.innerHTML = allTmp.join("");
	adScreen.appendChild(adCount);
	allButton = adScreen.getElementsByTagName("ul")[1].getElementsByTagName("li"); 
	
  	// 初始化幻灯片
	cutover(); 
	
 	// 按钮点击切换
	for(i=0; i<allButton.length; i++){
		allButton[i].index = i;
		allButton[i].onclick = function (){
			index = this.index;
			stop();
			cutover();
		}
	} 

 	function next(){
		increOrder? index++:index--;
		if(index < 0){
			index = 0;
			increOrder = true;
		}
		if(index > allButton.length-1){
			index = allButton.length-1;
			increOrder = false;
		}
		console.log("next");
		cutover();
	}
 	
 	function cutover(){
		for(i=0; i<allButton.length; i++) allButton[i].className = "";
		allButton[index].className = "current"; // 标记当前选中的图片 
		console.log("cutover");
		startMove(-(index*allImg[0].offsetHeight));
		playTimer = setTimeout(play, 6000); // 每6秒切换一次图片
	}
	
 	playTimer = setTimeout(play, 6000); // 每6秒切换一次图片
	
	// 出现图像抖动无法切换
 	/* // 鼠标移入展示区自动停止播放
	adScreen.onmouseover = function(){
		if(timer == null) clearInterval(playTimer);
		console.log("mouseover");
	}
	// 鼠标离开展示区自动播放
	adScreen.onmouseout = function(){
		playTimer = setInterval(function(){next();}, 3000); 
		console.log("mouseout");
	}  */
	function startMove(imgTarget){
		clearInterval(playTimer);
		timer = setInterval(function(){
			doMove(imgTarget);
		}, 20);
		
		console.log("startmove");
	}
	function doMove(imgTarget){
		var imgSpeed = (imgTarget - adList.offsetTop)/2;
		imgSpeed = imgSpeed>0 ? Math.ceil(imgSpeed):Math.floor(imgSpeed);
		
		adList.offsetTop == imgTarget? clearInterval(timer) :
							adList.style.top = adList.offsetTop + imgSpeed + "px";
		console.log("doMove"+timer);
	}  
	function play(){
		next();
		playTimer = setTimeout(play, 6000);
	}
	function stop(){
		clearTimeout(playTimer);
	}
}  

/* v1: 导航栏hover时间绑定 */
var isHover = false;
function appearSubNav(){
	var e1 = document.getElementsByClassName('subnav')[0];
	e1.style.display="flex"; 
	var e = event || arguments[0];
	if(e.currentTarget.id != "product") isHover = true;
}
function delay_disappear(){ // 子菜单延时5秒消失
	setTimeout(disappearSubNav(arguments), 5000);
}
function disappearSubNav(){
	var e1 = document.getElementsByClassName('subnav')[0];
	var e = event || arguments[0];
	if(!isHover || e.currentTarget.id != "product")
		document.getElementsByClassName('subnav')[0].style.display="none";
	if(e.currentTarget.id == "product") isHover = false;
}
function bind(){
	var nav = document.getElementById('product');
	var subnav = document.getElementsByClassName('subnav')[0];
	if(typeof window.addEventListener != 'undefined'){
		// firefox、chrome、IE9+、safari、opera
		nav.addEventListener('mouseover', appearSubNav);
		nav.addEventListener('mouseout', delay_disappear);
		subnav.addEventListener('mouseover', appearSubNav);
		subnav.addEventListener('mouseout', delay_disappear);
	}
	else { // IE7、IE8
		nav.attachEvent('onmouseover', appearSubNav);
		nav.attachEvent('onmouseout', delay_disappear);
		subnav.attachEvent('onmouseover', appearSubNav);
		subnav.attachEvent('onmouseout', delay_disappear);
	}
}

/* v1: 网页滚动时导航栏固定在浏览器最上方 */
window.onscroll = function() {
	var t = document.documentElement.scrollTop || document.body.scrollTop;
	var header = document.getElementById('header');
	if(t >= 26) {
		header.style.top = "0px";
		
	}
	else {
		header.style.top = 26-t+"px";
	}
	console.log(header.style.top);
}