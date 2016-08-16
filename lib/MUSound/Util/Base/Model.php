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
 * Utility base class for model helper methods.
 */
class MUSound_Util_Base_Model extends Zikula_AbstractBase
{
    /**
     * Determines whether creating an instance of a certain object type is possible.
     * This is when
     *     - no tree is used
     *     - it has no incoming bidirectional non-nullable relationships.
     *     - the edit type of all those relationships has PASSIVE_EDIT and auto completion is used on the target side
     *       (then a new source object can be created while creating the target object).
     *     - corresponding source objects exist already in the system.
     *
     * Note that even creation of a certain object is possible, it may still be forbidden for the current user
     * if he does not have the required permission level.
     *
     * @param string $objectType Name of treated entity type
     *
     * @return boolean Whether a new instance can be created or not
     *
     * @throws Exception If an invalid object type is used
     */
    public function canBeCreated($objectType)
    {
        $controllerHelper = new MUSound_Util_Controller($this->serviceManager);
        if (!in_array($objectType, $controllerHelper->getObjectTypes('util', array('util' => 'model', 'action' => 'canBeCreated')))) {
            throw new Exception('Error! Invalid object type received.');
        }
    
        $result = false;
    
        switch ($objectType) {
            case 'album':
                $result = true;
                break;
            case 'track':
                $result = true;
                break;
            case 'collection':
                $result = true;
                break;
        }
    
        return $result;
    }

    /**
     * Determines whether there exist at least one instance of a certain object type in the database.
     *
     * @param string $objectType Name of treated entity type
     *
     * @return boolean Whether at least one instance exists or not
     *
     * @throws Exception If an invalid object type is used
     */
    protected function hasExistingInstances($objectType)
    {
        $controllerHelper = new MUSound_Util_Controller($this->serviceManager);
        if (!in_array($objectType, $controllerHelper->getObjectTypes('util', array('util' => 'model', 'action' => 'hasExistingInstances')))) {
            throw new Exception('Error! Invalid object type received.');
        }
    
        $entityClass = 'MUSound_Entity_' . ucfirst($objectType);
        $repository = $this->entityManager->getRepository($entityClass);
    
        return ($repository->selectCount() > 0);
    }
}
