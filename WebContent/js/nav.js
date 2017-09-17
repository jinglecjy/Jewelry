/**
 * 
 */
function delay_appear(){ // 子菜单延时0.5秒出现
	appearNav();
	setTimeout("appearSubNav()", 500);
}

function appearNav(){
	var e1 = document.getElementById('product');
	e1.style.color="#BD0600";
	e1.style.backgroundColor="#CACACA";
}
function appearSubNav(){
	var e1 = document.getElementById('product_class');
	document.getElementById('product_class').style.display="block";
}
function delay_disappear(){ // 子菜单延时0.5秒消失
	disappearNav();
	setTimeout("disappearSubNav()", 500);
}
function disappearNav(){
	var e1 = document.getElementById('product');
	e1.style.color="#808080";
	e1.style.backgroundColor="";
}
function disappearSubNav(){
	var e1 = document.getElementById('product_class');
	if(!e1.mouseOn)
		document.getElementById('product_class').style.display="none";
}