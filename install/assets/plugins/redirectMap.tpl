&chunk=Чанк с картой редиректов;text;КартаРедиректов
opnagenotfound

global $modx;

$mapChunk = $modx->getChunk($chunk);

$mapLines = explode("\r\n",$mapChunk);

$mapArr = array();

foreach($mapLines as $line) {
        list($link,$redirectId) = explode('||',$line);
        $mapArr[$link] = $redirectId;
}

$q = $_REQUEST['q'];

if(isset($mapArr[$q])) {
        $url = $modx->makeUrl($mapArr[$q]);
        $modx->sendRedirect($url,0,'REDIRECT_HEADER','HTTP/1.1 301 Moved Permanently');
        exit();
}

