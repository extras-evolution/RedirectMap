//<?
/** 
 * RedirectMap
 * 
 * 301 redirect from old link to new 
 *
 * @category    plugin 
 * @version     1.0
 * @license     http://www.gnu.org/copyleft/gpl.html GNU Public License (GPL) 
 * @internal    @properties &chunk=Chunk with redirectMap;text;RedirectMap
 * @internal    @events OnPageNotFound 
 * @internal    @modx_category SEO 
 * @internal    @legacy_names Sape
 * @internal    @installset base
 */

global $modx;

$mapChunk = $modx->getChunk($chunk);

//$mapLines = explode("\r\n",$mapChunk);
$mapLines = explode(PHP_EOL,$mapChunk);

$mapArr = array();

foreach($mapLines as $line) {
        list($link,$redirectId) = explode('||',$line);
        $mapArr[$link] = $redirectId;
}

$q = $_REQUEST['q'];

if(isset($mapArr[$q])) {
        $url = $modx->makeUrl(trim($mapArr[$q]));
        $modx->sendRedirect($url,0,'REDIRECT_HEADER','HTTP/1.1 301 Moved Permanently');
        exit();
}

