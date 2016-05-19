// USER VARS SETTINGS FOR GLOBAL USE; CAN BE MODIFIED 
var trkCookieName='AIMGViewer'; // name of the tracking cookie goes here
var trkBaseURL = 'https://www.aitracking.com'; // base URL of the tracking programs location

// JS VAR SETTINGS FOR GLOBAL USE; DO NOT MODIFY
var trkNoFollowIPs = []; 
var trkNoFollowUserAgents = []; 
var trkCaptureFieldNames=[]; 
var trkInputFieldNames=[];
var trkTxtFieldNames=[];
var trkFieldData='';
var trkCookieID = ''; 
var trkCookieExp = ''; 
var trkIP = '';
var trkLoadRecordID = '';
var trkQueryString = window.location.search.substring(1);
var trkProtocol = window.location.protocol;
var trkHost = window.location.host;
var trkPath = window.location.pathname;
var trkAgent = navigator.userAgent;
var trkReferrer = document.referrer;
var trkAllowLogging = 1; 
var trkExitRecorded = 0; 

window.onLoad=trkInit();
window.onbeforeunload = LogExit;
if(trkExitRecorded == 0)
{
	window.onunload = LogExit;
}

// evoked by getIP() after the IP is returned; requires the IP to verify it's not a noFollow IP
function enableLogging(testip) {
	if (trkNoFollowUserAgents.length > 0) {
		for (var i = 0; i < trkNoFollowUserAgents.length; ++i) {
		  if (trkAgent.toLowerCase().search(trkNoFollowUserAgents[i].trim().toLowerCase()) >= 0) {
			  trkAllowLogging=0;
			  break;
			}
		  }
	} 
	if (trkAllowLogging == 1) {
		if (trkNoFollowIPs.length > 0) {
			for (var j = 0; j < trkNoFollowIPs.length; ++j) {
			  if (testip.trim() == trkNoFollowIPs[j].trim()) {
				  trkAllowLogging=0;
				  break;
				}  
			  }
		} 
	}
	if (trkAllowLogging == 1) {
		setCookie();
	} 
}

// this function sets the tracking cookie; evoked by enableLogging() if logging is allowed
function setCookie() {
    var theCookie = getCookie(trkCookieName);
    var d = new Date();
    d.setTime(d.getTime() + (20*365*24*60*60*1000)); // twenty years
    var expires = "expires="+d.toUTCString();
    if (theCookie == null) {
		trkCookieID=generateUUID();
    	document.cookie = trkCookieName + '=' + trkCookieID + '; ' + expires + '; path=/';
    }
    else {
		trkCookieID=theCookie;
    } 
	LogLoad();
}

// this gets the value of the current cookie, evoked by setCookie to see if there is a cookie
function getCookie(name) {
    var dc = document.cookie;
    var prefix = name + "=";
    var begin = dc.indexOf("; " + prefix);
    if (begin == -1) {
        begin = dc.indexOf(prefix);
        if (begin != 0) return null;
    }
    else
    {
        begin += 2;
        var end = document.cookie.indexOf(";", begin);
        if (end == -1) {
        end = dc.length;
        }
    }
    return unescape(dc.substring(begin + prefix.length, end));
} 

// this generates a UUID to use as the cooked value, evoked by setCookie when needed to create a new cookie because none exist
function generateUUID() {
    var d = new Date().getTime();
    var uuid = 'xxxxxxxx-xxxx-4xxx-yxxx-xxxxxxxxxxxx'.replace(/[xy]/g, function(c) {
        var r = (d + Math.random()*16)%16 | 0;
        d = Math.floor(d/16);
        return (c=='x' ? r : (r&0x3|0x8)).toString(16);
    });
    return uuid;
}

// this gets the inital data values needed for processing, evoked onLoad
function trkInit() {
  var xmlhttp;
  xmlhttp = new XMLHttpRequest();
  xmlhttp.onreadystatechange = function() {
  	if (xmlhttp.readyState == XMLHttpRequest.DONE ) {
		var initData=xmlhttp.responseText;
		document.getElementById('trkBlock').innerHTML=initData;
		nfip=document.getElementById('trkNoFollowIPs').value;
		trkNoFollowIPs=nfip.split(',');
		nfua=document.getElementById('trkNoFollowUserAgents').value;
		trkNoFollowUserAgents=nfua.split(',');
		cpfn=document.getElementById('trkCaptureFieldNames').value;
		trkCaptureFieldNames=cpfn.split(',');
		trkIP=document.getElementById('trkIP').value;
		enableLogging(trkIP);
 	 }
  };
  xmlhttp.open('GET', trkBaseURL + '/aimgTrkInit.cfm?SiteCode='+trkSiteCode , true);
  xmlhttp.send(); 
}

