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
 * Validator class for encapsulating entity validation methods.
 *
 * This is the base validation class for track entities.
 */
class MUSound_Entity_Validator_Base_Track extends MUSound_Validator
{
    /**
     * Performs all validation rules.
     *
     * @return mixed either array with error information or true on success
     */
    public function validateAll()
    {
        $errorInfo = array('message' => '', 'code' => 0, 'debugArray' => array());
        $dom = ZLanguage::getModuleDomain('MUSound');
        if (!$this->isStringNotEmpty('workflowState')) {
            $errorInfo['message'] = __f('Error! Field value must not be empty (%s).', array('workflow state'), $dom);
            return $errorInfo;
        }
        if (!$this->isStringNotLongerThan('title', 255)) {
            $errorInfo['message'] = __f('Error! Length of field value must not be higher than %2$s (%1$s).', array('title', 255), $dom);
            return $errorInfo;
        }
        if (!$this->isStringNotEmpty('title')) {
            $errorInfo['message'] = __f('Error! Field value must not be empty (%s).', array('title'), $dom);
            return $errorInfo;
        }
        if (!$this->isStringNotLongerThan('description', 2000)) {
            $errorInfo['message'] = __f('Error! Length of field value must not be higher than %2$s (%1$s).', array('description', 2000), $dom);
            return $errorInfo;
        }
        if (!$this->isStringNotLongerThan('author', 255)) {
            $errorInfo['message'] = __f('Error! Length of field value must not be higher than %2$s (%1$s).', array('author', 255), $dom);
            return $errorInfo;
        }
        if (!$this->isStringNotLongerThan('uploadTrack', 255)) {
            $errorInfo['message'] = __f('Error! Length of field value must not be higher than %2$s (%1$s).', array('upload track', 255), $dom);
            return $errorInfo;
        }
        if (!$this->isStringNotLongerThan('uploadZip', 255)) {
            $errorInfo['message'] = __f('Error! Length of field value must not be higher than %2$s (%1$s).', array('upload zip', 255), $dom);
            return $errorInfo;
        }
    
        return true;
    }
    
    /**
     * Check for unique values.
     *
     * This method determines if there already exist tracks with the same track.
     *
     * @param string $fieldName The name of the property to be checked
     * @return boolean result of this check, true if the given track does not already exist
     */
    public function isUniqueValue($fieldName)
    {
        if ($this->entity[$fieldName] === '') {
            return false;
        }
    
        $entityClass = 'MUSound_Entity_Track';
        $serviceManager = ServiceUtil::getManager();
        $entityManager = $serviceManager->getService('doctrine.entitymanager');
        $repository = $entityManager->getRepository($entityClass);
    
        $excludeid = $this->entity['id'];
    
        return $repository->detectUniqueState($fieldName, $this->entity[$fieldName], $excludeid);
    }
    
    /**
     * Get entity.
     *
     * @return Zikula_EntityAccess
     */
    public function getEntity()
    {
        return $this->entity;
    }
    
    /**
     * Set entity.
     *
     * @param Zikula_EntityAccess $entity.
     *
     * @return void
     */
    public function setEntity(Zikula_EntityAccess $entity = null)
    {
        $this->entity = $entity;
    }
    
}
