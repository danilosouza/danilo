function rwNewsletter(fld,frm)
{
	var email = document.getElementById(fld).value
	if(email != "")
	{
		var params = "email="+email;
		var url = "/ajax/newsletterck";
		var http = new XMLHttpRequest();http.open('POST',url,true);
		http.setRequestHeader("Content-type","application/x-www-form-urlencoded");
		http.onreadystatechange=function()
		{
			if(http.readyState==4&&http.status==200)
			{
				var html=http.responseText;
				if(html == "ok")
				{
					document.getElementById(frm).submit();
				}
				else
				{
					alert('Please Enter A Valid Email!');
				}
			}
		}
		http.send(params);
	}
	else
	{
		alert('Please Enter A Valid Email!');
	}
}
function setCompareVals(){var e=document.getElementById("botstocompare").value;if(document.getElementById("comp_met").checked){for(i=0;i<e;i++){document.getElementById("compare_metric_"+i).style.display="block";document.getElementById("compare_english_"+i).style.display="none"}}else if(document.getElementById("comp_eng").checked){for(i=0;i<e;i++){document.getElementById("compare_metric_"+i).style.display="none";document.getElementById("compare_english_"+i).style.display="block"}}}
function compareItems(e)
{
	var t=document.getElementById("compareFrm").elements;
	var n="";
	var r=0;
	for(var i=0;i<t.length;i++)
	{
		if(t[i].type=="checkbox"&&t[i].checked)
		{
			n+=t[i].value+",";
			r++
		}
	}
	if(r>=2&&r<5)
	{
		document.getElementById("loading").innerHTML="Loading Data Please Wait...";
		var s="items="+n+"&type="+e;
		var o="/ajax/compare";
		var u=new XMLHttpRequest;
		u.open("POST",o,true);
		u.setRequestHeader("Content-type","application/x-www-form-urlencoded");
		u.onreadystatechange=function()
		{
			if(u.readyState==4&&u.status==200)
			{
				var e=u.responseText;
				document.getElementById("compareHolder").innerHTML=e;
				document.getElementById("compareHolder").style.display="block";
				document.getElementById("loading").innerHTML="";
			}
		}
		u.send(s)
	}
	else
	{
		alert("Please select 2 to 4 items to compare.");
	}
}

function hideCompare()
{
	document.getElementById("compareHolder").style.display="none";
}

