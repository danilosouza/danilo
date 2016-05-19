/* jspp */
function fetchRefs(element, vars)
{
if (!vars) vars = {};
var n = element.childNodes;
for (var i=0; i<n.length; i++) {
var e = n[i];
fetchRefs(e, vars);
var c = e.className;
if (c) {
c = c.split(" ");
for (var x=0; x<c.length; x++) {
var d = c[x];
if (d.substring(0,1)=='@') {
if (d.substring(1,2)=='@') {
var n = d.substring(2);
if (!vars[n]) vars(n) = [];
vars[n].push(e);
}
vars[d.substring(1)] = e;
}
}
}
}
return vars;
}
function addHtml(element, string, before, vars)
{
if (vars && typeof vars != 'object') vars = {};
if (!before) before = null;
else if (typeof before != 'object') before = element.firstChild;
try {
var container = document.createElement("span");
container.innerHTML = string;
if (vars) fetchRefs(container, vars);
container = container.childNodes;
for (var i=0; i<container.length; i++)
element.insertBefore(container[i], before);
}
catch (e) {
alert("addHtml; special case needed for "+element.tagName+" ("+e+")");
}
return vars;
}
function addSlashes(txt)
{
txt = txt.replace(/\\/g, "\\\\");
txt = txt.replace(/'/g, "\\'");
return txt.replace(/"/g, '\\"');
}
function clearModal(modalTop)
{
modalTop.parentNode.removeChild(modalTop);
var selects = document.getElementsByTagName("select");
for (var i=0; i<selects.length; i++)
selects[i].style.visibility='visible';
}
function showModal(html,vars)
{
var selects = document.getElementsByTagName("select");
for (var i=0; i<selects.length; i++)
selects[i].style.visibility='hidden';
var body = document.body;
var top = body.parentNode;
var h = window.innerHeight || document.documentElement.clientHeight || body.clientHeight;
var w = window.innerWidth || document.documentElement.clientWidth || body.clientWidth;
var t = (window.pageYOffset || document.documentElement.scrollTop || body.scrollTop) + h/10;
var l = (window.pageXOffset || document.documentElement.scrollLeft || body.scrollLeft) + w/10;
return addHtml(body, '<span class=\'@modalTop\'> <div style=\'position: absolute; top: 0px; left: 0px; padding: 0px; width: '+(top.scrollWidth)+'px; height: '+(top.scrollHeight)+'px; background-color: #454545; opacity: 0.55; -moz-opacity: 0.55; filter: alpha(opacity=55); z-index: 999;\'></div> <div style=\'position: absolute; top: '+(t)+'px; left: '+(l)+'px; width: '+(w*8/10)+'px; height: '+(h*8/10)+'px; z-index: 1000; overflow: auto;\'>'+(html)+'</div> </span>' , false, vars);
}
var Autocompleter = {}
Autocompleter.Base = function() {};
Autocompleter.Base.prototype = {
baseInitialize: function(element, options) {
this.element		 = $(element);
this.hasFocus		= false;
this.changed		 = false;
this.active			= false;
this.index			 = 0;
this.entryCount	= 0;
this.elements	 = [];
this.popups 	 = [];
if (this.setOptions)
this.setOptions(options);
else
this.options = options || {};
this.options.paramName		= this.options.paramName || this.element.name;
this.options.tokens			 = this.options.tokens || [];
this.options.frequency		= this.options.frequency || 0.4;
this.options.className		= this.options.className || "autocomplete";
if (this.options.minChars===false) this.options.minChars = 1;
this.options.onShow			 = this.options.onShow ||
function(element, update){
if(!update.style.position || update.style.position=='absolute') {
update.style.position = 'absolute';
Position.clone(element, update, {setHeight: false, offsetTop: element.offsetHeight});
}
Element.show(update);
};
this.options.onHide = this.options.onHide ||
function(element, update){
Element.hide(update);
};
if (typeof(this.options.tokens) == 'string')
this.options.tokens = new Array(this.options.tokens);
this.observer = null;
this.element.setAttribute('autocomplete','off');
Event.observe(this.element, "blur", this.onBlur.bindAsEventListener(this));
Event.observe(this.element, "keypress", this.onKeyPress.bindAsEventListener(this));
Event.observe(this.element, "focus", this.activate.bindAsEventListener(this));
},
show: function() {
for (i=0; i<this.elements.length; i++)
this.options.onShow(this.elements[i], this.popups[i]);
},
hide: function() {
this.stopIndicator();
for (i=0; i<this.elements.length; i++)
this.options.onHide(this.elements[i], this.popups[i]);
},
startIndicator: function() {
if(this.options.indicator) Element.show(this.options.indicator);
},
stopIndicator: function() {
if(this.options.indicator) Element.hide(this.options.indicator);
},
onKeyPress: function(event) {
if(this.active)
switch(event.keyCode) {
case Event.KEY_RETURN:
this.selectEntry();
Event.stop(event);
case Event.KEY_ESC:
this.hide();
this.active = false;
Event.stop(event);
return;
case Event.KEY_LEFT:
case Event.KEY_RIGHT:
return;
case Event.KEY_UP:
this.markPrevious();
this.render();
if(navigator.appVersion.indexOf('AppleWebKit')>0) Event.stop(event);
return;
case Event.KEY_DOWN:
this.markNext();
this.render();
if(navigator.appVersion.indexOf('AppleWebKit')>0) Event.stop(event);
return;
}
else
if(event.keyCode==Event.KEY_RETURN)
return;
this.changed = true;
this.hasFocus = true;
if(this.observer) clearTimeout(this.observer);
this.observer =
setTimeout(this.onObserverEvent.bind(this), this.options.frequency*1000);
},
activate: function() {
this.changed = false;
this.hasFocus = true;
this.getUpdatedChoices();
},
onHover: function(event) {
var element = Event.findElement(event, 'LI');
if(this.index != element.autocompleteIndex)
{
this.index = element.autocompleteIndex;
this.render();
}
Event.stop(event);
},
onClick: function(event) {
var element = Event.findElement(event, 'LI');
this.index = element.autocompleteIndex;
this.selectEntry();
this.hide();
},
onBlur: function(event) {
setTimeout(this.hide.bind(this), 250);
this.hasFocus = false;
this.active = false;
},
render: function() {
for (var p = 0; p < this.popups.length; p++) {
for (var i = 0; i < this.entryCount; i++) {
if (this.index==i) Element.addClassName(this.getEntry(p,i),"selected");
else Element.removeClassName(this.getEntry(p,i),"selected");
}
if (!this.entryCount) Element.addClassName(this.popups[p],"no_autocomplete");
else Element.removeClassName(this.popups[p],"no_autocomplete");
}
if(this.hasFocus) {
this.show();
this.active = true;
}
},
markPrevious: function() {
if(this.index > 0) this.index--
else this.index = this.entryCount-1;
},
markNext: function() {
if(this.index < this.entryCount-1) this.index++
else this.index = 0;
},
getEntry: function(p,index) {
return this.popups[p].firstChild.childNodes[index];
},
modalSearch: function() {
var l = this.modalList;
if (!l) return;
l.innerHTML = "<center><i>Searching...</i></center>";
var v = this.modalFilter.value;
var options = {
asynchronous: true,
onComplete: this.modalResults.bind(this),
parameters: "lst=1&" + encodeURIComponent(this.options.paramName) + "=" + encodeURIComponent(v)
}
new Ajax.Request(this.url, options);
},
modalResults: function(request) {
var sep = String.fromCharCode(1);
var sep2 = String.fromCharCode(2);
var lines = request.responseText.split("\n");
var headers = lines.shift().split(sep);
var trs = [];
var data = [];
for (var i=0; i<lines.length; i++) {
var tds = [];
var cols = lines[i].split(sep);
var colData = [];
for (var j=0; j<cols.length; j++) {
var r = cols[j].escapeHTML().split(sep2);
var t = r.shift();
colData.push(t);
if (r.length) t += " <i>("+r.join(", ")+")</i>";
tds.push("<td>"+t+"</td>");
}
data.push(colData);
trs.push( "<tr"+(i&1 ? " class='alt'" : "")+" style='cursor: pointer'>"+tds.join("")+"</tr>\n" );
}
if (trs.length) this.modalList.innerHTML = "<table><tbody>"+trs.join("")+"</tbody></table>";
else this.modalList.innerHTML = "<center><b>No results matching filter.</b></center>";
var me = this;
var highlight = function()
{
this.style.backgroundColor = "white";
}
var unhighlight = function()
{
this.style.backgroundColor = "";
}
var modalTop = this.modalTop;
var click = function()
{
var d = this.rowData;
for (var i=0; i<d.length; i++) {
var h = document.getElementsByName(headers[i]);
if (h.length!=1) continue;
h[0].value = d[i];
}
clearModal(modalTop);
}
trs = this.modalList.getElementsByTagName('TR');
for (var i=0; i<trs.length; i++) {
var tr = trs[i];
tr.rowData = data[i];
tr.onmouseover = highlight;
tr.onmouseout = unhighlight;
tr.onclick = click;
}
},
selectEntry: function() {
this.active = false;
if (this.index==this.moreOption) {
showModal( '<div style=\'padding: 8px; background-color: #efefff; border: 2px solid #8080f0;\'><form class=\'@form\' action=\'javascript:void(0)\' style=\'display: inline\'>&nbsp;&nbsp;<b>Filter:</b>&nbsp;<input type=\'line\' class=\'@modalFilter\'}}\' /></form>&nbsp;&nbsp;<a class=\'@search\' href=\'javascript:void(0)\'>Search!</a>&nbsp;&nbsp;<a class=\'@clearFilter\' href=\'javascript:void(0)\'>Show all</a>&nbsp;&nbsp;<a class=\'@cancel1\' href=\'javascript:void(0)\'>Cancel</a><div class=\'@modalList modalList\' style=\'margin-top: 10px; \'></div><br /><div style=\'width: 95%; text-align: right;\'><a href=\'javascript:void(0)\' class=\'@cancel2\'>Cancel</a></div></div>' , this);
var me = this;
this.cancel1.onclick = this.cancel2.onclick = function() { clearModal(me.modalTop); }
this.search.onclick = this.form.onsubmit = function() { me.modalSearch(); }
this.clearFilter.onclick = function() { me.modalFilter.value=""; me.modalSearch(); }
if (this.index>6) this.modalFilter.value = this.element.value;
this.modalFilter.focus();
this.modalSearch();
if (self.initLinks) initLinks(this.modalTop);
return;
}
for (i=0; i<this.elements.length; i++) {
if (!this.popups[i]) continue;
var value = this.getEntry(i,this.index).firstChild.nodeValue;
if (value=="N/A") value = "";
if (this.element==this.elements[i]) {
var lastTokenPos = this.findLastToken();
if (lastTokenPos != -1) {
var newValue = this.element.value.substr(0, lastTokenPos + 1);
var whitespace = this.element.value.substr(lastTokenPos + 1).match(/^\s+/);
if (whitespace) newValue += whitespace[0];
value = newValue + value;
}
}
this.elements[i].value = value;
}
this.element.focus();
},
updateChoices: function(choices) {
if(this.changed || !this.hasFocus) return;
choices = choices.split("\n");
var sep = String.fromCharCode(1);
var sep2 = String.fromCharCode(2);
var newHeaders = choices[0].split(sep);
choices.shift();
if (newHeaders != this.headers) {
// Headers have changed -> update popups
for (i=0; i<this.popups.length; i++)
this.popups[i].parentNode.removeChild(this.popups[i]);
this.popups = [];
this.elements = [];
for (i=0; i<newHeaders.length; i++) {
var h = newHeaders[i];
var e = document.getElementsByName(h);
if (!e || e.length!=1) continue;
e = e[0];
var p = document.createElement("div");
p.className = this.options.className;
Element.hide(p);
e.parentNode.insertBefore(p, e.nextSibling);
this.elements[i] = e;
this.popups[i] = p;
if (this.active) this.options.onShow(e,p);
}
this.headers = newHeaders;
}
if (choices.length>0 && choices[choices.length-1]=="") choices.pop();
for (i=0; i<this.popups.length; i++)
this.popups[i].innerHTML = ""; // (choices.length>0 ? "" : "???");
choices.push("");
this.moreOption = choices.length-1;
//		this.moreOption = -1;
for (i=0; i<choices.length; i++) {
cols = choices[i].split(sep);
for (j=0; j<this.popups.length; j++) {
if (!this.popups[j]) continue;
var ul = this.popups[j].firstChild;
if (!ul) {
ul = document.createElement("ul");
this.popups[j].appendChild(ul);
}
var li = document.createElement("li");
if (!cols[j]) {
if (i==this.moreOption) {
if (i) {
cols[j] = i>6 ? "More.." : "Show all..";
li.className = "more";
}
else {
cols[j] = "Not yet known..";
li.className = "unknown";
}
}
else {
cols[j]="N/A";
li.className = "notavailable";
}
}
var cs = cols[j].split(sep2);
li.appendChild(document.createTextNode(cs.shift() || ""));
if (cs[0]) {
var span = document.createElement('span');
span.style.fontStyle = 'italic';
span.style.marginLeft = '5px';
span.style.color = '#404040';
span.appendChild(document.createTextNode("("+cs.join(", ")+")"));
li.appendChild(span);
}
li.style.width = "99%";
li.autocompleteIndex = i;
this.addObservers(li);
ul.appendChild(li);
}
}
this.entryCount = choices.length;
this.stopIndicator();
this.index = 0;
this.render();
},
addObservers: function(element) {
Event.observe(element, "mouseover", this.onHover.bindAsEventListener(this));
Event.observe(element, "click", this.onClick.bindAsEventListener(this));
},
onObserverEvent: function() {
this.changed = false;
if(this.getToken().length>=this.options.minChars) {
this.startIndicator();
this.getUpdatedChoices();
} else {
this.active = false;
this.hide();
}
},
getToken: function() {
var tokenPos = this.findLastToken();
if (tokenPos != -1)
var ret = this.element.value.substr(tokenPos + 1).replace(/^\s+/,'').replace(/\s+$/,'');
else
var ret = this.element.value;
return /\n/.test(ret) ? '' : ret;
},
findLastToken: function() {
var lastTokenPos = -1;
for (var i=0; i<this.options.tokens.length; i++) {
var thisTokenPos = this.element.value.lastIndexOf(this.options.tokens[i]);
if (thisTokenPos > lastTokenPos)
lastTokenPos = thisTokenPos;
}
return lastTokenPos;
}
}
Ajax.Autocompleter = Class.create();
Object.extend(Object.extend(Ajax.Autocompleter.prototype, Autocompleter.Base.prototype), {
initialize: function(element, url, options) {
this.baseInitialize(element, options);
this.options.asynchronous	= true;
this.options.onComplete		= this.onComplete.bind(this);
this.options.defaultParams = this.options.parameters || null;
this.url = url;
},
getUpdatedChoices: function() {
entry = encodeURIComponent(this.options.paramName) + '=' +
encodeURIComponent(this.getToken());
this.options.parameters = this.options.callback ?
this.options.callback(this.element, entry) : entry;
if(this.options.defaultParams)
this.options.parameters += '&' + this.options.defaultParams;
new Ajax.Request(this.url, this.options);
},
onComplete: function(request) {
this.updateChoices(request.responseText);
}
});
