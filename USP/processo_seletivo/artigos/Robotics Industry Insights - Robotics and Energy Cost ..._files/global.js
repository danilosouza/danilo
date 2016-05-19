function ResetSticky(val,callback){
	 if (val != undefined){
		 stickypos=val;
	 }else{
		 stickypos="auto";
	 }
	$('.HeaderLinks').css('left', stickypos);
	$('.HeaderLinks').css('right', stickypos);
	
	if (callback && typeof(callback) === "function") {  
        callback();  
    }
 }
 
 function SideBars(){
	 $('.ToggleMenu').click(function(e){
		 e.preventDefault();
	 });
	 $('.ToggleSearch').click(function(e){
		 e.preventDefault();
	 });
	 
	 $('.ToggleMenu').sidr({
      name: 'leftside',
	  side:'left',
	  
	  onOpen: function() {
			 ResetSticky();
		  },
		  onClose: function() {
			 ResetSticky(10);
		  }
		  
	 	});
		
		
		 $('.ToggleSearch').sidr({
      name: 'rightside',
	  side:'right',
	  
	  onOpen: function() {
			 ResetSticky();
		  },
		  onClose: function() {
			 ResetSticky(10);
		  }
		  
	 	});
   
}


function SideMenu(){
	
	$('.MainLink ').click(function(e){
		e.preventDefault();
		$(this).parent().find('.SubNav').slideToggle('fast');
	});
}

/*Featured-----------------------------------------------------------------*/

var FPNextIndex = 0;
var FPintval="";
var FPTotalSlides = 0;
var FPAutoRotate = true;
var FPRotationTime = 8000;
function FPSetInterval(){
	if(FPAutoRotate == true){
		FPintval = window.setTimeout( "RotateFP()", FPRotationTime );
		}
}
function FPClearInterval(){
	if(FPintval!=""){
        window.clearInterval(FPintval);
        FPintval="";
	}
}


function ChangeFP(Next){
	
	/*$('.FP.active' ).removeClass('active');
	$('#FPNav li').removeClass('active');
	$('#FPContent div:eq(' + Next +')').addClass('active');
	$('#FPNav li:eq(' + Next +')').addClass('active');*/
	
	$('.FPCounter span.currentFP').html(Next + 1);/*Needed so user sees the nnumber change*/
	
	$('.FP.active' ).stop().fadeOut( 'fast', function() {
		// Animation complete.
		$(this).removeClass('active');
		$('#FPNav li').removeClass('active');
		
		$('#FPContent div:eq(' + Next +')').fadeIn( 'fast', function() {
			// Animation complete.
			$('.FPCounter span.currentFP').html(Next + 1);/*Corrects for overly fast clicking*/
			$(this).addClass('active');
			$('#FPNav li:eq(' + Next +')').addClass('active');
		});
	
  	});
	
	
	/*$('.FP').removeClass('active');
	$('#FPNav li').removeClass('active');*/
	
	
	/*$('#FPContent div:eq(' + Next +')').addClass('active');
	$('#FPNav li:eq(' + Next +')').addClass('active');*/
}


function RotateFP(){
	FPNextIndex+=1;
	if (FPNextIndex >= FPTotalSlides)
	{
		FPNextIndex=0;
	}
	ChangeFP(FPNextIndex);
	FPSetInterval();
}


function FeaturedProduct(){
	FPClearInterval();
	FPTotalSlides = $("#FPNav ul > li").size();
	
	$('#FPNav li a').click(function(e){
		e.preventDefault();	
		FPClearInterval();  
		FPNextIndex = $(this).parent().index();
		ChangeFP(FPNextIndex);
	});
	
	$('.NextFP').click(function(e){
		e.preventDefault();	
		FPClearInterval();	  
		FPNextIndex+=1;
		if (FPNextIndex >= FPTotalSlides)
		{
			FPNextIndex=0;
		}
		ChangeFP(FPNextIndex);
		
	});
	$('.PrevFP').click(function(e){
		e.preventDefault();
		FPClearInterval();		  
		FPNextIndex-=1;
		if (FPNextIndex < 0)
		{
			FPNextIndex=FPTotalSlides-1;
		}
		ChangeFP(FPNextIndex);
		
	});
	
	//Stop Rotation on MouseEnter/Start on Mouse Leave
	$('#FeaturedProduct').mouseenter(function(e){
		FPClearInterval();
	}).mouseleave(function(e){
		FPSetInterval();
	});
	
	
	$('#FPNav li:eq(' + 0 +')').addClass('active');
	$('#FPContent div:eq(' + 0 +')').addClass('active');
	FPSetInterval();
}

