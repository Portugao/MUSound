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
 * @version Generated by ModuleStudio (http://modulestudio.de).
 */

/**
 * Ajax controller class.
 */
abstract class MUSound_Controller_Base_AbstractAjax extends Zikula_Controller_AbstractAjax
{


    /**
     * This is the default action handling the main area called without defining arguments.
     *
     *
     * @return mixed Output
     */
    public function main()
    {
        // parameter specifying which type of objects we are treating
        $objectType = $this->request->query->filter('ot', 'collection', FILTER_SANITIZE_STRING);
        
        $permLevel = ACCESS_OVERVIEW;
        $this->throwForbiddenUnless(SecurityUtil::checkPermission($this->name . '::', '::', $permLevel), LogUtil::getErrorMsgPermission());
    }

    
    /**
     * Retrieve item list for finder selections in Forms, Content type plugin and Scribite.
     *
     * @param string $ot      Name of currently used object type
     * @param string $sort    Sorting field
     * @param string $sortdir Sorting direction
     *
     * @return Zikula_Response_Ajax
     */
    public function getItemListFinder()
    {
        if (!SecurityUtil::checkPermission($this->name . '::Ajax', '::', ACCESS_EDIT)) {
            return true;
        }
        
        $objectType = 'collection';
        if ($this->request->isPost() && $this->request->request->has('ot')) {
            $objectType = $this->request->request->filter('ot', 'collection', FILTER_SANITIZE_STRING);
        } elseif ($this->request->isGet() && $this->request->query->has('ot')) {
            $objectType = $this->request->query->filter('ot', 'collection', FILTER_SANITIZE_STRING);
        }
        $controllerHelper = new MUSound_Util_Controller($this->serviceManager);
        $utilArgs = array('controller' => 'ajax', 'action' => 'getItemListFinder');
        if (!in_array($objectType, $controllerHelper->getObjectTypes('controllerAction', $utilArgs))) {
            $objectType = $controllerHelper->getDefaultObjectType('controllerAction', $utilArgs);
        }
        
        $entityClass = 'MUSound_Entity_' . ucfirst($objectType);
        $repository = $this->entityManager->getRepository($entityClass);
        $repository->setControllerArguments(array());
        $idFields = ModUtil::apiFunc($this->name, 'selection', 'getIdFields', array('ot' => $objectType));
        
        $descriptionField = $repository->getDescriptionFieldName();
        
        $sort = $this->request->request->filter('sort', '', FILTER_SANITIZE_STRING);
        if (empty($sort) || !in_array($sort, $repository->getAllowedSortingFields())) {
            $sort = $repository->getDefaultSortingField();
        }
        
        $sdir = $this->request->request->filter('sortdir', '', FILTER_SANITIZE_STRING);
        $sdir = strtolower($sdir);
        if ($sdir != 'asc' && $sdir != 'desc') {
            $sdir = 'asc';
        }
        
        $where = ''; // filters are processed inside the repository class
        $sortParam = $sort . ' ' . $sdir;
        
        $entities = $repository->selectWhere($where, $sortParam);
        
        $slimItems = array();
        $component = $this->name . ':' . ucfirst($objectType) . ':';
        foreach ($entities as $item) {
            $itemId = '';
            foreach ($idFields as $idField) {
                $itemId .= ((!empty($itemId)) ? '_' : '') . $item[$idField];
            }
            if (!SecurityUtil::checkPermission($component, $itemId . '::', ACCESS_READ)) {
                continue;
            }
            $slimItems[] = $this->prepareSlimItem($objectType, $item, $itemId, $descriptionField);
        }
        
        return new Zikula_Response_Ajax($slimItems);
    }
    
    /**
     * Builds and returns a slim data array from a given entity.
     *
     * @param string $objectType       The currently treated object type
     * @param object $item             The currently treated entity
     * @param string $itemid           Data item identifier(s)
     * @param string $descriptionField Name of item description field
     *
     * @return array The slim data representation
     */
    protected function prepareSlimItem($objectType, $item, $itemId, $descriptionField)
    {
        $view = Zikula_View::getInstance('MUSound', false);
        $view->assign($objectType, $item);
        $previewInfo = base64_encode($view->fetch('external/' . $objectType . '/info.tpl'));
    
        $title = $item->getTitleFromDisplayPattern();
        $description = ($descriptionField != '') ? $item[$descriptionField] : '';
    
        return array(
            'id'          => $itemId,
            'title'       => str_replace('&amp;', '&', $title),
            'description' => $description,
            'previewInfo' => $previewInfo
        );
    }
    
    /**
     * Searches for entities for auto completion usage.
     *
     * @param string $ot       Treated object type
     * @param string $fragment The fragment of the entered item name
     * @param string $exclude  Comma separated list with ids of other items (to be excluded from search)
     *
     * @return Zikula_Response_Ajax_Plain
     */
    public function getItemListAutoCompletion()
    {
        if (!SecurityUtil::checkPermission($this->name . '::Ajax', '::', ACCESS_EDIT)) {
            return true;
        }
        
        $objectType = 'collection';
        if ($this->request->isPost() && $this->request->request->has('ot')) {
            $objectType = $this->request->request->filter('ot', 'collection', FILTER_SANITIZE_STRING);
        } elseif ($this->request->isGet() && $this->request->query->has('ot')) {
            $objectType = $this->request->query->filter('ot', 'collection', FILTER_SANITIZE_STRING);
        }
        $controllerHelper = new MUSound_Util_Controller($this->serviceManager);
        $utilArgs = array('controller' => 'ajax', 'action' => 'getItemListAutoCompletion');
        if (!in_array($objectType, $controllerHelper->getObjectTypes('controllerAction', $utilArgs))) {
            $objectType = $controllerHelper->getDefaultObjectType('controllerAction', $utilArgs);
        }
        
        $entityClass = 'MUSound_Entity_' . ucfirst($objectType);
        $repository = $this->entityManager->getRepository($entityClass);
        $idFields = ModUtil::apiFunc($this->name, 'selection', 'getIdFields', array('ot' => $objectType));
        
        $fragment = '';
        $exclude = '';
        if ($this->request->isPost() && $this->request->request->has('fragment')) {
            $fragment = $this->request->request->get('fragment', '');
            $exclude = $this->request->request->get('exclude', '');
        } elseif ($this->request->isGet() && $this->request->query->has('fragment')) {
            $fragment = $this->request->query->get('fragment', '');
            $exclude = $this->request->query->get('exclude', '');
        }
        $exclude = !empty($exclude) ? explode(',', $exclude) : array();
        
        // parameter for used sorting field
        $sort = $this->request->query->get('sort', '');
        if (empty($sort) || !in_array($sort, $repository->getAllowedSortingFields())) {
            $sort = $repository->getDefaultSortingField();
        }
        $sortParam = $sort . ' asc';
        
        $currentPage = 1;
        $resultsPerPage = 20;
        
        // get objects from database
        list($entities, $objectCount) = $repository->selectSearch($fragment, $exclude, $sortParam, $currentPage, $resultsPerPage);
        
        $out = '<ul>';
        if ((is_array($entities) || is_object($entities)) && count($entities) > 0) {
            $descriptionFieldName = $repository->getDescriptionFieldName();
            $previewFieldName = $repository->getPreviewFieldName();
            
            //$imageHelper = new MUSound_Util_Image($this->serviceManager);
            //$imagineManager = $imageHelper->getManager($objectType, $previewFieldName, 'controllerAction', $utilArgs);
            $imagineManager = ServiceUtil::getManager()->getService('systemplugin.imagine.manager');
            foreach ($entities as $item) {
                // class="informal" --> show in dropdown, but do nots copy in the input field after selection
                $itemTitle = $item->getTitleFromDisplayPattern();
                $itemTitleStripped = str_replace('"', '', $itemTitle);
                $itemDescription = isset($item[$descriptionFieldName]) && !empty($item[$descriptionFieldName]) ? $item[$descriptionFieldName] : '';//$this->__('No description yet.');
                $itemId = $item->createCompositeIdentifier();
        
                $out .= '<li id="' . $itemId . '" title="' . $itemTitleStripped . '">';
                $out .= '<div class="itemtitle">' . $itemTitle . '</div>';
                if (!empty($itemDescription)) {
                    $out .= '<div class="itemdesc informal">' . substr($itemDescription, 0, 50) . '&hellip;</div>';
                }
        
                // check for preview image
                if (!empty($previewFieldName) && !empty($item[$previewFieldName]) && isset($item[$previewFieldName . 'FullPath'])) {
                    $fullObjectId = $objectType . '-' . $itemId;
                    $thumbImagePath = $imagineManager->getThumb($item[$previewFieldName], $fullObjectId);
                    $preview = '<img src="' . $thumbImagePath . '" width="50" height="50" alt="' . $itemTitleStripped . '" />';
                    $out .= '<div id="itemPreview' . $itemId . '" class="itempreview informal">' . $preview . '</div>';
                }
        
                $out .= '</li>';
            }
        }
        $out .= '</ul>';
        
        // return response
        return new Zikula_Response_Ajax_Plain($out);
    }
}
