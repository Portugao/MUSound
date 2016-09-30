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
 * Moderation block base class.
 */
abstract class MUSound_Block_Base_AbstractModeration extends Zikula_Controller_AbstractBlock
{
    /**
     * Initialise the block.
     */
    public function init()
    {
        //SecurityUtil::registerPermissionSchema('MUSound:ModerationBlock:', 'Block title::');
    }
    
    /**
     * Get information on the block.
     *
     * @return array The block information
     */
    public function info()
    {
        $requirementMessage = '';
        // check if the module is available at all
        if (!ModUtil::available('MUSound')) {
            $requirementMessage .= $this->__('Notice: This block will not be displayed until you activate the MUSound module.');
        }
    
        return array(
            'module'          => 'MUSound',
            'text_type'       => $this->__('Moderation'),
            'text_type_long'  => $this->__('Show a list of pending tasks to moderators.'),
            'allow_multiple'  => true,
            'form_content'    => false,
            'form_refresh'    => false,
            'show_preview'    => false,
            'admin_tableless' => true,
            'requirement'     => $requirementMessage
        );
    }
    
    /**
     * Display the block content.
     *
     * @param array $blockinfo the blockinfo structure
     *
     * @return string output of the rendered block
     */
    public function display($blockinfo)
    {
        // only show block content if the user has the required permissions
        if (!SecurityUtil::checkPermission('MUSound:ModerationBlock:', "$blockinfo[title]::", ACCESS_OVERVIEW)) {
            return false;
        }
    
        if (!UserUtil::isLoggedIn()) {
            return false;
        }
    
        // check if the module is available at all
        if (!ModUtil::available('MUSound')) {
            return false;
        }
    
        ModUtil::initOOModule('MUSound');
    
        $this->view->setCaching(Zikula_View::CACHE_DISABLED);
        $template = $this->getDisplayTemplate();
    
        $workflowHelper = new MUSound_Util_Workflow($this->serviceManager);
        $amounts = $workflowHelper->collectAmountOfModerationItems();
    
        // assign block vars and fetched data
        $this->view->assign('moderationObjects', $amounts);
    
        // set a block title
        if (empty($blockinfo['title'])) {
            $blockinfo['title'] = $this->__('Moderation');
        }
    
        $blockinfo['content'] = $this->view->fetch($template);
    
        // return the block to the theme
        return BlockUtil::themeBlock($blockinfo);
    }
    
    /**
     * Returns the template used for output.
     *
     * @return string the template path
     */
    protected function getDisplayTemplate()
    {
        $template = 'block/moderation.tpl';
    
        return $template;
    }
}