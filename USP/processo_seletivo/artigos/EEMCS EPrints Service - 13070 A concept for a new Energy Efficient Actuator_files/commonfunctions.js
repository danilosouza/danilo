//*****************************************************************************************
//*** Browser Stats
//*****************************************************************************************
var isNav = false;
var isIE  = false;
var isMac = false;
var isWin = false;

var isNS4 = false;
var isNS40 = false;    // NS 4.08 will not displayed QT from  RTSP server so we send a message
var isIE4 = false;
var isIE5 = false;
var isNS6 = false;

//*** Determine Browser Stats

if (navigator.appName == "Netscape") { 
   isNav = true; 
} else { 
   isIE = true; 
}

if (navigator.appVersion.indexOf("Mac") != -1) isMac = true;
if (navigator.appVersion.indexOf("Win") != -1) isWin = true;

//*** Determine Browser version

isNS4 = (document.layers) ? true : false;
isIE4 = (document.all && !document.getElementById) ? true : false;
isIE5 = (document.all && document.getElementById) ? true : false;
isNS6 = (!document.all && document.getElementById) ? true : false;

//*****************************************************************************************
//*** FUNCTIONS: win & smallWin:  open popup windows
//*****************************************************************************************
function win(pagename, scrollbars, width, height) { 
  if (scrollbars=='yes') width = width + 17;
  
  if ((navigator.appVersion.indexOf('Win') != -1) && (navigator.appName == "Netscape")) 
     popWin = window.open(pagename,"indigo","height="+height+",width="+width+",status=no,toolbar=no,menubar=no,resizable=yes,scrollbars="+scrollbars);
  else if (( navigator.appVersion.indexOf('Mac') != -1) && (navigator.appName == "Netscape"))
     popWin = window.open(pagename,"indigo","height="+height+",width="+width+",status=no,toolbar=no,menubar=no,resizable=yes,scrollbars="+scrollbars);
  else if (( navigator.appVersion.indexOf('Mac') != -1) && (navigator.appName == "Microsoft Internet Explorer"))
     popWin = window.open(pagename,"indigo","height="+(height-16)+",width="+(width-16)+",status=no,toolbar=no,menubar=no,resizable=yes,scrollbars="+scrollbars);
  else popWin = window.open(pagename,"indigo","height="+height+",width="+width+",status=no,toolbar=no,menubar=no,resizable=yes,scrollbars="+scrollbars);
 
  if (popWin.opener == null) popWin.opener = self;    // Give a handle of the current window to the popup, so it can easily call it back.
        
  popWin.focus(); // Switch the focus on the already opened popup
}

// self.name = 'mainWindow';

function smallWin(pagename, scrollbars, width, height) { 
  if (scrollbars=='yes') width = width + 17;
  
  if ((navigator.appVersion.indexOf('Win') != -1) && (navigator.appName == "Netscape"))
     popSmall = window.open(pagename,"demo","height="+height+",width="+width+",status=no,toolbar=no,menubar=no,resizable=no,scrollbars="+scrollbars);
  else if (( navigator.appVersion.indexOf('Mac') != -1) && (navigator.appName == "Netscape"))  
     popSmall = window.open(pagename,"demo","height="+height+",width="+width+",status=no,toolbar=no,menubar=no,resizable=no,scrollbars="+scrollbars);
  else if (( navigator.appVersion.indexOf('Mac') != -1) && (navigator.appName == "Microsoft Internet Explorer"))
     popSmall = window.open(pagename,"demo","height="+(height-16)+",width="+(width-16)+",status=no,toolbar=no,menubar=no,resizable=no,scrollbars="+scrollbars);
  else popSmall = window.open(pagename,"demo","height="+height+",width="+width+",status=no,toolbar=no,menubar=no,resizable=no,scrollbars="+scrollbars);

  if (popSmall.opener == null) popSmall.opener = self;    // Give a handle of the current window to the popup, so it can easily call it back.

  popSmall.focus(); // Switch the focus on the already opened popup
}

function MM_reloadPage(init) {  //reloads the window if Nav4 resized
  if (init==true) with (navigator) {
     if ((appName=="Netscape")&&(parseInt(appVersion)==4)) {
          document.MM_pgW=innerWidth;
          document.MM_pgH=innerHeight;
          onresize=MM_reloadPage;
     }
  }
  else if (innerWidth!=document.MM_pgW || innerHeight!=document.MM_pgH) location.reload();
}

MM_reloadPage(true);

//=========================================================================================
// @campus common functions
//=========================================================================================

function myVoid()
{
}

function openPrintableWindow(theUrl)
{
  window.open(theUrl,'','toolbar=no,location=no,status=yes,menubar=yes,scrollbars=yes,resizable=no,width=600,height=600');
}

function renderOpenPrintableWindow(img,theUrl,text)
{
  document.write('<a class="menulink" href="javascript:myvoid();" onclick="openPrintableWindow(\'' + theUrl + '\'); return false;"><img alt="" src="' + img + '" width="14" height="12" border="0" >&nbsp;');
  document.write(text);
  document.write('</a>');
}

//The Siteconfig/Accessible version of printable windows
function renderOpenPrintableWindow2(img,theUrl,text,img_opennewwindow,alt_opennewwindow)
{
  document.write('<a class="menulink" href="javascript:myvoid();" onclick="openPrintableWindow(\'' + theUrl + '\'); return false;"><img alt="" src="' + img + '" width="14" height="12" border="0" >&nbsp;');
  document.write(text);
  document.write('&nbsp;<img src="' + img_opennewwindow + '" width="8" height="7" alt="' + alt_opennewwindow + '" border="0" style="vertical-align:baseline">');
  document.write('</a>');
}
