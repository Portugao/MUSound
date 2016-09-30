<?php
/**
 * MUSound.
 *
 * @copyright Michael Ueberschaer (MU)
 * @license http://www.gnu.org/licenses/lgpl.html GNU Lesser General Public License
 * @package MUSound
 * @author Michael Ueberschaer <kontakt@webdesign-in-bremen.com>.
 * @link http://webdesign-in-bremen.com
 * @link http://zikula.org
 * @version Generated by ModuleStudio 0.7.0 (http://modulestudio.de).
 */

/**
 * Event handler implementation class for dispatching modules.
 */
class MUSound_Listener_ModuleDispatch extends MUSound_Listener_Base_AbstractModuleDispatch
{
    /**
     * {@inheritdoc}
     */
    public static function postLoadGeneric(Zikula_Event $event)
    {
        parent::postLoadGeneric($event);
    
        // you can access general data available in the event
        
        // the event name
        // echo 'Event: ' . $event->getName();
        
        // type of current request: MASTER_REQUEST or SUB_REQUEST
        // if a listener should only be active for the master request,
        // be sure to check that at the beginning of your method
        // if ($event->getRequestType() !== HttpKernelInterface::MASTER_REQUEST) {
        //     // don't do anything if it's not the master request
        //     return;
        // }
        
        // kernel instance handling the current request
        // $kernel = $event->getKernel();
        
        // the currently handled request
        // $request = $event->getRequest();
    }
    
    /**
     * {@inheritdoc}
     */
    public static function preExecute(Zikula_Event $event)
    {
        parent::preExecute($event);
    
        // you can access general data available in the event
        
        // the event name
        // echo 'Event: ' . $event->getName();
        
        // type of current request: MASTER_REQUEST or SUB_REQUEST
        // if a listener should only be active for the master request,
        // be sure to check that at the beginning of your method
        // if ($event->getRequestType() !== HttpKernelInterface::MASTER_REQUEST) {
        //     // don't do anything if it's not the master request
        //     return;
        // }
        
        // kernel instance handling the current request
        // $kernel = $event->getKernel();
        
        // the currently handled request
        // $request = $event->getRequest();
    }
    