/*BrowseBy------------------------------------------------------*/
var intval="";

function SetInterval(){
		intval = window.setTimeout( "CloseBrowse()", 3000 );
}
function ClearInterval(){
	if(intval!=""){
        window.clearInterval(intval);
        intval="";
	}
}
	
function CloseBrowse(){
	$('.BrowseByDD').fadeOut('fast');
	$('.BrowseBy').removeClass('active');
}
	
function BrowseBy(){
	
	$('.BrowseBy').click(function(e){
	e.preventDefault();
		var DDDisplay = $('.BrowseByDD').css('display');
		if(DDDisplay == 'block'){
			$('.BrowseByDD').fadeOut('fast');
		    $(this).removeClass('active');
		} else{
			$('.BrowseByDD').fadeIn('fast');
		    $(this).addClass('active');
		}
	});

	$('.BrowseBy').mouseenter(function(){
		ClearInterval();
		var DDDisplay = $('.BrowseByDD').css('display');
		if(DDDisplay != 'block'){
			$('.BrowseByDD').fadeIn('fast');
		    $(this).addClass('active');
		}
	});
	$('.BrowseBy').mouseleave(function(){
		SetInterval();
	});

	
	$('.BrowseByDD').mouseenter(function(){
		ClearInterval();
	});
	$('.BrowseByDD').mouseleave(function(){
		SetInterval();
	});



	$('.BrowseByDD .Close').click(function(e){
	e.preventDefault();
			$('.BrowseByDD').fadeOut('fast');
			 $('.BrowseBy').removeClass('active');
			 ClearInterval();
	
	});
	
	
	
	$('.BrowseByNav a').click(function(e){
	e.preventDefault();
		var relref = $(this).attr('rel');
		$('.BrowseByNav a').removeClass('active');
		$('.BrowseByDDBox').removeClass('active');
		$(this).addClass('active');
		$('.BrowseByDDBox[rel="'+relref+'"]').addClass('active');
	});
	
	

	
}
/*Cat Nav--------------------*/

function SetCatNav(){
	$('.ToggleCat').click(function(e){
		e.preventDefault();
		$('.CatNav').slideToggle('fast');
		$(this).toggleClass('active');
	});
	
	$('.ToggleCat2').click(function(e){
		e.preventDefault();
		$('.CatNav').slideToggle('fast');
		$('.ToggleCat').toggleClass('active');
	});
	
}

/*Generic Toggle--------------------*/
function SetToggle(){
	$('.Toggle').click(function(e){
		e.preventDefault();
		var togglethis = $(this).attr('rel');
		$('.'+ togglethis).slideToggle('fast');
		
	});
}

/*PAgination Highlight---------------*/
function HighlightPagination(){
$('.pagination a:not([rel])').parent().addClass('active');
}
/*Wrap Videos---------------*/
function WrapVideos(){
	$( 'iframe' ).wrap( "<div class='flex-video'></div>" );
}

/*---------------------------------------------------------------*/
$(document).ready(function(){
	SideMenu();
	 SideBars();
	 FeaturedProduct();
	 BrowseBy();
	 SetCatNav();
	 SetToggle();
	// WrapVideos();
	// HighlightPagination();
	
/*  $('.togglemenu').sidr();*/


	$('.touch a.toplevel').parent().click(function(e){
		var subnav = $(this).find('.SubNav');
		if($(subnav).css('display')=='block'){
			$(subnav).hide();
			$(this).removeClass('active');
			$(this).addClass('inactive');
		}else{
			$('.touch a.toplevel').parent().addClass('inactive');
			$('.SubNav').hide();
			$(subnav).show();
			$(this).removeClass('inactive');
			$(this).addClass('active');
			
		}
		
	});
	$('.touch a.toplevel').click(function(e){
		e.preventDefault();
	});
  
	$('.SearchCats').hover(function(e){
	/*e.preventDefault();*/
		$('.SearchDD').toggleClass('active');
		$('.SearchCats a').toggleClass('active');
	});
	
	$('.SearchCats a').click(function(e){
	e.preventDefault();
	
	});
	
	
	$('#category li.main a.main').click(function(e){
	e.preventDefault();
	if($(this).parent().find('ul').hasClass('active')){
		$(this).parent().find('ul').removeClass('active');
		$(this).parent().removeClass('active');
	}else{
		$(this).parent().find('ul').addClass('active');
		$(this).parent().addClass('active');
	}
	});
	
	$('#category li.main').mouseenter(function(){
		$(this).addClass('active');
	$(this).find('ul').addClass('active');
	});
	$('#category li.main').mouseleave(function(){
		$(this).removeClass('active');
	$(this).find('ul').removeClass('active');
	});
	
	
});