function sortSeries(e){
	var t="ssort";
	var n=e;
	var r=0;
	createCookie(t,n,r);
	window.location.reload();
}
function getSumData(e){document.getElementById("sum_show").innerHTML="Loading Summary, please wait...";var t="/ajax/getSumData";var n="id="+e;var r=new XMLHttpRequest;r.open("POST",t,true);r.setRequestHeader("Content-type","application/x-www-form-urlencoded");r.onreadystatechange=function(){if(r.readyState==4&&r.status==200){var e=r.responseText;var t=navigator.appName.indexOf("Microsoft")!=-1;document.getElementById("sum_show").innerHTML=e}};r.send(n)}function switchUnits(){var e=document.getElementById("total_rows").value;var t=document.getElementById("specs").value;var n="eng";if(t=="eng"){n="mec"}else{n="eng"}for(var r=0;r<e;r++){document.getElementById("specs_"+t+"_"+r).style.display="block";document.getElementById("specs_"+n+"_"+r).style.display="none"}}function switchSpecs(e){if(e=="eng"){document.getElementById("product_info_eng").style.display="block";document.getElementById("product_info_met").style.display="none";document.getElementById("metric").style.fontWeight="bold";document.getElementById("english").style.fontWeight="400"}else{document.getElementById("product_info_met").style.display="block";document.getElementById("product_info_eng").style.display="none";document.getElementById("english").style.fontWeight="bold";document.getElementById("metric").style.fontWeight="400"}}function clearSearchField(){if(document.getElementById("q").value=="Enter Keyword Here"){document.getElementById("q").value=""}}function clearSearchFieldb(){var e=document.forms["searchFrmb"];if(e.query.value=="Enter Keyword Here"){e.query.value=""}}function switchYoutubeVideoSm(e){var t='<object width="200" height="110">';t+='<param name="movie" value="http://www.youtube.com/v/'+e+'?fs=1&hl=en_US&rel=0"></param>';t+='<param name="allowFullScreen" value="true"></param><param name="allowscriptaccess" value="always"></param>';t+='<param name="wmode" value="opaque"></param>';t+='<embed src="http://www.youtube.com/v/'+e+'?fs=1&hl=en_US&rel=0" type="application/x-shockwave-flash" width="200" height="110" allowscriptaccess="always" wmode="opaque" allowfullscreen="true"></embed>';t+="</object>";document.getElementById("yt_vid").innerHTML=t}function switchYoutubeVideo(e){var t='<object width="470" height="270">';t+='<param name="movie" value="http://www.youtube.com/v/'+e+'?fs=1&hl=en_US&rel=0"></param>';t+='<param name="allowFullScreen" value="true"></param><param name="allowscriptaccess" value="always"></param>';t+='<param name="wmode" value="opaque"></param>';t+='<embed src="http://www.youtube.com/v/'+e+'?fs=1&hl=en_US&rel=0" type="application/x-shockwave-flash" width="470" height="270" allowscriptaccess="always" wmode="opaque" allowfullscreen="true"></embed>';t+="</object>";document.getElementById("yt_vid").innerHTML=t}function get_robot_models(){var e="/ajax/getRobotModels";var t="mfg="+document.getElementById("mfg").value;var n=new XMLHttpRequest;n.open("POST",e,true);n.setRequestHeader("Content-type","application/x-www-form-urlencoded");n.onreadystatechange=function(){if(n.readyState==4&&n.status==200){var e=n.responseText;var t=navigator.appName.indexOf("Microsoft")!=-1;if(e!="no"){document.getElementById("models").innerHTML=e}else{alert(e)}}};n.send(t)}function get_robot_models_forms(){var e="/ajax/getRobotModelsForms";var t="mfg="+document.getElementById("00N30000006nYYF").value;var n=new XMLHttpRequest;n.open("POST",e,true);n.setRequestHeader("Content-type","application/x-www-form-urlencoded");n.onreadystatechange=function(){if(n.readyState==4&&n.status==200){var e=n.responseText;if(e!="no"){document.getElementById("models").innerHTML=e}else{alert(e)}}};n.send(t)}function go_to_robot_page(){var e=document.getElementById("mfg").value;var t=document.getElementById("model").value;if(e!="-1"&&t!="-1"){window.location="/"+e+"/"+t}}function startTabCloseTimer(){tab_timeout=setTimeout("closeTabs()",1e3)}function stopTabCloseTimer(){clearTimeout(tab_timeout)}function closeTabs(){var e=0;for(e=1;e<=5;e++){try{document.getElementById("tab"+e+"_closed").style.backgroundImage="url(/images/design/tabs_menu/tab"+e+"_closed.png)";document.getElementById("tab"+e+"_open").style.display="none";document.getElementById("tab"+e+"_open").style.visibility="hidden"}catch(t){}}}function setTabs(e,t){if(e==1){document.getElementById("rt_padding").style.height="4px"}else if(e==2){document.getElementById("rt_padding").style.height="46px"}else if(e==3){document.getElementById("rt_padding").style.height="89px"}else if(e==4){document.getElementById("rt_padding").style.height="132px"}if(t=="open"){var n=0;for(n=1;n<=5;n++){if(n==e){document.getElementById("tab"+n+"_closed").style.backgroundImage="url(/images/design/tabs_menu/tab"+n+"_open_lft.png)";document.getElementById("tab"+n+"_open").style.display="block";document.getElementById("tab"+n+"_open").style.visibility="visible"}else{try{document.getElementById("tab"+n+"_closed").style.backgroundImage="url(/images/design/tabs_menu/tab"+n+"_closed.png)";document.getElementById("tab"+n+"_open").style.display="none";document.getElementById("tab"+n+"_open").style.visibility="hidden"}catch(r){}}}}}function ckEmail(e){var t=e;var n=t.indexOf("@");var r=t.lastIndexOf(".");if(n<1||r<n+2||r+2>=t.length){return false}else{return true}}function sendSubscribe(){var e=document.getElementById("subscribe_email").value;var t=ckEmail(e);if(t){var n="/ajax/sendSubscribe";var r="fmail="+e;var i=new XMLHttpRequest;i.open("POST",n,true);i.setRequestHeader("Content-type","application/x-www-form-urlencoded");i.onreadystatechange=function(){if(i.readyState==4&&i.status==200){var e=i.responseText;if(e!="no"){alert("Thank you! \n Your now subscribed to the RobotWorx Newsletter!")}else{alert("Your now subscribed to the RobotWorx Newsletter.")}}};i.send(r)}else{alert("Please check your email address.")}}function clearSubscribeField(){if(document.getElementById("subscribe_email").value=="Enter Your Email!"){document.getElementById("subscribe_email").value=""}}function clearPartsSearchField(){if(document.getElementById("parts_keyword").value=="Enter Keyword Here"){document.getElementById("parts_keyword").value=""}}function doPartsSearch(){if((document.getElementById("parts_keyword").value=="Enter Keyword Here"||document.getElementById("parts_keyword").value=="")&&document.getElementById("parts_category").value=="-1"&&document.getElementById("parts_mfg").value=="-1"){alert("Please enter a keyword to search for.")}else{document.getElementById("partsSearchFrm").submit()}}function doStepOneHybrid(){document.getElementById("hybrid_step_one").style.display="none";document.getElementById("hybrid_step_two").style.display="block"}

