//<?
/** 
 * RedirectMap
 * 
 * 301 redirect from old link to new 
 *
 * @category    plugin 
 * @version     1.0
 * @license     http://www.gnu.org/copyleft/gpl.html GNU Public License (GPL) 
 * @internal    @properties &chunk=Chunk with redirectMap;text;RedirectMap &urlencode=Function urlencode;list;rawurlencode,urlencode,none;none
 * @internal    @events OnPageNotFound 
 * @internal    @modx_category SEO 
 * @internal    @legacy_names Sape
 * @internal    @installset base
 */

global $modx;

$urlencode_function = null;
if(isset($urlencode)) {
        switch($urlencode) {
                case 'rawurlencode' :
                $urlencode_function = 'rawurlencode';
                break;
                case 'urlencode'
                $urlencode_function = 'urlencode'; 
                break;
                default:
                $urlencode_function = null;
        }
}

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
        if(!empty($urlencode_function)) {
                implode('/', array_map(function ($v) { return $urlencode_function($v); }, explode('/', $url)));                    
        }
        $modx->sendRedirect($url,0,'REDIRECT_HEADER','HTTP/1.1 301 Moved Permanently');
        exit();
}

