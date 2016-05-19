//*************************************************************************************
//*** menuEngine.js
//***
//*** included from: home.ch2
//***
//*** This javascript contains all the functions related to the functionality
//*** of the navigation menus via the animated buttons on the left Side of the pages
//*************************************************************************************

//**************************************************************************************************
//* Referencing Layers is different between Browsers and Browser Versions
//* Therefore set layerReference variables depending on Browsers & versions
//**************************************************************************************************

if (isNS6) {
   layerRef = "document.getElementById";     // example: document.getElementById(divName).style.visibility="visible";
   layerStyle = ".style";
   showIt = "visible";
} else if (isIE) {
   layerRef = "document.all";                // example: document.all[divName].style.visibility="visible";
   layerStyle = ".style";
   showIt = "visible";
} else {
  layerRef = "document.layers";                // example: document.layers[divName].visibility = "show";
  layerStyle = "";
  showIt = "show";
}

var hideIt = "hidden";
var isHomePage = false;

//**************************************************************************************************
//* ARRAY mainMenu[] contains info on all "main menus" (those accessed via the animated side buttons)
//*   [0] menuName : DIV name of Menu
//*   [1] imageRef : NAME attribute defined by the image Tag for the TEXT image below each Button
//*   [2] imageName Source     : normal State of TEXT image as defined in the Preload Function
//*   [3] imageNameOver Source : over State of TEXT image as defined in the Preload Function
//**************************************************************************************************
var mainMenu = new Array();
  mainMenu[0] = new Array("menuMain");

//* Constants for array element positions 

var C_menuName = 0;
var C_txtRef = 1;
var C_txtNormState = 2;
var C_txtOverState = 3;
  
//**************************************************************************************************
//* ARRAY subMenu[] contains info on the 1st level of sub menus for all mainMenus that have a submenu
//*   [0] subMenuName : DIV name of subMenu: the name includes the mainMenu name
//*   [1] imageRef : NAME attribute defined by the image Tag for the TEXT image below each Button
//*   [2] imageName Source     : normal State of TEXT image as defined in the Preload Function
//*   [3] imageNameOver Source : over State of TEXT image as defined in the Preload Function
//*
//*   note: to create subsequent subMenu levels ....
//**************************************************************************************************
var subMenu = new Array();
  subMenu[0] = new Array("menuMainInfoVoor",  "picminfovoor",  "imgminfovoor",  "imgminfovoor_o");
  subMenu[1] = new Array("menuMainInfoOver",  "picminfoover",  "imgminfoover",  "imgminfoover_o");
  subMenu[2] = new Array("menuMainNieuws",    "picmnieuws",    "imgmnieuws",    "imgmnieuws_o");
  subMenu[3] = new Array("menuMainVacatures", "picmvacatures", "imgmvacatures", "imgmvacatures_o");

//**************************************************************************************************
//* ARRAY rollOutTimer[] holds the timed Function call for rollOuts
//*    >> there is an array position for each menu Level 
//*
//* ARRAY G_currentMenuID[] holds the currently displayed MenuID; based on array Position
//*    >> there is an array position for each menu Level 
//**************************************************************************************************
var rollOutTimer = new Array();        
    rollOutTimer[0] = null;
    rollOutTimer[1] = null;
    
var G_currentMenuID = new Array();        //Holds the 
    G_currentMenuID[0] = null;            //for mainMenu (level=0)
    G_currentMenuID[1] = null;             //for subMenu (level=1)
      
var C_mainMenu = 0;           //constant which refers to the level of the mainMenu
var C_subMenu = 1;            //constant which refers to the level of the subMenu 

// var menuActive = 0;        //Set to true when a menu (DIV) is active (visible)

//**************************************************************************************************
// Main Animated Buttons:
//  1. on rollOver the animated button begins and the popMenu is displayed for this button
//     >> the text under the buttons are rolled Over in functions "hideMenu" and "showMenu"
//         since this rollOver image stays until the menu is Hidden
//     
//  2. on rollOut the timer [rollOutTimer] is set to hide the popMenu after X milliseconds  
//     by calling the the btnOut function
//
//     >> This timer gives the user a chance to roll the mouse over the menuItems.
//
//     >> In the popUp Menu layers another control is active to ensure the menu is   
//         displayed so long as the mouse is over one of the menu items.
//**************************************************************************************************

//**************************************************************************************************
//**** FUNCTION: menuOutTimer();
//**** >> Called from a mainAnimated button onMouseOut
//**** >> Activates the timer: after X milliseconds calls the function "timedOut" which hides the 
//****    menu Layer currently displayed via the variable "G_currentMenuID" which is set in "showMenu"
//**************************************************************************************************
function menuOutTimer(menuLevel) {
    rollOutTimer[menuLevel] = setTimeout("hideMenu(" + menuLevel + ", G_currentMenuID[" + menuLevel + "])", 800);
}

//**************************************************************************************************
//**** FUNCTION itemOutTimer() 
//**** >> Called when mouse moves out of a menuItem, thus setting the rollOutTimer on.
//**** >> If the mouse stays outside the menuItems for the specified milliseconds then the 
//****    function "hideMenu" is called
//**************************************************************************************************
function itemOutTimer(menuLevel) {
// menuActive = 0 

    //If this is a subMenu then set both main and sub Menu rollOutTimers

    if (menuLevel == C_subMenu) {
        rollOutTimer[C_mainMenu] = setTimeout("hideMenu(" + C_mainMenu + ", G_currentMenuID[" + C_mainMenu + "])", 800);
    }

    //Set rollOutTimer for the current menu level
    
    rollOutTimer[menuLevel] = setTimeout("hideMenu(" + menuLevel + ", G_currentMenuID[" + menuLevel + "])", 800);
}