    /**
     * {@inheritdoc}
     */
    public static function postExecute(Zikula_Event $event)
    {
        parent::postExecute($event);
    
            parent::postExecute($event);
    
        // you can access general data available in the event
        
        // the event name
        // echo 'Event: ' . $event->getName();
        
        // type of current request: MASTER_REQUEST or SUB_REQUEST
        // if a listener should only be active for the master request,
        // be sure to check that at the beginning of your method
        // if ($event->getRequestType() !== HttpKernelInterface::MASTER_REQUEST) {
        //     // don't do anything if it's not the master request
        //     return;
        // }
        
        // kernel instance handling the current request
        // $kernel = $event->getKernel();
        
        // the currently handled request
        // $request = $event->getRequest();
        
        $isAvailable = ModUtil::available('MUSound');
        
        $modargs = $event->getArgs();
        
        if (in_array($modargs['modname'], array('Blocks', 'Admin', 'MUSound'))) {
        	// nothing to do for module blocks, admin and musound
        	return;
        }
        
        if ($modargs['type'] == 'admin') {
        	// admin call, thus nothing to do
        	return;
        }
        
        // check if MUSound is activated for any modules
        $modules = MUSound_Api_User::checkModules();
        if (!is_array($modules) || count($modules) < 1) {
        	// no active modules, thus nothing to do
        	return;
        }
        
        // we are not interested in api functions
        if ($modargs['api'] == 1) {
        	return;
        }
        
        $controllers = array('display');
        
        if($modargs['modname'] == 'Content' || $modargs['modname'] == 'News') {
        	$controllers[] = 'view';
        }
        
        if ($modargs['modname'] == 'Content') {
        	$controllers[] = 'pagelist';
        }
        if ($modargs['modname'] == 'Clip') {
        	$controllers[] = 'list';
        }
        
        if (!in_array($modargs['modfunc'][1], $controllers)) {
        	// unallowed controller, thus nothing to do
        	return;
        }
        
        
        $request = new Zikula_Request_Http();
        $module = $request->query->filter('module', 'MUSound', FILTER_SANITIZE_STRING);
        
        if (($modargs['modname'] == $module && in_array($modargs['modname'], $modules) || $module == 'MUSound') && $isAvailable === true) {
        
        	/*function replacePatternMUSound($treffer)
        	{
        		$albumId = $treffer[2];
        		$albumrepository = MUSound_Util_Model::getAlbumRepository();
        		$album = $albumrepository->selectById($albumId);
        		if (is_object($album)) {


        				return "<div id='wrapper2'></div>
  
<script type='text/javascript'>
/* <![CDATA[ */
    /*var MU = jQuery.noConflict();
    jQuery(document).ready(function(){

    var myPlaylist = [
    {{foreach name=albumtracks item=track from=$album.tracks}}
        {
            oga:'',
            mp3:'{{$track->uploadTrackFullPathUrl}}',
            title:'{{$track->title}}',
            artist:'{{if $track->author ne ''}}{{$track->author}}{{else}}{{$track->album->author}}{{/if}}',
            cover:'{{if $track->album->uploadCoverFullPathUrl}}{{$track->album->uploadCoverFullPathUrl}}{{else}}/modules/MUSound/images/NoCover.jpg{{/if}}'
        }{{if $smarty.foreach.albumtracks.last ne true}},{{/if}}
    {{/foreach}}
    ];
            var description = '{{$track->album->description}}';

            MU('#wrapper2').ttwMusicPlayer(myPlaylist, {
                autoPlay:false, 
                description:description,
                jPlayer:{
                    swfPath:'/modules/MUSound/lib/vendor/musicplayer/jquery-jplayer/' //You need to override the default swf path any time the directory structure changes
                }
            });
      

    
    });
/* ]]> */
//</script>";
        	/*} else {
        				return '';
        			}
        	}*/
        	$data = $event->getData();
        
        	$pattern = '(MUSOUNDALBUM)\[([0-9]*)\]';
        	$newData = preg_replace_callback("/$pattern/",         	function ($treffer)
        	{
        		$albumId = $treffer[2];
        		$albumrepository = MUSound_Util_Model::getAlbumRepository();
        		$album = $albumrepository->selectById($albumId);
        		if (is_object($album)) {


        				return "<div id='wrapper2'></div>
  
<script type='text/javascript'>
/* <![CDATA[ */
    var MU = jQuery.noConflict();
    jQuery(document).ready(function(){

    var myPlaylist = [
    {{foreach name=albumtracks item=track from=$album.tracks}}
        {
            oga:'',
            mp3:'{{$track->uploadTrackFullPathUrl}}',
            title:'{{$track->title}}',
            artist:'{{if $track->author ne ''}}{{$track->author}}{{else}}{{$track->album->author}}{{/if}}',
            cover:'{{if $track->album->uploadCoverFullPathUrl}}{{$track->album->uploadCoverFullPathUrl}}{{else}}/modules/MUSound/images/NoCover.jpg{{/if}}'
        }{{if $smarty.foreach.albumtracks.last ne true}},{{/if}}
    {{/foreach}}
    ];
            var description = '{{$track->album->description}}';

            MU('#wrapper2').ttwMusicPlayer(myPlaylist, {
                autoPlay:false, 
                description:description,
                jPlayer:{
                    swfPath:'/modules/MUSound/lib/vendor/musicplayer/jquery-jplayer/' //You need to override the default swf path any time the directory structure changes
                }
            });
      

    
    });
/* ]]> */
</script>";
        	} else {
        				return '';
        			}
        	}, $data);
        	$event->setData($newData);
        		
        } else {
        	// nothing to do
        }
    }
    
    /**
     * {@inheritdoc}
     */
    public static function customClassname(Zikula_Event $event)
    {
        parent::customClassName($event);
    
        // you can access general data available in the event
        
        // the event name
        // echo 'Event: ' . $event->getName();
        
        // type of current request: MASTER_REQUEST or SUB_REQUEST
        // if a listener should only be active for the master request,
        // be sure to check that at the beginning of your method
        // if ($event->getRequestType() !== HttpKernelInterface::MASTER_REQUEST) {
        //     // don't do anything if it's not the master request
        //     return;
        // }
        
        // kernel instance handling the current request
        // $kernel = $event->getKernel();
        
        // the currently handled request
        // $request = $event->getRequest();
    }
    
    /**
     * {@inheritdoc}
     */
    public static function serviceLinks(Zikula_Event $event)
    {
        parent::customClassName($event);
    
        // Format data like so:
        // $dom = ZLanguage::getModuleDomain('MUSound');
        // $event->data[] = array('url' => ModUtil::url('MUSound', 'user', 'main'), 'text' => __('Link text', $dom));
    
        // you can access general data available in the event
        
        // the event name
        // echo 'Event: ' . $event->getName();
        
        // type of current request: MASTER_REQUEST or SUB_REQUEST
        // if a listener should only be active for the master request,
        // be sure to check that at the beginning of your method
        // if ($event->getRequestType() !== HttpKernelInterface::MASTER_REQUEST) {
        //     // don't do anything if it's not the master request
        //     return;
        // }
        
        // kernel instance handling the current request
        // $kernel = $event->getKernel();
        
        // the currently handled request
        // $request = $event->getRequest();
    }
}
