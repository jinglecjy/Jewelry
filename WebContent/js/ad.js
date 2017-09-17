window.onload = function(){
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