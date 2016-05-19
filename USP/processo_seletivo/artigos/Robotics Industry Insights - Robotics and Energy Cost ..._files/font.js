//initial read for current size cookie to carry selection through pages
initialFontSize('currentSize');

//set cookie function
function createCookie(name,value,days) {
	if (days) {
		var date = new Date();
		date.setTime(date.getTime()+(days*24*60*60*1000));
		var expires = "; expires="+date.toGMTString();
	}
	else var expires = "";
	document.cookie = name+"="+value+expires+"; path=/";
}

//check cookie to set initial font size
function initialFontSize(name) {
	var nameEQ = name + "=";
	var ca = document.cookie.split(';');
	for(var i=0;i < ca.length;i++) {
		var c = ca[i];
		while (c.charAt(0)==' ') c = c.substring(1,c.length);
		if (c.indexOf(nameEQ) == 0) {
			fontSizer(c.substring(nameEQ.length,c.length));
			}
	}
}

//font size changing function
function fontSizer(multiplier) {
	var contentDiv = document.getElementById('content');
    contentDiv.style.fontSize = ( 1 + (multiplier * 0.2)) + "em";
	if (typeof equalheight == 'function') { 
 	 equalheight('.Box');//For Pages with EqualHeight Columns
	 equalheight('.RFQItem');//RFQ Summary
	 equalheight('.Event');//Events
	}
	
	createCookie('currentSize',multiplier,30);
}