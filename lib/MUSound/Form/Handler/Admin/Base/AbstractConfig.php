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
 * Configuration handler base class.
 */
abstract class MUSound_Form_Handler_Admin_Base_AbstractConfig extends Zikula_Form_AbstractHandler
{
    /**
     * Post construction hook.
     *
     * @return mixed
     */
    public function setup()
    {
    }

    /**
     * Initialize form handler.
     *
     * This method takes care of all necessary initialisation of our data and form states.
     *
     * @param Zikula_Form_View $view The form view instance
     *
     * @return boolean False in case of initialization errors, otherwise true
     */
    public function initialize(Zikula_Form_View $view)
    {
        // permission check
        if (!SecurityUtil::checkPermission($this->name . '::', '::', ACCESS_ADMIN)) {
            return $view->registerError(LogUtil::registerPermissionError());
        }

        // prepare list of user groups for moderation group selectors
        $userGroups = ModUtil::apiFunc('Groups', 'user', 'getall');
        $userGroupItems = array();
        foreach ($userGroups as $userGroup) {
            $userGroupItems[] = array(
                'value' => $userGroup['gid'],
                'text' => $userGroup['name']
            );
        }

        // retrieve module vars
        $modVars = $this->getVars();

        $modVars['moderationGroupForAlbumsItems'] = $userGroupItems;

        // assign all module vars
        $this->view->assign('config', $modVars);

        // everything okay, no initialization errors occured
        return true;
    }

    /**
     * Pre-initialise hook.
     *
     * @return void
     */
    public function preInitialize()
    {
    }

    /**
     * Post-initialise hook.
     *
     * @return void
     */
    public function postInitialize()
    {
    }

    /**
     * Command event handler.
     *
     * This event handler is called when a command is issued by the user. Commands are typically something
     * that originates from a {@link Zikula_Form_Plugin_Button} plugin. The passed args contains different properties
     * depending on the command source, but you should at least find a <var>$args['commandName']</var>
     * value indicating the name of the command. The command name is normally specified by the plugin
     * that initiated the command.
     *
     * @param Zikula_Form_View $view The form view instance
     * @param array            $args Additional arguments
     *
     * @see Zikula_Form_Plugin_Button
     * @see Zikula_Form_Plugin_ImageButton
     *
     * @return mixed Redirect or false on errors
     */
    public function handleCommand(Zikula_Form_View $view, &$args)
    {
        if ($args['commandName'] == 'save') {
            // check if all fields are valid
            if (!$this->view->isValid()) {
                return false;
            }

            // retrieve form data
            $data = $this->view->getValues();

            // update all module vars
            try {
                $this->setVars($data['config']);
            } catch (\Exception $e) {
                $msg = $this->__('Error! Failed to set configuration variables.');
                if (System::isDevelopmentMode()) {
                    $msg .= ' ' . $e->getMessage();
                }

                return LogUtil::registerError($msg);
            }

            LogUtil::registerStatus($this->__('Done! Module configuration updated.'));
        } else if ($args['commandName'] == 'cancel') {
            LogUtil::registerStatus($this->__('Operation cancelled.'));
        }

        // redirect back to the config page
        $url = ModUtil::url($this->name, 'admin', 'config');

        return $this->view->redirect($url);
    }
}