//**************************************************************************************************
//**** FUNCTION itemOver()
//**** >> Called when a menuItem is rolled Over. 
//**** >> Clears the rollOutTimer thus keeping the menu displayed
//**************************************************************************************************
function itemOver(menuLevel) {

  //if this is a subMenu item then they mousedOut of a mainMenu item, but since they are now on a
  //subMenuItem we keep all menus displayed, so clear the rollOutTimer for both mainMenu and subMenu

  if (menuLevel == C_subMenu) {
      clearTimeout(rollOutTimer[C_mainMenu]);        //keeps mainMenu displayed if this is a subMenuItem
  }
  
  clearTimeout(rollOutTimer[menuLevel]);
// menuActive = 1
}

//**************************************************************************************************
//**** FUNCTION: showMenu (menuLevel, menuID);
//**** >> Called onMouseOver of a side animated button sending the menuName array position
//**** >> Checks if a pervious menu is currently displayed (waiting for rollOutTimer onMouseOut) in which
//****    case that layer is closed - the currently displayed menuID is stored in G_currentMenuID[]
//**** >> Displays the requested menuLayer via the passed variable "menuID"  
//**** >> please note that function changeImage is defined in the js file "images.js"
//**************************************************************************************************
function showMenu (menuLevel, menuID) {
  var layerName;

  //When the user has mousedOver another menu (main or sub) then check if another menu on this level
  //is already displayed (via the rollOutTimer) : if so then hide that menu level
  
  if (rollOutTimer[menuLevel] != null) {          
     clearTimeout(rollOutTimer[menuLevel]);
     hideMenu(menuLevel, G_currentMenuID[menuLevel]);
    
    //If the mouse is over a new mainMenu then we need to clear any subMenus that might be displayed
     if (menuLevel == C_mainMenu) {
         if (rollOutTimer[C_subMenu] != null) {
            clearTimeout(rollOutTimer[C_subMenu]);
            hideMenu(C_subMenu, G_currentMenuID[C_subMenu]);
        }
     }
  }
  
  //Now show the mousedOver menu (main or sub)

  if (menuLevel == C_mainMenu) {
        layerName = mainMenu[menuID][C_menuName];      //extract layerName from mainMenu Array
  } else if (menuLevel == C_subMenu) {
        layerName = subMenu[menuID][C_menuName];                  //extract layerName from subMeun Array
  }
  
  if (isNS6) {
     eval(layerRef + '("' + layerName + '")' + layerStyle + '.visibility="' + showIt + '"');
  } else {
     eval(layerRef + '["' + layerName + '"]' + layerStyle + '.visibility="' + showIt + '"');
  }
 
 if (menuLevel == C_subMenu) {
     changeImage('menuMain',  subMenu[menuID][C_txtRef], subMenu[menuID][C_txtOverState]);
 } 
 
 G_currentMenuID[menuLevel] = menuID;        //used in function "hideMenu"  
}

//**************************************************************************************************
//**** FUNCTION hideMenu(menuID) 
//**** >> Called onMouseOut of a menu layer function "setTimerOut" is called; when the specified 
//****     milliseconds have passed function "timedOut" is then called which calls this function
//**** >> Also called by showMenu if there is an menu currently displayed
//**** >> Hide the requested menu layer based on passed variable "menuID"
//**************************************************************************************************
function hideMenu(menuLevel, menuID) {
var layerName;

// if (menuActive == 0) {

  if (menuLevel == C_mainMenu)
  {
    // Ugly hack, to be able to use the same engine for both the homepage and the subpages
    // The isHomePage value is set by WebHare in the imagepreload javascript file
    if (isHomePage)
      return;
    else
      layerName = mainMenu[menuID][C_menuName];      //extract layerName from mainMenu Array
  }
  else if (menuLevel == C_subMenu)
  {
    layerName = subMenu[menuID][C_menuName];                  //extract layerName from subMenu Array
  }

  if (isNS6)
  {
     eval(layerRef + '("' + layerName + '")' + layerStyle + '.visibility="' + hideIt + '"');
  }
  else
  {
     eval(layerRef + '["' + layerName + '"]' + layerStyle + '.visibility="' + hideIt + '"');
  }


 if (menuLevel == C_subMenu) {
   changeImage('menuMain', subMenu[menuID][C_txtRef], subMenu[menuID][C_txtNormState]);
 }

// }
}


//**************************************************************************************************
//*** FUNCTION showDIV (divName)
//**** >> Show any "simple" Layer/DIV (NOT a menu DIV) .... like contactDiv defined in "footer.ch2"
//**************************************************************************************************

function showDiv (divName) {

  if (isNS6) {
     eval(layerRef + '("' + divName + '")' + layerStyle + '.visibility="' + showIt + '"');
  } else {
     eval(layerRef + '["' + divName + '"]' + layerStyle + '.visibility="' + showIt + '"');
  }
}

//**************************************************************************************************
//*** FUNCTION showDIV (divName)
//**** >> Hide any "simple" Layer/DIV (NOT a menu DIV) .... like contactDiv defined in "footer.ch2"
//**************************************************************************************************

function hideDiv (divName) {

  if (isNS6) {
     eval(layerRef + '("' + divName + '")' + layerStyle + '.visibility="' + hideIt + '"');
  } else {
     eval(layerRef + '["' + divName + '"]' + layerStyle + '.visibility="' + hideIt + '"');
  }
}