// this gets the names of the input fields on the page and adds those which are text input fields to capture to trkInputFieldNames; 
function listInputFields() {
  var flds=document.getElementsByTagName('input');
  var f=flds.length;
  for (var i=0; i<f; i++)
  {
	 if((flds[i].type==='text' || flds[i].type==='email' || flds[i].type==='tel') && trkCaptureFieldNames.indexOf(flds[i].name) >= 0) {
	 trkInputFieldNames.push(flds[i].name);
	 }
  } 
}

// this gets the names of the textarea fields on the page and adds those to capture to trkInputFieldNames; 
function listTextAreaFields() {
  var txflds=document.getElementsByTagName('textarea');
  var txf=txflds.length;
  for (var i=0; i < txf; i++)
  {
	 trkTxtFieldNames.push(txflds[i].name);
  } 
} 

// this gets the candidate fields found on the page (listInputFields and listTextAreaFields) and creates data list if they are listed as capture fields 
function captureFormData() {
	var firstdelimiter='';
	for (var i=0; i < trkInputFieldNames.length; i++) {
		var fieldName = trkInputFieldNames[i];
		var fieldValue =  document.getElementsByName(fieldName).item(0).value.trim();
		if (fieldValue !='') { 
		trkFieldData = (trkFieldData + firstdelimiter + fieldName + '~' + fieldValue.replace('|','').replace('~',' ') + '|');
		firstdelimiter='~';
		}
	}
	trkInputFieldNames='';

	for (var i=0; i < trkTxtFieldNames.length; i++) {
		var txFieldName = trkTxtFieldNames[i];
		var txFieldValue =  document.getElementsByName(txFieldName).item(0).value.trim();
		if (txFieldValue !='') { 
		trkFieldData = (trkFieldData + firstdelimiter + txFieldName + '~' + txFieldValue.replace('|','').replace('~',' ') + '|');
		firstdelimiter='~';
		}
	}
	trkTxtFieldNames='';
} 

// this records the page load, evoked by setCookie() after the cookie ID is known
function LogLoad() {
/*	  var output='';
	  output='Protocol: ' + trkProtocol; 
	  output=output + '<br>Host: ' + trkHost; 
	  output=output + '<br>Path: ' + trkPath; 
	  output=output + '<br>Query String is: ' + trkQueryString; 
	  output=output + '<br>IP is: ' + trkIP; 
	  output=output + '<br>Referrer is: ' + trkReferrer; 
	  output=output + '<br>Cookie ID is: ' + trkCookieID; 
	  output=output + '<br>AIMG Site ID is: ' + trkSiteCode; 
	  output=output + '<br>User Agent is: ' + trkAgent; 
	  document.getElementById('aimgBlock').innerHTML=output; */

	  var xhr = new XMLHttpRequest();
	  xhr.open('POST', trkBaseURL + '/aimgTrkLogLoad.cfm',true);
	  xhr.setRequestHeader('Content-Type', 'text/plain');
	  xhr.onload = function() {
		  if (xhr.status === 200) {
			  var userInfo = xhr.responseText;
			  trkLoadRecordID= userInfo;
			  listInputFields();
			  listTextAreaFields();
		  }
	  };
	  xhr.send(trkProtocol + ' | ' + trkHost + ' | ' + trkPath + ' | ' + trkQueryString + ' | ' + trkIP + ' | '+ trkReferrer + ' | '+ trkCookieID + ' | '+ trkSiteCode + ' | ' + trkAgent)
}

// this records the page exit, evoked onbeforeunload and processed only if there is a record to update with exit time
function LogExit() {
	if (trkLoadRecordID !='') {
		if (trkInputFieldNames.length > 0) {
			captureFormData();
		} 
		var xhr2 = new XMLHttpRequest();
		xhr2.open('POST', trkBaseURL + '/aimgTrkLogExit.cfm',true);
		xhr2.setRequestHeader('Content-Type', 'application/x-www-form-urlencoded');
		var senddata='id=' + trkLoadRecordID + '&trkData=' + trkFieldData.replace('&',' and ');
		xhr2.send(senddata);
		trkExitRecorded = 1;
	} 
}
















