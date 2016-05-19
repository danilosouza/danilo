function initLinks(d)
{
	if (!d) d = document.getElementById("main");
	var as = d.getElementsByTagName("a");
	for (var i=0; i<as.length; i++) {
		if (!as[i].href) continue;
		if (as[i].className.indexOf("simple")>=0) continue;
		var h = as[i].innerHTML;
		if (h.length==0) continue;
		if (h.indexOf("<")>=0) continue;
		var r = "";
		var s = h.indexOf(" ");
		if (s>0) {
			r = h.substr(s);
			h = h.substr(0,s);
		}
		as[i].innerHTML = "<span style='white-space: nowrap' ><img src='/webhare/contentlink.gif' style='margin-right: 2px; vertical-align: middle; margin-bottom: 2px' border='0' width='14' height='11' />"+h+"</span>"+r;
	}
}


// Add autoComplete to <input> 'element'.
// If nameRegExp is given, add autoComplete to all elements under 'element' with 'name's matching nameRegExp
function addAutoComplete(element,nameRegExp)
{
	if (typeof element == 'string') element=document.getElementById(element);
	if (nameRegExp) {
		inps = element.getElementsByTagName('input');
		for (i=0; i<inps.length; i++) {
			if (inps[i].type=="text" && nameRegExp.test(inps[i].name))
				addAutoComplete(inps[i]);
		}
		return;
	}
	//new Ajax.Autocompleter(element, 'http://'+document.location.host+'/perl/complete', {minChars: 0});
	new Ajax.Autocompleter(element, '/perl/complete', {minChars: 0});
}

