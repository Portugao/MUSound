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
 * @version Generated by ModuleStudio 0.6.2 (http://modulestudio.de).
 */

/**
 * Account api base class.
 */
class MUSound_Api_Base_Account extends Zikula_AbstractApi
{
    /**
     * Return an array of items to show in the your account panel.
     *
     * @param array $args List of arguments.
     *
     * @return array List of collected account items
     */
    public function getall(array $args = array())
    {
        // collect items in an array
        $items = array();
    
        $useAccountPage = $this->getVar('useAccountPage', true);
        if ($useAccountPage === false) {
            return $items;
        }
    
        $userName = (isset($args['uname'])) ? $args['uname'] : UserUtil::getVar('uname');
        // does this user exist?
        if (UserUtil::getIdFromName($userName) === false) {
            // user does not exist
            return $items;
        }
    
        if (!SecurityUtil::checkPermission($this->name . '::', '::', ACCESS_OVERVIEW)) {
            return $items;
        }
    
    
        // Create an array of links to return
        $objectType = 'album';
        if (SecurityUtil::checkPermission($this->name . ':' . ucfirst($objectType) . ':', '::', ACCESS_READ)) {
            $items[] = array(
                'url' => ModUtil::url($this->name, 'user', 'view', array('ot' => $objectType, 'own' => 1)),
                'title'   => $this->__('My albums'),
                'icon'    => 'windowlist.png',
                'module'  => 'core',
                'set'     => 'icons/large'
            );
        }
        if (SecurityUtil::checkPermission($this->name . '::', '::', ACCESS_ADMIN)) {
            $items[] = array(
                'url'   => ModUtil::url($this->name, 'admin', 'main'),
                'title' => $this->__('M u sound Backend'),
                'icon'   => 'configure.png',
                'module' => 'core',
                'set'    => 'icons/large'
            );
        }
    
        // return the items
        return $items;
    }
}
