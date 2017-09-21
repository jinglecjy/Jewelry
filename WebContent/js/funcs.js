window.onload = function(){
	bind(); // 导航栏事件绑定
}
function addLoadEvent(func){ // onload事件多重绑定冲突解决
	var oldLoad = window.onload;
	if(typeof window.onload != 'function'){
		window.onload = func;
	}else{
		window.onload = new function(){
			oldLoad();
			func();
		};
	}
	
}
/* 打开新窗口 */
function openWin(url){
	var iHeight = 400;
	var iWidth = 400;
	var iTop = (window.screen.availHeight-30-iHeight) / 2; 
	var iLeft = (window.screen.availWidth-30-iWidth) / 2;
	window.open (url, 'newwindow', 'height='+iHeight+',width='+iWidth+', top='+iTop+', left='+iLeft +
		', toolbar=no, menubar=no, scrollbars=no, resizable=no,location=no, status=no'); 
}
/* v1: 导航栏hover时间绑定 */
var isHover = false;
function appearSubNav(){
	var e1 = document.getElementsByClassName('subnav')[0];
	e1.style.display="flex"; 
	var e = window.event || arguments[0];
	if(e.currentTarget.id != "product") isHover = true;
}
function delay_disappear(){ // 子菜单延时5秒消失
	setTimeout(disappearSubNav(arguments), 5000);
}
function disappearSubNav(){
	var e1 = document.getElementsByClassName('subnav')[0];
	var e = window.event | arguments[0];
	if(!isHover || e.currentTarget==undefined || e.currentTarget.id != "product")
		document.getElementsByClassName('subnav')[0].style.display="none";
	if(e.currentTarget==undefined || e.currentTarget.id == "product") isHover = false;
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
}

/* v1: 幻灯片轮播+文字标题背景颜色动画 */
function sliderChange(){
	var index = 0; // 当前的幻灯片编号
	var isIE = false;
	if(navigator.userAgent.toLowerCase().indexOf('trident') > -1) isIE = true;
	
	function start(){
		if(isIE){
			var sliderName = document.getElementsByClassName('sliderName');
			sliderName[index].style.backgroundSize = "100%"; 
		}
		setInterval(function(){
			indexChange(true);
			animation(-300); 
		}, 5000);
	}
	function indexChange(add){ // 切换幻灯片
		if(add){
			if(index==3) index=0;
			else index=index+1;
		}
		else {
			if(index==0) index=3;
			else index=index-1;
		}
		sliderNameActive();
		textChange();
	}
	function sliderNameActive(){
		var sliderName = document.getElementsByClassName('sliderName');
		for(let i=0; i<index; i++){ // 将之前展示过的幻灯片都标记为actived
			sliderName[i].className = "sliderName actived";
		}
		if(index == 0){ // 当幻灯片从头开始就要清空之前的actived记录
			for(let i=0; i<4; i++){ // 将之前展示过的幻灯片都标记为actived
				sliderName[i].className = "sliderName";
			}
		}
		sliderName[index].className = "sliderName active";
		
		if(isIE) { // for IE
			for(let i=0; i<4; i++){ // 将所有幻灯片都置为空
				sliderName[i].style.backgroundSize = "0%"; 
			}
			sliderName[index].style.backgroundSize = "100%"; 
		}
	}
	function animation(offset){ // 幻灯片图片切换
		var wrapper = document.getElementById("wrapper");
		var left = parseInt(wrapper.offsetLeft)+offset;
		if(left<-900) left = 0;
		else if(left>0) left = -900;
		wrapper.style.left = left+"px";
	}
	function textChange(){
		var sliderContent = document.getElementById('sliderContent');
		var text = sliderContent.childNodes;
		var count = 0;
		for(let i=0; i<text.length; i++){
			if(text[i].tagName){				
				if(count==index) text[i].style.display = "block";
				else text[i].style.display = "none";
				count++;
			}
		}
	}
	
	start();
};