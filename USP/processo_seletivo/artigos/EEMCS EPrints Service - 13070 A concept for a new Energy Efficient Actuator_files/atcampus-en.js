
var preloadFlag=false;

//atcampus_Type: type of page being created. 0 = atcampus homepage. 1 = atcampus normal page.
function atcampus_paginaInit(atcampus_type)
{
    preload('imgminfovoor', '/webhare/minfovoor.gif');
  preload('imgminfovoor_o', '/webhare/minfovoor_o.gif');
  preload('imgminfoover', '/webhare/minfoover.gif');
  preload('imgminfoover_o', '/webhare/minfoover_o.gif');
  preload('imgmnieuws', '/webhare/mnieuws.gif');
  preload('imgmnieuws_o', '/webhare/mnieuws_o.gif');
  preload('imgmvacatures', '/webhare/mvacatures.gif');
  preload('imgmvacatures_o', '/webhare/mvacatures_o.gif');
  preload('imgminfovoor0', '/webhare/minfovoor0.gif');
  preload('imgminfovoor0_o', '/webhare/minfovoor0_o.gif');
  preload('imgminfovoor1', '/webhare/minfovoor1.gif');
  preload('imgminfovoor1_o', '/webhare/minfovoor1_o.gif');
  preload('imgminfovoor2', '/webhare/minfovoor2.gif');
  preload('imgminfovoor2_o', '/webhare/minfovoor2_o.gif');
  preload('imgminfovoor3', '/webhare/minfovoor3.gif');
  preload('imgminfovoor3_o', '/webhare/minfovoor3_o.gif');
  preload('imgminfovoor4', '/webhare/minfovoor4.gif');
  preload('imgminfovoor4_o', '/webhare/minfovoor4_o.gif');
  preload('imgminfovoor5', '/webhare/minfovoor5.gif');
  preload('imgminfovoor5_o', '/webhare/minfovoor5_o.gif');
  preload('imgminfovoor6', '/webhare/minfovoor6.gif');
  preload('imgminfovoor6_o', '/webhare/minfovoor6_o.gif');
  preload('imgminfoover0', '/webhare/minfoover0.gif');
  preload('imgminfoover0_o', '/webhare/minfoover0_o.gif');
  preload('imgminfoover1', '/webhare/minfoover1.gif');
  preload('imgminfoover1_o', '/webhare/minfoover1_o.gif');
  preload('imgminfoover2', '/webhare/minfoover2.gif');
  preload('imgminfoover2_o', '/webhare/minfoover2_o.gif');
  preload('imgminfoover3', '/webhare/minfoover3.gif');
  preload('imgminfoover3_o', '/webhare/minfoover3_o.gif');
  preload('imgminfoover4', '/webhare/minfoover4.gif');
  preload('imgminfoover4_o', '/webhare/minfoover4_o.gif');
  preload('imgminfoover5', '/webhare/minfoover5.gif');
  preload('imgminfoover5_o', '/webhare/minfoover5_o.gif');
  preload('imgmnieuws0', '/webhare/mnieuws0.gif');
  preload('imgmnieuws0_o', '/webhare/mnieuws0_o.gif');
  preload('imgmnieuws1', '/webhare/mnieuws1.gif');
  preload('imgmnieuws1_o', '/webhare/mnieuws1_o.gif');

  
  preload('imgNavEmpty',            '/webhare//spacer.gif');

    preload('imgNavrss_Over',         '/webhare/en_rss_over.gif');
    preload('imgNavnl_Over',          '/webhare/en_nl_over.gif');
    preload('imgNavsearch_Over',      '/webhare/en_search_over.gif');
    preload('imgNavcontact_Over',     '/webhare/en_contact_over.gif');

  
                preload('imgNavFirst',            '/webhare/nav_first_active.gif');
                preload('imgNavFirst_o',          '/webhare/nav_first_over.gif');
                preload('imgNavPrev',             '/webhare/nav_prev_active.gif');
                preload('imgNavPrev_o',           '/webhare/nav_prev_over.gif');
                preload('imgNavNext',             '/webhare/nav_next_active.gif');
                preload('imgNavNext_o',           '/webhare/nav_next_over.gif');
                preload('imgNavLast',             '/webhare/nav_last_active.gif');
                preload('imgNavLast_o',           '/webhare/nav_last_over.gif');
                preload('imgNavToc',            '/webhare/nav_toc_active.gif');
                preload('imgNavToc_o',            '/webhare/nav_toc_over.gif');

  preloadFlag=true;
}