function MM_goToURL() { //v3.0
  var i, args=MM_goToURL.arguments; document.MM_returnValue = false;
  for (i=0; i<(args.length-1); i+=2) eval(args[i]+".location='"+args[i+1]+"'");
}

// company browse
function checkCompanyBrowse() {
	var i;
	//var args = document.companyCats.member_type_id;
	var typeChecked = false;
	for (i=0; i<(4);i++) {
		if(document.companyCats.member_type_id[i].checked){
			typeChecked = true;
			break;
		}
	}
	if (typeChecked==false) {
		alert('Please select a company type to browse.');
		return false;
	} else {
		return true;
	}
	
}
/*for side search*/
function checkCompanyBrowse2() {
	var i;
	//var args = document.companyCats.member_type_id;
	var typeChecked = false;
	for (i=0; i<(4);i++) {
		if(document.companyCats2.member_type_id[i].checked){
			typeChecked = true;
			break;
		}
	}
	if (typeChecked==false) {
		alert('Please select a company type to browse.');
		return false;
	} else {
		return true;
	}
	
}
/*for results page*/
function checkCompanyBrowse3() {
	var i;
	//var args = document.companyCats.member_type_id;
	var typeChecked = false;
	for (i=0; i<(4);i++) {
		if(document.companyCats3.member_type_id[i].checked){
			typeChecked = true;
			break;
		}
	}
	if (typeChecked==false) {
		alert('Please select a company type to browse.');
		return false;
	} else {
		return true;
	}
	
}


// header search
function checkSearch() {
	if (document.searchForm.keywords.value=='') {
	alert('Please enter a keyword to search on.');
	return false;
	}
	return true;
}


//Function to Pop-Up window
function openPop(URLJump) { 
//below allows the java to determine the screen width and height
//the -### at the end of each is half the size of the window
//below is to align to top
	var top = 0;
//below is to center the window vertical
//	var top = (screen.height/2)-225;
//below is to center the window horizontal
	var left = (screen.width/2)-400;
//define the features of the window
	var popFeatures =  " status=yes,scrollbars=yes,resizable=yes,toolbar=yes,location=yes,width=800,height=800,top=" + top + ",left=" + left;
//open the window
	var windowName = "";
	window.open(URLJump,windowName,popFeatures);
}

//Function to  larger Pop-Up window
function openPopLRG(URLJump) { 
//below allows the java to determine the screen width and height
//the -### at the end of each is half the size of the window
//below is to align to top
	var top = 0;
//below is to center the window vertical
//	var top = (screen.height/2)-225;
//below is to center the window horizontal
	var left = (screen.width/2)-475;
//define the features of the window
	var popLRGFeatures =  " status=yes,scrollbars=yes,resizable=yes,toolbar=yes,location=yes,width=950,height=800,top=" + top + ",left=" + left;
//open the window
	var windowName = "";
	window.open(URLJump,windowName,popLRGFeatures);
}

//Function to  larger Pop-Up window
function openPopSML(URLJump) { 
//below allows the java to determine the screen width and height
//the -### at the end of each is half the size of the window
//below is to align to top
	var top = 0;
//below is to center the window vertical
//	var top = (screen.height/2)-225;
//below is to center the window horizontal
	var left = (screen.width/2)-200;
//define the features of the window
	var popSMLFeatures =  " status=yes,scrollbars=yes,resizable=yes,toolbar=yes,location=yes,width=400,height=300,top=" + top + ",left=" + left;
//open the window
	var windowName = "";
	window.open(URLJump,windowName,popSMLFeatures);
}