function startHereStepOne()
{
	document.getElementById("step_one_btn").innerHTML="Searching Our Database...";
	var e="/ajax/startHereStepOne";
	var t="mfg="+document.getElementById("mfg").value;
	t+="&app="+document.getElementById("app").value;
	t+="&reach="+document.getElementById("reach").value;
	t+="&payload="+document.getElementById("payload").value;
	var n=new XMLHttpRequest;
	n.open("POST",e,true);
	n.setRequestHeader("Content-type","application/x-www-form-urlencoded");
	n.onreadystatechange=function(){
		if(n.readyState==4&&n.status==200)
		{
			var e = n.responseText;
			document.getElementById("step_one_btn").innerHTML='<a href="javascript:;" onclick="startHereStepOne();"><img src="/images/design/get_quote_sm.png" width="100" alt="Submit" title="Submit" border="0" /></a>';
			document.getElementById("help_results").style.display="block";
			//alert("res: " + e);
			document.getElementById("startHereContent").innerHTML=e;
		}
	}
	n.send(t)
}

function resetStartHere(){var e="/ajax/resetStartHere";var t="reset=yes";var n=new XMLHttpRequest;n.open("POST",e,true);n.setRequestHeader("Content-type","application/x-www-form-urlencoded");n.onreadystatechange=function(){if(n.readyState==4&&n.status==200){var e=n.responseText;document.getElementById("startHereContent").innerHTML=e}};n.send(t)}function addOption(e,t,n){var r="qopt";var i=readCookie(r);var s="";if(i){s=i+"nn"+e+","+t+","+n}else{s=e+","+t+","+n}var o=createCookie(r,s,0);alert("This item will be included in your quote request!")}function createCookie(e,t,n){if(n){var r=new Date;r.setTime(r.getTime()+n*24*60*60*1e3);var i="; expires="+r.toGMTString()}else var i="";document.cookie=e+"="+t+i+"; path=/"}function readCookie(e){var t=e+"=";var n=document.cookie.split(";");for(var r=0;r<n.length;r++){var i=n[r];while(i.charAt(0)==" ")i=i.substring(1,i.length);if(i.indexOf(t)==0)return i.substring(t.length,i.length)}return null}function eraseCookie(e){createCookie(e,"",-1)}function setCampCookie(){createCookie("rwcmp","yes",365)}function removeCampCookie(){eraseCookie("rwcmp")}function doItemUpdate(e){var t="/ajax/cartItemUpdate";var n=document.getElementById("item_"+e).value;var r="rowid="+e+"&qty="+n;var i=new XMLHttpRequest;i.open("POST",t,true);i.setRequestHeader("Content-type","application/x-www-form-urlencoded");i.onreadystatechange=function(){if(i.readyState==4&&i.status==200){var e=i.responseText;alert("Your cart has been updated.")}};i.send(r)}function doItemDelete(e){var t="/ajax/cartItemDelete";var n="id="+e;var r=new XMLHttpRequest;r.open("POST",t,true);r.setRequestHeader("Content-type","application/x-www-form-urlencoded");r.onreadystatechange=function(){if(r.readyState==4&&r.status==200){var e=r.responseText;window.location.reload()}};r.send(n)}function clearNewsLetterForm(){if(document.getElementById("ea").value=="Enter Your Email"){document.getElementById("ea").value=""}}function doAddToCart(e,t,n,r){var i="/ajax/addToCart";var s="item="+e+"&uid="+t+"&cartid="+n+"&spec="+r;var o=new XMLHttpRequest;o.open("POST",i,true);o.setRequestHeader("Content-type","application/x-www-form-urlencoded");o.onreadystatechange=function(){if(o.readyState==4&&o.status==200){var e=o.responseText;if(e!="err"){document.getElementById("cart_contents").innerHTML=e;document.getElementById("dynamicCart").style.display="block";document.getElementById("cart-head").innerHTML="Hide Your Cart"}else{alert("Error")}}};o.send(s)}function notLoggedIn(){var e=confirm("You need to be logged in to save your cart. Click ok to login, if you do not have an account you can create one!");if(e){window.location="/account/login"}}function doSaveCart(e,t,n){var r="/ajax/saveCart";var i="cid="+e+"&uid="+t+"&sid="+n;var s=new XMLHttpRequest;s.open("POST",r,true);s.setRequestHeader("Content-type","application/x-www-form-urlencoded");s.onreadystatechange=function(){if(s.readyState==4&&s.status==200){var e=s.responseText;if(e!="err"){alert("Your cart has been saved!")}else{alert("Error")}}};s.send(i)}function checkBinUser(){document.getElementById("usrck").innerHTML='<img src="/images/design/loading-icon.gif" width="20" height="20" border="0" align="absmiddle"  />';var e=document.getElementById("uemail").value;if(e!=""){var t="/ajax/checkBinUser";var n="val="+e;var r=new XMLHttpRequest;r.open("POST",t,true);r.setRequestHeader("Content-type","application/x-www-form-urlencoded");r.onreadystatechange=function(){if(r.readyState==4&&r.status==200){var e=r.responseText;if(e!="err"){document.getElementById("usrck").innerHTML='<img src="/images/design/ok.png" width="20" height="20" border="0" align="absmiddle" />'}else{document.getElementById("usrck").innerHTML='<img src="/images/design/notok.png" width="20" height="20" border="0" align="absmiddle" /> This email is already in use!'}}};r.send(n)}}function checkBinPass(){var e=document.getElementById("upassa").value;var t=document.getElementById("upassb").value;if(e==""||t==""){alert("Please entery your password twice!");document.getElementById("passck").innerHTML='<img src="/images/design/notok.png" width="20" height="20" border="0" align="absmiddle" />'}else{if(e!=t){alert("Your passwords do not match!");document.getElementById("passck").innerHTML='<img src="/images/design/notok.png" width="20" height="20" border="0" align="absmiddle" />'}else{document.getElementById("passck").innerHTML='<img src="/images/design/ok.png" width="20" height="20" border="0" align="absmiddle" />'}}}function setItemQty(e,t,n,r){var i="/ajax/setItemQty";var s=document.getElementById("qty_"+t).value;var o="cart_id="+e+"&line_id="+t+"&product_id="+n+"&qty="+s+"&type="+r;var u=new XMLHttpRequest;u.open("POST",i,true);u.setRequestHeader("Content-type","application/x-www-form-urlencoded");u.onreadystatechange=function(){if(u.readyState==4&&u.status==200){var e=u.responseText;var n=e.split("<:>");if(n[0]=="ok"){alert("The item has qty has been updated.");document.getElementById("itm_price_"+t).innerHTML=n[1]+" (USD)";document.getElementById("total_price").innerHTML=n[2]}else{alert(n[0])}}};u.send(o)}function removeCartItem(e,t){var n=confirm("Are you sure you want to remove this item?");if(n){var r="/ajax/removeCartItem";var i="cid="+e+"&id="+t;var s=new XMLHttpRequest;s.open("POST",r,true);s.setRequestHeader("Content-type","application/x-www-form-urlencoded");s.onreadystatechange=function(){if(s.readyState==4&&s.status==200){var e=s.responseText;if(e!="err"){alert("The item has been removed from your cart.");window.location.reload()}else{alert("The item was not removed, please reload this page and try again.")}}};s.send(i)}}function setCookie(e,t,n){var r=new Date;r.setDate(r.getDate()+n);var i=escape(t)+(n==null?"":"; expires="+r.toUTCString());document.cookie=e+"="+i}function setItemSort(e){setCookie("psort",e);window.location.reload()}function doComments(e){var t=document.getElementById("comments").value;document.getElementById("wt_comments").value=t;if(t!=""){var n="/ajax/doCommentsBuy";var r="cid="+e+"&val="+t;var i=new XMLHttpRequest;i.open("POST",n,true);i.setRequestHeader("Content-type","application/x-www-form-urlencoded");i.onreadystatechange=function(){if(i.readyState==4&&i.status==200){var e=i.responseText;if(e!="err"){}else{}}};i.send(r)}}function doExShipping(e){var t="";if(document.getElementById("ex_shipping").checked){t="yes";document.getElementById("wt_exship").value="yes"}else{t="no";document.getElementById("wt_exship").value="na"}var n="/ajax/doExShipping";var r="cid="+e+"&val="+t;var i=new XMLHttpRequest;i.open("POST",n,true);i.setRequestHeader("Content-type","application/x-www-form-urlencoded");i.onreadystatechange=function(){if(i.readyState==4&&i.status==200){var e=i.responseText;if(e!="err"){}else{}}};i.send(r)}function isNumber(e){return!isNaN(parseFloat(e))&&isFinite(e)}function checkIntShipping(e,t,n){var r="/ajax/getIntShipping";var i="cx="+e+"&or="+t+"&val="+n;var s=new XMLHttpRequest;s.open("POST",r,true);s.setRequestHeader("Content-type","application/x-www-form-urlencoded");s.onreadystatechange=function(){if(s.readyState==4&&s.status==200){var e=s.responseText;var t=new Date;var n=t.toLocaleTimeString();if(e=="ok"){window.location.reload()}}};s.send(i)}function doIntShip(e,t){if(isNumber(t)){var n="/ajax/doIntShip";var r="cid="+e+"&val="+t;var i=new XMLHttpRequest;i.open("POST",n,true);i.setRequestHeader("Content-type","application/x-www-form-urlencoded");i.onreadystatechange=function(){if(i.readyState==4&&i.status==200){var e=i.responseText;if(e!="err"){alert("Updating your cart, please wait.");window.location.reload()}else{alert("Error, saving data. Please reload the page and try again.")}}};i.send(r)}else{alert("Please enter only nunbers in the international shipping cost field.")}}var tab_timeout;
function hybridSubmit()
{
	var isSpam = 0;
	var error = 0;
	var msg = "Please Check The Following Fields\n";
	var spamName = document.getElementById('username').value;
	if(spamName != "")
	{
		isSpam = 1;
		// send form data to db
		var str = '';
        var elem = document.getElementById('hybrid_quote').elements;
        for(var i = 0; i < elem.length; i++)
        {
            str += "||"+elem[i].name + "=" + elem[i].value;
        }
		var params = "page=hybrid&values="+str;
		alert(params);
		var url = "/ajax/spamform";
		var http = new XMLHttpRequest();
		http.open('POST',url,true);
		http.setRequestHeader("Content-type","application/x-www-form-urlencoded");
		http.onreadystatechange=function()
		{
			if(http.readyState==4&&http.status==200)
			{
				window.location.assign("https://www.robots.com/thankyou");
			}
		}
		http.send(params); 
    }
	else
	{
		// check required fields
		var name    = document.getElementById('first_name').value;
		var email   = document.getElementById('email').value;
		var company = document.getElementById('company').value;
		var phone   = document.getElementById('phone').value;
		var country = document.getElementById('country').value;
		if(name == "")
		{
			error = 1;
			msg += "Please Enter Your Name.\n";
		}
		if(email == "")
		{
			error = 1;
			msg += "Please Enter Your Email.\n";
		}
		if(company == "")
		{
			error = 1;
			msg += "Please Entery Your Company.\n";
		}
		if(phone == "")
		{
			error = 1;
			msg += "Please Enter Your Phone Number.\n";
		}
		if(country == "")
		{
			error = 1;
			msg += "Please Enter Your Country.\n";
		}
		if(error == 1)
		{
			alert(msg);
		}
		else
		{
			document.getElementById('hybrid_quote').submit();
		}
	}
}