//atcampus_Type: type of page being created. 0 = atcampus homepage. 1 = atcampus normal page.
function atcampus_printMenuLayers(atcampus_type)
{
  if (atcampus_type==0)
    isHomePage=true;
  document.write('<div id=\"menuMain\"><table width=\"76\" border=\"0\" cellspacing=\"0\" cellpadding=\"0\">');
document.write('<tr>');
document.write('<td height=\"17\">');
document.write('<a ');
document.write('href=\"#\" class=\"menuItem\" onMouseOver=\"itemOver(0); showMenu(1,0);\" onMouseOut=\"itemOutTimer(0);  menuOutTimer(1,0);\">');
document.write('<img alt=\"Info for\" src=\"/webhare/minfovoor.gif\" border=\"0\" width=\"76\" height=\"17\" name=\"picminfovoor\"><\/a><\/td><\/tr>');
document.write('<tr>');
document.write('<td height=\"15\">');
document.write('<a ');
document.write('href=\"#\" class=\"menuItem\" onMouseOver=\"itemOver(0); showMenu(1,1);\" onMouseOut=\"itemOutTimer(0);  menuOutTimer(1,1);\">');
document.write('<img alt=\"Info about\" src=\"/webhare/minfoover.gif\" border=\"0\" width=\"76\" height=\"15\" name=\"picminfoover\"><\/a><\/td><\/tr>');
document.write('<tr>');
document.write('<td height=\"15\">');
document.write('<a ');
document.write('href=\"#\" class=\"menuItem\" onMouseOver=\"itemOver(0); showMenu(1,2);\" onMouseOut=\"itemOutTimer(0);  menuOutTimer(1,2);\">');
document.write('<img alt=\"News\" src=\"/webhare/mnieuws.gif\" border=\"0\" width=\"76\" height=\"15\" name=\"picmnieuws\"><\/a><\/td><\/tr>');
document.write('<tr>');
document.write('<td height=\"17\">');
document.write('<a ');
document.write('href=\"http://www.utwente.nl/vacatures/en/\" class=\"menuItem\" onMouseOver=\"itemOver(0); showMenu(1,3);\" onMouseOut=\"itemOutTimer(0);  menuOutTimer(1,3);\">');
document.write('<img alt=\"Jobs\" src=\"/webhare/mvacatures.gif\" border=\"0\" width=\"76\" height=\"17\" name=\"picmvacatures\"><\/a><\/td><\/tr>');
document.write('<\/table><\/div>\n');
document.write('<div id=\"menuMainInfoVoor\">');
document.write('<table width=\"94\" border=\"0\" cellspacing=\"0\" cellpadding=\"0\">\n');
document.write('<tr>');
document.write('<td height=\"16\">');
document.write('<a ');
document.write('href=\"http://graduate.utwente.nl/\" class=\"menuItem\" onMouseOver=\"itemOver(1);     changeImage(\'menuMainInfoVoor\',\'picminfovoor0\',\'imgminfovoor0_o\');\" onMouseOut=\"itemOutTimer(1); changeImage(\'menuMainInfoVoor\',\'picminfovoor0\',\'imgminfovoor0\');\">');
document.write('<img src=\"/webhare/minfovoor0.gif\" alt=\"Prosp.Students\" border=\"0\" width=\"94\" height=\"16\" name=\"picminfovoor0\"><\/a><\/td><\/tr>');
document.write('<tr>');
document.write('<td height=\"15\">');
document.write('<a ');
document.write('href=\"http://www.utwente.nl/en/\" class=\"menuItem\" onMouseOver=\"itemOver(1);     changeImage(\'menuMainInfoVoor\',\'picminfovoor1\',\'imgminfovoor1_o\');\" onMouseOut=\"itemOutTimer(1); changeImage(\'menuMainInfoVoor\',\'picminfovoor1\',\'imgminfovoor1\');\">');
document.write('<img src=\"/webhare/minfovoor1.gif\" alt=\"Visitors\" border=\"0\" width=\"94\" height=\"15\" name=\"picminfovoor1\"><\/a><\/td><\/tr>');
document.write('<tr>');
document.write('<td height=\"15\">');
document.write('<a ');
document.write('href=\"http://www.utwente.nl/studenten/en/\" class=\"menuItem\" onMouseOver=\"itemOver(1);     changeImage(\'menuMainInfoVoor\',\'picminfovoor2\',\'imgminfovoor2_o\');\" onMouseOut=\"itemOutTimer(1); changeImage(\'menuMainInfoVoor\',\'picminfovoor2\',\'imgminfovoor2\');\">');
document.write('<img src=\"/webhare/minfovoor2.gif\" alt=\"Students\" border=\"0\" width=\"94\" height=\"15\" name=\"picminfovoor2\"><\/a><\/td><\/tr>');
document.write('<tr>');
document.write('<td height=\"15\">');
document.write('<a ');
document.write('href=\"http://www.utwente.nl/medewerkers/en/\" class=\"menuItem\" onMouseOver=\"itemOver(1);     changeImage(\'menuMainInfoVoor\',\'picminfovoor3\',\'imgminfovoor3_o\');\" onMouseOut=\"itemOutTimer(1); changeImage(\'menuMainInfoVoor\',\'picminfovoor3\',\'imgminfovoor3\');\">');
document.write('<img src=\"/webhare/minfovoor3.gif\" alt=\"Employees\" border=\"0\" width=\"94\" height=\"15\" name=\"picminfovoor3\"><\/a><\/td><\/tr>');
document.write('<tr>');
document.write('<td height=\"15\">');
document.write('<a ');
document.write('href=\"http://www.utwente.nl/en/press/\" class=\"menuItem\" onMouseOver=\"itemOver(1);     changeImage(\'menuMainInfoVoor\',\'picminfovoor4\',\'imgminfovoor4_o\');\" onMouseOut=\"itemOutTimer(1); changeImage(\'menuMainInfoVoor\',\'picminfovoor4\',\'imgminfovoor4\');\">');
document.write('<img src=\"/webhare/minfovoor4.gif\" alt=\"Press\" border=\"0\" width=\"94\" height=\"15\" name=\"picminfovoor4\"><\/a><\/td><\/tr>');
document.write('<tr>');
document.write('<td height=\"15\">');
document.write('<a ');
document.write('href=\"http://www.alumnus.utwente.nl/en/\" class=\"menuItem\" onMouseOver=\"itemOver(1);     changeImage(\'menuMainInfoVoor\',\'picminfovoor5\',\'imgminfovoor5_o\');\" onMouseOut=\"itemOutTimer(1); changeImage(\'menuMainInfoVoor\',\'picminfovoor5\',\'imgminfovoor5\');\">');
document.write('<img src=\"/webhare/minfovoor5.gif\" alt=\"Alumni\" border=\"0\" width=\"94\" height=\"15\" name=\"picminfovoor5\"><\/a><\/td><\/tr>');
document.write('<tr>');
document.write('<td height=\"16\">');
document.write('<a ');
document.write('href=\"http://www.utwente.nl/en/entrepreneurs/\" class=\"menuItem\" onMouseOver=\"itemOver(1);     changeImage(\'menuMainInfoVoor\',\'picminfovoor6\',\'imgminfovoor6_o\');\" onMouseOut=\"itemOutTimer(1); changeImage(\'menuMainInfoVoor\',\'picminfovoor6\',\'imgminfovoor6\');\">');
document.write('<img src=\"/webhare/minfovoor6.gif\" alt=\"Entrepreneurs\" border=\"0\" width=\"94\" height=\"16\" name=\"picminfovoor6\"><\/a><\/td><\/tr>');
document.write('<\/table>');
document.write('<\/div>');
document.write('<div id=\"menuMainInfoOver\">');
document.write('<table width=\"94\" border=\"0\" cellspacing=\"0\" cellpadding=\"0\">\n');
document.write('<tr>');
document.write('<td height=\"16\">');
document.write('<a ');
document.write('href=\"http://www.utwente.nl/en/education/\" class=\"menuItem\" onMouseOver=\"itemOver(1);     changeImage(\'menuMainInfoOver\',\'picminfoover0\',\'imgminfoover0_o\');\" onMouseOut=\"itemOutTimer(1); changeImage(\'menuMainInfoOver\',\'picminfoover0\',\'imgminfoover0\');\">');
document.write('<img src=\"/webhare/minfoover0.gif\" alt=\"Education\" border=\"0\" width=\"94\" height=\"16\" name=\"picminfoover0\"><\/a><\/td><\/tr>');
document.write('<tr>');
document.write('<td height=\"15\">');
document.write('<a ');
document.write('href=\"http://www.utwente.nl/en/research/\" class=\"menuItem\" onMouseOver=\"itemOver(1);     changeImage(\'menuMainInfoOver\',\'picminfoover1\',\'imgminfoover1_o\');\" onMouseOut=\"itemOutTimer(1); changeImage(\'menuMainInfoOver\',\'picminfoover1\',\'imgminfoover1\');\">');
document.write('<img src=\"/webhare/minfoover1.gif\" alt=\"Research\" border=\"0\" width=\"94\" height=\"15\" name=\"picminfoover1\"><\/a><\/td><\/tr>');
document.write('<tr>');
document.write('<td height=\"15\">');
document.write('<a ');
document.write('href=\"http://www.utwente.nl/en/faculties/\" class=\"menuItem\" onMouseOver=\"itemOver(1);     changeImage(\'menuMainInfoOver\',\'picminfoover2\',\'imgminfoover2_o\');\" onMouseOut=\"itemOutTimer(1); changeImage(\'menuMainInfoOver\',\'picminfoover2\',\'imgminfoover2\');\">');
document.write('<img src=\"/webhare/minfoover2.gif\" alt=\"Faculties\" border=\"0\" width=\"94\" height=\"15\" name=\"picminfoover2\"><\/a><\/td><\/tr>');
document.write('<tr>');
document.write('<td height=\"15\">');
document.write('<a ');
document.write('href=\"http://www.utwente.nl/en/institutes/\" class=\"menuItem\" onMouseOver=\"itemOver(1);     changeImage(\'menuMainInfoOver\',\'picminfoover3\',\'imgminfoover3_o\');\" onMouseOut=\"itemOutTimer(1); changeImage(\'menuMainInfoOver\',\'picminfoover3\',\'imgminfoover3\');\">');
document.write('<img src=\"/webhare/minfoover3.gif\" alt=\"Institutes\" border=\"0\" width=\"94\" height=\"15\" name=\"picminfoover3\"><\/a><\/td><\/tr>');
document.write('<tr>');
document.write('<td height=\"15\">');
document.write('<a ');
document.write('href=\"http://www.utwente.nl/en/service/\" class=\"menuItem\" onMouseOver=\"itemOver(1);     changeImage(\'menuMainInfoOver\',\'picminfoover4\',\'imgminfoover4_o\');\" onMouseOut=\"itemOutTimer(1); changeImage(\'menuMainInfoOver\',\'picminfoover4\',\'imgminfoover4\');\">');
document.write('<img src=\"/webhare/minfoover4.gif\" alt=\"Service\" border=\"0\" width=\"94\" height=\"15\" name=\"picminfoover4\"><\/a><\/td><\/tr>');
document.write('<tr>');
document.write('<td height=\"16\">');
document.write('<a ');
document.write('href=\"http://www.utwente.nl/en/board/\" class=\"menuItem\" onMouseOver=\"itemOver(1);     changeImage(\'menuMainInfoOver\',\'picminfoover5\',\'imgminfoover5_o\');\" onMouseOut=\"itemOutTimer(1); changeImage(\'menuMainInfoOver\',\'picminfoover5\',\'imgminfoover5\');\">');
document.write('<img src=\"/webhare/minfoover5.gif\" alt=\"Board\" border=\"0\" width=\"94\" height=\"16\" name=\"picminfoover5\"><\/a><\/td><\/tr>');
document.write('<\/table>');
document.write('<\/div>');
document.write('<div id=\"menuMainNieuws\">');
document.write('<table width=\"94\" border=\"0\" cellspacing=\"0\" cellpadding=\"0\">\n');
document.write('<tr>');
document.write('<td height=\"16\">');
document.write('<a ');
document.write('href=\"http://www.utwente.nl/nieuws/pers/en/\" class=\"menuItem\" onMouseOver=\"itemOver(1);     changeImage(\'menuMainNieuws\',\'picmnieuws0\',\'imgmnieuws0_o\');\" onMouseOut=\"itemOutTimer(1); changeImage(\'menuMainNieuws\',\'picmnieuws0\',\'imgmnieuws0\');\">');
document.write('<img src=\"/webhare/mnieuws0.gif\" alt=\"Press releases\" border=\"0\" width=\"94\" height=\"16\" name=\"picmnieuws0\"><\/a><\/td><\/tr>');
document.write('<tr>');
document.write('<td height=\"16\">');
document.write('<a ');
document.write('href=\"http://www.utnws.utwente.nl/utnieuws/laatste/inhoud.html#English\" class=\"menuItem\" onMouseOver=\"itemOver(1);     changeImage(\'menuMainNieuws\',\'picmnieuws1\',\'imgmnieuws1_o\');\" onMouseOut=\"itemOutTimer(1); changeImage(\'menuMainNieuws\',\'picmnieuws1\',\'imgmnieuws1\');\">');
document.write('<img src=\"/webhare/mnieuws1.gif\" alt=\"Newspaper\" border=\"0\" width=\"94\" height=\"16\" name=\"picmnieuws1\"><\/a><\/td><\/tr>');
document.write('<\/table>');
document.write('<\/div>');
document.write('<div id=\"menuMainVacatures\">');
document.write('<\/div>');
document.write('<div id=\"sideNav\">');
document.write('<table width=\"20\" align=\"left\" border=\"0\" cellspacing=\"0\" cellpadding=\"0\">');

  if (atcampus_type==0) //homepage
  {document.write('<tr><td width=\"20\" colspan=\"3\">');
document.write('<img alt=\"\" src=\"/webhare/atcampus.gif\" width=\"159\" height=\"36\" border=\"0\" name=\"imgBtn0\"><\/td>');
document.write('<\/tr>');
document.write('<tr>');
document.write('<td bgcolor=\"#000000\" width=\"1\"><img alt=\"\" src=\"/webhare//spacer.gif\" width=\"1\" height=\"1\" border=\"0\"><\/td>');
document.write('<td colspan=\"2\" bgcolor=\"#FFFFFF\" align=\"center\" width=\"159\">');
document.write('<img alt=\"\" src=\"/webhare//spacer.gif\" width=\"159\" height=\"9\" border=\"0\" name=\"iconDesc\">');
document.write('<\/td>');
document.write('<\/tr>');
document.write('<tr>');
document.write('<td colspan=\"3\" bgcolor=\"#000000\"><img alt=\"\" src=\"/webhare//spacer.gif\" width=\"159\" height=\"1\" border=\"0\"><\/td>');
document.write('<\/tr>');
document.write('<tr>');
document.write('<td bgcolor=\"#000000\" width=\"1\"><img alt=\"\" src=\"/webhare//spacer.gif\" width=\"1\" height=\"1\" border=\"0\"><\/td>');
document.write('<td bgcolor=\"#EBEBEB\" width=\"157\" align=\"center\" valign=\"middle\" nowrap colspan=\"3\">');
document.write('  <table cellpadding=\"0\" cellspacing=\"0\" border=\"0\">');
document.write('    <tr>');
document.write('<td width=\"24\" valign=\"bottom\" height=\"14\">');
document.write('<a ');
document.write('href=\"news.rss\" onMouseOver=\"changeImage(\'sideNav\',\'iconDesc\',\'imgNavrss_Over\');\" onMouseOut=\"changeImage(\'sideNav\',\'iconDesc\',\'imgNavEmpty\');\">');
document.write('<img alt=\"\" src=\"/webhare//spacer.gif\" width=\"5\" height=\"14\" border=\"0\">');
document.write('<img alt=\"RSS\" src=\"/webhare/rss.gif\" width=\"14\" height=\"14\" border=\"0\">');
document.write('<img alt=\"\" src=\"/webhare//spacer.gif\" width=\"5\" height=\"14\" border=\"0\">');
document.write('<\/a><\/td>\n');
document.write('<td width=\"24\" valign=\"bottom\" height=\"14\">');
document.write('<a ');
document.write('lang=\"nl\" ');
document.write('href=\"http://www.utwente.nl/\" onMouseOver=\"changeImage(\'sideNav\',\'iconDesc\',\'imgNavnl_Over\');\" onMouseOut=\"changeImage(\'sideNav\',\'iconDesc\',\'imgNavEmpty\');\">');
document.write('<img alt=\"\" src=\"/webhare//spacer.gif\" width=\"5\" height=\"14\" border=\"0\">');
document.write('<img alt=\"Dutch\" src=\"/webhare/nl.gif\" width=\"14\" height=\"14\" border=\"0\">');
document.write('<img alt=\"\" src=\"/webhare//spacer.gif\" width=\"5\" height=\"14\" border=\"0\">');
document.write('<\/a><\/td>\n');
document.write('<td width=\"24\" valign=\"bottom\" height=\"14\">');
document.write('<a ');
document.write('lang=\"nl\" ');
document.write('href=\"http://www.wb.utwente.nl/explore/\" onMouseOver=\"changeImage(\'sideNav\',\'iconDesc\',\'imgNavsearch_Over\');\" onMouseOut=\"changeImage(\'sideNav\',\'iconDesc\',\'imgNavEmpty\');\">');
document.write('<img alt=\"\" src=\"/webhare//spacer.gif\" width=\"5\" height=\"14\" border=\"0\">');
document.write('<img alt=\"Search\" src=\"/webhare/search.gif\" width=\"14\" height=\"14\" border=\"0\">');
document.write('<img alt=\"\" src=\"/webhare//spacer.gif\" width=\"5\" height=\"14\" border=\"0\">');
document.write('<\/a><\/td>\n');
document.write('<td width=\"24\" valign=\"bottom\" height=\"14\">');
document.write('<a ');
document.write('href=\"http://www.utwente.nl/en/contact/\" onMouseOver=\"changeImage(\'sideNav\',\'iconDesc\',\'imgNavcontact_Over\');\" onMouseOut=\"changeImage(\'sideNav\',\'iconDesc\',\'imgNavEmpty\');\">');
document.write('<img alt=\"\" src=\"/webhare//spacer.gif\" width=\"5\" height=\"14\" border=\"0\">');
document.write('<img alt=\"Contact\" src=\"/webhare/contact.gif\" width=\"14\" height=\"14\" border=\"0\">');
document.write('<img alt=\"\" src=\"/webhare//spacer.gif\" width=\"5\" height=\"14\" border=\"0\">');
document.write('<\/a><\/td>\n');
document.write('    <\/tr>');
document.write('  <\/table>');
document.write('<\/td>');
document.write('<\/tr>');
document.write('<tr>');
document.write('<td bgcolor=\"#FFFFFF\"><img alt=\"\" src=\"/webhare//spacer.gif\" width=\"1\" height=\"1\" border=\"0\"><\/td>');
document.write('<td bgcolor=\"#000000\"><img alt=\"\" src=\"/webhare//spacer.gif\" width=\"1\" height=\"1\" border=\"0\"><\/td>');
document.write('<td bgcolor=\"#EBEBEB\"><img alt=\"\" src=\"/webhare//spacer.gif\" width=\"157\" height=\"1\" border=\"0\"><\/td>');
document.write('<\/tr>');
document.write('<tr>');
document.write('<td bgcolor=\"#FFFFFF\" colspan=\"2\"><img alt=\"\" src=\"/webhare//spacer.gif\" width=\"2\" height=\"1\" border=\"0\"><\/td>');
document.write('<td bgcolor=\"#000000\"><img alt=\"\" src=\"/webhare//spacer.gif\" width=\"157\" height=\"1\" border=\"0\"><\/td>');
document.write('<\/tr>');
}
  else
  {document.write('<tr><td width=\"20\" colspan=\"3\">');
document.write('<a href=\"#\" onMouseOver=\"Javascript: showMenu(0,0);\" onMouseOut=\"Javascript:  menuOutTimer(0,0);\"><img alt=\"\" src=\"/webhare/atcampus_anim.gif\" width=\"20\" height=\"127\" border=\"0\" name=\"imgBtn0\"><\/a><\/td>');
document.write('<\/tr>');
}
document.write('<\/table><\/div>');

}

