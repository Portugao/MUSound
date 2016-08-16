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

use Doctrine\ORM\Mapping as ORM;
use Gedmo\Mapping\Annotation as Gedmo;
use DoctrineExtensions\StandardFields\Mapping\Annotation as ZK;

/**
 * Entity class that defines the entity structure and behaviours.
 *
 * This is the base entity class for track entities.
 * The following annotation marks it as a mapped superclass so subclasses
 * inherit orm properties.
 *
 * @ORM\MappedSuperclass
 *
 * @abstract
 */
abstract class MUSound_Entity_Base_Track extends Zikula_EntityAccess
{
    /**
     * @var string The tablename this object maps to
     */
    protected $_objectType = 'track';
    
    /**
     * @var MUSound_Entity_Validator_Track The validator for this entity
     */
    protected $_validator = null;
    
    /**
     * @var boolean Option to bypass validation if needed
     */
    protected $_bypassValidation = false;
    
    /**
     * @var array List of available item actions
     */
    protected $_actions = array();
    
    /**
     * @var array The current workflow data of this object
     */
    protected $__WORKFLOW__ = array();
    
    /**
     * @ORM\Id
     * @ORM\GeneratedValue(strategy="AUTO")
     * @ORM\Column(type="integer", unique=true)
     * @var integer $id
     */
    protected $id = 0;
    
    /**
     * the current workflow state
     * @ORM\Column(length=20)
     * @var string $workflowState
     */
    protected $workflowState = 'initial';
    
    /**
     * @ORM\Column(length=255)
     * @var string $title
     */
    protected $title = '';
    
    /**
     * @Gedmo\Translatable
     * @ORM\Column(type="text", length=2000)
     * @var text $description
     */
    protected $description = '';
    
    /**
     * @ORM\Column(length=255)
     * @var string $author
     */
    protected $author = '';
    
    /**
     * Upload track meta data array.
     *
     * @ORM\Column(type="array")
     * @var array $uploadTrackMeta
     */
    protected $uploadTrackMeta = array();
    
    /**
     * @ORM\Column(length=255)
     * @var string $uploadTrack
     */
    protected $uploadTrack = '';
    
    /**
     * The full path to the upload track.
     *
     * @var string $uploadTrackFullPath
     */
    protected $uploadTrackFullPath = '';
    
    /**
     * Full upload track path as url.
     *
     * @var string $uploadTrackFullPathUrl
     */
    protected $uploadTrackFullPathUrl = '';
    /**
     * Upload zip meta data array.
     *
     * @ORM\Column(type="array")
     * @var array $uploadZipMeta
     */
    protected $uploadZipMeta = array();
    
    /**
     * @ORM\Column(length=255)
     * @var string $uploadZip
     */
    protected $uploadZip = '';
    
    /**
     * The full path to the upload zip.
     *
     * @var string $uploadZipFullPath
     */
    protected $uploadZipFullPath = '';
    
    /**
     * Full upload zip path as url.
     *
     * @var string $uploadZipFullPathUrl
     */
    protected $uploadZipFullPathUrl = '';
    
    /**
     * Field for storing the locale of this entity.
     * Overrides the locale set in translationListener (as pointed out in https://github.com/l3pp4rd/DoctrineExtensions/issues/130#issuecomment-1790206 ).
     *
     * @Gedmo\Locale
     * @var string $locale
     */
    protected $locale;
    
    /**
     * @ORM\Column(type="integer")
     * @ZK\StandardFields(type="userid", on="create")
     * @var integer $createdUserId
     */
    protected $createdUserId;
    
    /**
     * @ORM\Column(type="integer")
     * @ZK\StandardFields(type="userid", on="update")
     * @var integer $updatedUserId
     */
    protected $updatedUserId;
    
    /**
     * @ORM\Column(type="datetime")
     * @Gedmo\Timestampable(on="create")
     * @var \DateTime $createdDate
     */
    protected $createdDate;
    
    /**
     * @ORM\Column(type="datetime")
     * @Gedmo\Timestampable(on="update")
     * @var \DateTime $updatedDate
     */
    protected $updatedDate;
    
    /**
     * Bidirectional - Many track [tracks] are linked by one album [album] (OWNING SIDE).
     *
     * @ORM\ManyToOne(targetEntity="MUSound_Entity_Album", inversedBy="track")
     * @ORM\JoinTable(name="musound_album")
     * @var \MUSound_Entity_Album $album
     */
    protected $album;
    
    
    /**
     * Constructor.
     * Will not be called by Doctrine and can therefore be used
     * for own implementation purposes. It is also possible to add
     * arbitrary arguments as with every other class method.
     *
     * @param TODO
     */
    public function __construct()
    {
        $this->workflowState = 'initial';
        $this->initValidator();
        $this->initWorkflow();
    }
    
    /**
     * Gets the _object type.
     *
     * @return string
     */
    public function get_objectType()
    {
        return $this->_objectType;
    }
    
    /**
     * Sets the _object type.
     *
     * @param string $_objectType
     *
     * @return void
     */
    public function set_objectType($_objectType)
    {
        $this->_objectType = $_objectType;
    }
    
    /**
     * Gets the _validator.
     *
     * @return MUSound_Entity_Validator_Track
     */
    public function get_validator()
    {
        return $this->_validator;
    }
    
    /**
     * Sets the _validator.
     *
     * @param MUSound_Entity_Validator_Track $_validator
     *
     * @return void
     */
    public function set_validator(MUSound_Entity_Validator_Track $_validator = null)
    {
        $this->_validator = $_validator;
    }
    
    /**
     * Gets the _bypass validation.
     *
     * @return boolean
     */
    public function get_bypassValidation()
    {
        return $this->_bypassValidation;
    }
    
    /**
     * Sets the _bypass validation.
     *
     * @param boolean $_bypassValidation
     *
     * @return void
     */
    public function set_bypassValidation($_bypassValidation)
    {
        $this->_bypassValidation = $_bypassValidation;
    }
    
    /**
     * Gets the _actions.
     *
     * @return array
     */
    public function get_actions()
    {
        return $this->_actions;
    }
    
    /**
     * Sets the _actions.
     *
     * @param array $_actions
     *
     * @return void
     */
    public function set_actions(array $_actions = Array())
    {
        $this->_actions = $_actions;
    }
    
    /**
     * Gets the __ w o r k f l o w__.
     *
     * @return array
     */
    public function get__WORKFLOW__()
    {
        return $this->__WORKFLOW__;
    }
    
    /**
     * Sets the __ w o r k f l o w__.
     *
     * @param array $__WORKFLOW__
     *
     * @return void
     */
    public function set__WORKFLOW__(array $__WORKFLOW__ = Array())
    {
        $this->__WORKFLOW__ = $__WORKFLOW__;
    }
    
    
    /**
     * Gets the id.
     *
     * @return integer
     */
    public function getId()
    {
        return $this->id;
    }
    
    /**
     * Sets the id.
     *
     * @param integer $id
     *
     * @return void
     */
    public function setId($id)
    {
        $this->id = $id;
    }
    
    /**
     * Gets the workflow state.
     *
     * @return string
     */
    public function getWorkflowState()
    {
        return $this->workflowState;
    }
    
    /**
     * Sets the workflow state.
     *
     * @param string $workflowState
     *
     * @return void
     */
    public function setWorkflowState($workflowState)
    {
        $this->workflowState = $workflowState;
    }
    
    /**
     * Gets the title.
     *
     * @return string
     */
    public function getTitle()
    {
        return $this->title;
    }
    
    /**
     * Sets the title.
     *
     * @param string $title
     *
     * @return void
     */
    public function setTitle($title)
    {
        $this->title = $title;
    }
    
    /**
     * Gets the description.
     *
     * @return text
     */
    public function getDescription()
    {
        return $this->description;
    }
    
    /**
     * Sets the description.
     *
     * @param text $description
     *
     * @return void
     */
    public function setDescription($description)
    {
        $this->description = $description;
    }
    
    /**
     * Gets the author.
     *
     * @return string
     */
    public function getAuthor()
    {
        return $this->author;
    }
    
    /**
     * Sets the author.
     *
     * @param string $author
     *
     * @return void
     */
    public function setAuthor($author)
    {
        $this->author = $author;
    }
    
    /**
     * Gets the upload track.
     *
     * @return string
     */
    public function getUploadTrack()
    {
        return $this->uploadTrack;
    }
    
    /**
     * Sets the upload track.
     *
     * @param string $uploadTrack
     *
     * @return void
     */
    public function setUploadTrack($uploadTrack)
    {
        $this->uploadTrack = $uploadTrack;
    }
    
    /**
     * Gets the upload track full path.
     *
     * @return string
     */
    public function getUploadTrackFullPath()
    {
        return $this->uploadTrackFullPath;
    }
    
    /**
     * Sets the upload track full path.
     *
     * @param string $uploadTrackFullPath
     *
     * @return void
     */
    public function setUploadTrackFullPath($uploadTrackFullPath)
    {
        $this->uploadTrackFullPath = $uploadTrackFullPath;
    }
    
    /**
     * Gets the upload track full path url.
     *
     * @return string
     */
    public function getUploadTrackFullPathUrl()
    {
        return $this->uploadTrackFullPathUrl;
    }
    
    /**
     * Sets the upload track full path url.
     *
     * @param string $uploadTrackFullPathUrl
     *
     * @return void
     */
    public function setUploadTrackFullPathUrl($uploadTrackFullPathUrl)
    {
        $this->uploadTrackFullPathUrl = $uploadTrackFullPathUrl;
    }
    
    /**
     * Gets the upload track meta.
     *
     * @return array
     */
    public function getUploadTrackMeta()
    {
        return $this->uploadTrackMeta;
    }
    
    /**
     * Sets the upload track meta.
     *
     * @param array $uploadTrackMeta
     *
     * @return void
     */
    public function setUploadTrackMeta($uploadTrackMeta = Array())
    {
        $this->uploadTrackMeta = $uploadTrackMeta;
    }
    
    /**
     * Gets the upload zip.
     *
     * @return string
     */
    public function getUploadZip()
    {
        return $this->uploadZip;
    }
    
    /**
     * Sets the upload zip.
     *
     * @param string $uploadZip
     *
     * @return void
     */
    public function setUploadZip($uploadZip)
    {
        $this->uploadZip = $uploadZip;
    }
    
    /**
     * Gets the upload zip full path.
     *
     * @return string
     */
    public function getUploadZipFullPath()
    {
        return $this->uploadZipFullPath;
    }
    
    /**
     * Sets the upload zip full path.
     *
     * @param string $uploadZipFullPath
     *
     * @return void
     */
    public function setUploadZipFullPath($uploadZipFullPath)
    {
        $this->uploadZipFullPath = $uploadZipFullPath;
    }
    
    /**
     * Gets the upload zip full path url.
     *
     * @return string
     */
    public function getUploadZipFullPathUrl()
    {
        return $this->uploadZipFullPathUrl;
    }
    
    /**
     * Sets the upload zip full path url.
     *
     * @param string $uploadZipFullPathUrl
     *
     * @return void
     */
    public function setUploadZipFullPathUrl($uploadZipFullPathUrl)
    {
        $this->uploadZipFullPathUrl = $uploadZipFullPathUrl;
    }
    
    /**
     * Gets the upload zip meta.
     *
     * @return array
     */
    public function getUploadZipMeta()
    {
        return $this->uploadZipMeta;
    }
    
    /**
     * Sets the upload zip meta.
     *
     * @param array $uploadZipMeta
     *
     * @return void
     */
    public function setUploadZipMeta($uploadZipMeta = Array())
    {
        $this->uploadZipMeta = $uploadZipMeta;
    }
    
    /**
     * Gets the locale.
     *
     * @return string
     */
    public function getLocale()
    {
        return $this->locale;
    }
    
    /**
     * Sets the locale.
     *
     * @param string $locale
     *
     * @return void
     */
    public function setLocale($locale)
    {
        $this->locale = $locale;
    }
    
    /**
     * Gets the created user id.
     *
     * @return integer
     */
    public function getCreatedUserId()
    {
        return $this->createdUserId;
    }
    
    /**
     * Sets the created user id.
     *
     * @param integer $createdUserId
     *
     * @return void
     */
    public function setCreatedUserId($createdUserId)
    {
        $this->createdUserId = $createdUserId;
    }
    
    /**
     * Gets the updated user id.
     *
     * @return integer
     */
    public function getUpdatedUserId()
    {
        return $this->updatedUserId;
    }
    
    /**
     * Sets the updated user id.
     *
     * @param integer $updatedUserId
     *
     * @return void
     */
    public function setUpdatedUserId($updatedUserId)
    {
        $this->updatedUserId = $updatedUserId;
    }
    
    /**
     * Gets the created date.
     *
     * @return \DateTime
     */
    public function getCreatedDate()
    {
        return $this->createdDate;
    }
    
    /**
     * Sets the created date.
     *
     * @param \DateTime $createdDate
     *
     * @return void
     */
    public function setCreatedDate($createdDate)
    {
        $this->createdDate = $createdDate;
    }
    
    /**
     * Gets the updated date.
     *
     * @return \DateTime
     */
    public function getUpdatedDate()
    {
        return $this->updatedDate;
    }
    
    /**
     * Sets the updated date.
     *
     * @param \DateTime $updatedDate
     *
     * @return void
     */
    public function setUpdatedDate($updatedDate)
    {
        $this->updatedDate = $updatedDate;
    }
    
    
    /**
     * Gets the album.
     *
     * @return MUSound_Entity_Album
     */
    public function getAlbum()
    {
        return $this->album;
    }
    
    /**
     * Sets the album.
     *
     * @param MUSound_Entity_Album $album
     *
     * @return void
     */
    public function setAlbum(MUSound_Entity_Album $album = null)
    {
        $this->album = $album;
    }
    
    
    protected $processedLoadCallback = false;
    
    /**
     * Post-Process the data after the entity has been constructed by the entity manager.
     * The event happens after the entity has been loaded from database or after a refresh call.
     *
     * Restrictions:
     *     - no access to entity manager or unit of work apis
     *     - no access to associations (not initialised yet)
     *
     * @see MUSound_Entity_Track::postLoadCallback()
     * @return boolean true if completed successfully else false
     */
    protected function performPostLoadCallback()
    {
        // echo 'loaded a record ...';
        if ($this->processedLoadCallback) {
            return true;
        }
    
        $currentFunc = FormUtil::getPassedValue('func', 'main', 'GETPOST', FILTER_SANITIZE_STRING);
        $usesCsvOutput = FormUtil::getPassedValue('usecsvext', false, 'GETPOST', FILTER_VALIDATE_BOOLEAN);
        
        // initialise the upload handler
        $uploadManager = new MUSound_UploadHandler();
        $serviceManager = ServiceUtil::getManager();
        $controllerHelper = new MUSound_Util_Controller($serviceManager);
        
        $this['id'] = (int) ((isset($this['id']) && !empty($this['id'])) ? DataUtil::formatForDisplay($this['id']) : 0);
        $this->formatTextualField('workflowState', $currentFunc, $usesCsvOutput, true);
        $this->formatTextualField('title', $currentFunc, $usesCsvOutput);
        $this->formatTextualField('description', $currentFunc, $usesCsvOutput);
        $this->formatTextualField('author', $currentFunc, $usesCsvOutput);
        if (!empty($this['uploadTrack'])) {
            try {
                $basePath = $controllerHelper->getFileBaseFolder('track', 'uploadTrack');
            } catch (\Exception $e) {
                return LogUtil::registerError($e->getMessage());
            }
        
            $fullPath = $basePath . $this['uploadTrack'];
            $this['uploadTrackFullPath'] = $fullPath;
            $this['uploadTrackFullPathURL'] = System::getBaseUrl() . $fullPath;
        
            // just some backwards compatibility stuff
            /*if (!isset($this['uploadTrackMeta']) || !is_array($this['uploadTrackMeta']) || !count($this['uploadTrackMeta'])) {
                // assign new meta data
                $this['uploadTrackMeta'] = $uploadManager->readMetaDataForFile($this['uploadTrack'], $fullPath);
            }*/
        }
        if (!empty($this['uploadZip'])) {
            try {
                $basePath = $controllerHelper->getFileBaseFolder('track', 'uploadZip');
            } catch (\Exception $e) {
                return LogUtil::registerError($e->getMessage());
            }
        
            $fullPath = $basePath . $this['uploadZip'];
            $this['uploadZipFullPath'] = $fullPath;
            $this['uploadZipFullPathURL'] = System::getBaseUrl() . $fullPath;
        
            // just some backwards compatibility stuff
            /*if (!isset($this['uploadZipMeta']) || !is_array($this['uploadZipMeta']) || !count($this['uploadZipMeta'])) {
                // assign new meta data
                $this['uploadZipMeta'] = $uploadManager->readMetaDataForFile($this['uploadZip'], $fullPath);
            }*/
        }
    
        $this->prepareItemActions();
    
        $this->processedLoadCallback = true;
    
        return true;
    }
    
    /**
     * Formats a given textual field depending on it's actual kind of content.
     *
     * @param string  $fieldName     Name of field to be formatted
     * @param string  $currentFunc   Name of current controller action
     * @param string  $usesCsvOutput Whether the output is CSV or not (defaults to false)
     * @param boolean $allowZero     Whether 0 values are allowed or not (defaults to false)
     */
    protected function formatTextualField($fieldName, $currentFunc, $usesCsvOutput = false, $allowZero = false)
    {
        if ($currentFunc == 'edit') {
            // apply no changes when editing the content
            return;
        }
    
        if ($usesCsvOutput == 1) {
            // apply no changes for CSV output
            return;
        }
    
        $string = '';
        if (isset($this[$fieldName])) {
            if (!empty($this[$fieldName]) || ($allowZero && $this[$fieldName] == 0)) {
                $string = $this[$fieldName];
                if ($this->containsHtml($string)) {
                    $string = DataUtil::formatForDisplayHTML($string);
                } else {
                    $string = DataUtil::formatForDisplay($string);
                    $string = nl2br($string);
                }
            }
        }
    
        // workaround for ampersand problem (#692)
        $string = str_replace('&amp;', '&', $string);
    
        $this[$fieldName] = $string;
    }
    
    /**
     * Checks whether any html tags are contained in the given string.
     * See http://stackoverflow.com/questions/10778035/how-to-check-if-string-contents-have-any-html-in-it for implementation details.
     *
     * @param $string string The given input string
     *
     * @return boolean Whether any html tags are found or not
     */
    protected function containsHtml($string)
    {
        return preg_match("/<[^<]+>/", $string, $m) != 0;
    }
    
    /**
     * Pre-Process the data prior to an insert operation.
     * The event happens before the entity managers persist operation is executed for this entity.
     *
     * Restrictions:
     *     - no access to entity manager or unit of work apis
     *     - no identifiers available if using an identity generator like sequences
     *     - Doctrine won't recognize changes on relations which are done here
     *       if this method is called by cascade persist
     *     - no creation of other entities allowed
     *
     * @see MUSound_Entity_Track::prePersistCallback()
     * @return boolean true if completed successfully else false
     */
    protected function performPrePersistCallback()
    {
        return true;
    }
    
    /**
     * Post-Process the data after an insert operation.
     * The event happens after the entity has been made persistant.
     * Will be called after the database insert operations.
     * The generated primary key values are available.
     *
     * Restrictions:
     *     - no access to entity manager or unit of work apis
     *
     * @see MUSound_Entity_Track::postPersistCallback()
     * @return boolean true if completed successfully else false
     */
    protected function performPostPersistCallback()
    {
        return true;
    }
    
    /**
     * Pre-Process the data prior a delete operation.
     * The event happens before the entity managers remove operation is executed for this entity.
     *
     * Restrictions:
     *     - no access to entity manager or unit of work apis
     *     - will not be called for a DQL DELETE statement
     *
     * @see MUSound_Entity_Track::preRemoveCallback()
     * @return boolean true if completed successfully else false
     */
    protected function performPreRemoveCallback()
    {
        // delete workflow for this entity
        $workflow = $this['__WORKFLOW__'];
        if ($workflow['id'] > 0) {
            $result = (bool) DBUtil::deleteObjectByID('workflows', $workflow['id']);
            if ($result === false) {
                $dom = ZLanguage::getModuleDomain('MUSound');
    
                return LogUtil::registerError(__('Error! Could not remove stored workflow. Deletion has been aborted.', $dom));
            }
        }
    
        return true;
    }
    
    /**
     * Post-Process the data after a delete.
     * The event happens after the entity has been deleted.
     * Will be called after the database delete operations.
     *
     * Restrictions:
     *     - no access to entity manager or unit of work apis
     *     - will not be called for a DQL DELETE statement
     *
     * @see MUSound_Entity_Track::postRemoveCallback()
     * @return boolean true if completed successfully else false
     */
    protected function performPostRemoveCallback()
    {
        $objectId = $this->createCompositeIdentifier();
    
        // initialise the upload handler
        $uploadManager = new MUSound_UploadHandler();
    
        $uploadFields = array('uploadTrack', 'uploadZip');
        foreach ($uploadFields as $uploadField) {
            if (empty($this->$uploadField)) {
                continue;
            }
    
            // remove upload file (and image thumbnails)
            $uploadManager->deleteUploadFile('track', $this, $uploadField, $objectId);
        }
    
        return true;
    }
    
    /**
     * Pre-Process the data prior to an update operation.
     * The event happens before the database update operations for the entity data.
     *
     * Restrictions:
     *     - no access to entity manager or unit of work apis
     *     - will not be called for a DQL UPDATE statement
     *     - changes on associations are not allowed and won't be recognized by flush
     *     - changes on properties won't be recognized by flush as well
     *     - no creation of other entities allowed
     *
     * @see MUSound_Entity_Track::preUpdateCallback()
     * @return boolean true if completed successfully else false
     */
    protected function performPreUpdateCallback()
    {
        return true;
    }
    
    /**
     * Post-Process the data after an update operation.
     * The event happens after the database update operations for the entity data.
     *
     * Restrictions:
     *     - no access to entity manager or unit of work apis
     *     - will not be called for a DQL UPDATE statement
     *
     * @see MUSound_Entity_Track::postUpdateCallback()
     * @return boolean true if completed successfully else false
     */
    protected function performPostUpdateCallback()
    {
        return true;
    }
    
    /**
     * Pre-Process the data prior to a save operation.
     * This combines the PrePersist and PreUpdate events.
     * For more information see corresponding callback handlers.
     *
     * @see MUSound_Entity_Track::preSaveCallback()
     * @return boolean true if completed successfully else false
     */
    protected function performPreSaveCallback()
    {
    
        return true;
    }
    
    /**
     * Post-Process the data after a save operation.
     * This combines the PostPersist and PostUpdate events.
     * For more information see corresponding callback handlers.
     *
     * @see MUSound_Entity_Track::postSaveCallback()
     * @return boolean true if completed successfully else false
     */
    protected function performPostSaveCallback()
    {
        return true;
    }
    
    
    /**
     * Returns the formatted title conforming to the display pattern
     * specified for this entity.
     *
     * @return string The display title
     */
    public function getTitleFromDisplayPattern()
    {
        $serviceManager = ServiceUtil::getManager();
        $listHelper = new MUSound_Util_ListEntries(ServiceUtil::getManager());
    
        $formattedTitle = ''
                . $this->getTitle();
    
        return $formattedTitle;
    }
    
    /**
     * Initialises the validator and return it's instance.
     *
     * @return MUSound_Entity_Validator_Track The validator for this entity
     */
    public function initValidator()
    {
        if (!is_null($this->_validator)) {
            return $this->_validator;
        }
        $this->_validator = new MUSound_Entity_Validator_Track($this);
    
        return $this->_validator;
    }
    
    /**
     * Sets/retrieves the workflow details.
     *
     * @param boolean $forceLoading load the workflow record
     */
    public function initWorkflow($forceLoading = false)
    {
        $currentFunc = FormUtil::getPassedValue('func', 'main', 'GETPOST', FILTER_SANITIZE_STRING);
        $isReuse = FormUtil::getPassedValue('astemplate', '', 'GETPOST', FILTER_SANITIZE_STRING);
    
        // apply workflow with most important information
        $idColumn = 'id';
        
        $serviceManager = ServiceUtil::getManager();
        $workflowHelper = new MUSound_Util_Workflow($serviceManager);
        
        $schemaName = $workflowHelper->getWorkflowName($this['_objectType']);
        $this['__WORKFLOW__'] = array(
            'module' => 'MUSound',
            'state' => $this['workflowState'],
            'obj_table' => $this['_objectType'],
            'obj_idcolumn' => $idColumn,
            'obj_id' => $this[$idColumn],
            'schemaname' => $schemaName
        );
        
        // load the real workflow only when required (e. g. when func is edit or delete)
        if ((!in_array($currentFunc, array('main', 'view', 'display')) && empty($isReuse)) || $forceLoading) {
            $result = Zikula_Workflow_Util::getWorkflowForObject($this, $this['_objectType'], $idColumn, 'MUSound');
            if (!$result) {
                $dom = ZLanguage::getModuleDomain('MUSound');
                LogUtil::registerError(__('Error! Could not load the associated workflow.', $dom));
            }
        }
        
        if (!is_object($this['__WORKFLOW__']) && !isset($this['__WORKFLOW__']['schemaname'])) {
            $workflow = $this['__WORKFLOW__'];
            $workflow['schemaname'] = $schemaName;
            $this['__WORKFLOW__'] = $workflow;
        }
    }
    
    /**
     * Resets workflow data back to initial state.
     * To be used after cloning an entity object.
     */
    public function resetWorkflow()
    {
        $this->setWorkflowState('initial');
    
        $serviceManager = ServiceUtil::getManager();
        $workflowHelper = new MUSound_Util_Workflow($serviceManager);
    
        $schemaName = $workflowHelper->getWorkflowName($this['_objectType']);
        $this['__WORKFLOW__'] = array(
            'module' => 'MUSound',
            'state' => $this['workflowState'],
            'obj_table' => $this['_objectType'],
            'obj_idcolumn' => 'id',
            'obj_id' => 0,
            'schemaname' => $schemaName
        );
    }
    
    /**
     * Start validation and raise exception if invalid data is found.
     *
     * @return void
     *
     * @throws Zikula_Exception Thrown if a validation error occurs
     */
    public function validate()
    {
        if ($this->_bypassValidation === true) {
            return;
        }
    
        $result = $this->initValidator()->validateAll();
        if (is_array($result)) {
            throw new Zikula_Exception($result['message'], $result['code'], $result['debugArray']);
        }
    
        return true;
    }
    
    /**
     * Return entity data in JSON format.
     *
     * @return string JSON-encoded data
     */
    public function toJson()
    {
        return json_encode($this->toArray());
    }
    
    /**
     * Collect available actions for this entity.
     */
    protected function prepareItemActions()
    {
        if (!empty($this->_actions)) {
            return;
        }
    
        $currentLegacyControllerType = FormUtil::getPassedValue('lct', 'user', 'GETPOST', FILTER_SANITIZE_STRING);
        $currentFunc = FormUtil::getPassedValue('func', 'main', 'GETPOST', FILTER_SANITIZE_STRING);
        $component = 'MUSound:Track:';
        $instance = $this->id . '::';
        $dom = ZLanguage::getModuleDomain('MUSound');
        if ($currentLegacyControllerType == 'admin') {
            if (in_array($currentFunc, array('main', 'view'))) {
                $this->_actions[] = array(
                    'url' => array('type' => 'user', 'func' => 'display', 'arguments' => array('ot' => 'track', 'id' => $this['id'])),
                    'icon' => 'preview',
                    'linkTitle' => __('Open preview page', $dom),
                    'linkText' => __('Preview', $dom)
                );
                $this->_actions[] = array(
                    'url' => array('type' => 'admin', 'func' => 'display', 'arguments' => array('ot' => 'track', 'id' => $this['id'])),
                    'icon' => 'display',
                    'linkTitle' => str_replace('"', '', $this->getTitleFromDisplayPattern()),
                    'linkText' => __('Details', $dom)
                );
            }
            if (in_array($currentFunc, array('main', 'view', 'display'))) {
                if (SecurityUtil::checkPermission($component, $instance, ACCESS_EDIT)) {
                    $this->_actions[] = array(
                        'url' => array('type' => 'admin', 'func' => 'edit', 'arguments' => array('ot' => 'track', 'id' => $this['id'])),
                        'icon' => 'edit',
                        'linkTitle' => __('Edit', $dom),
                        'linkText' => __('Edit', $dom)
                    );
                    $this->_actions[] = array(
                        'url' => array('type' => 'admin', 'func' => 'edit', 'arguments' => array('ot' => 'track', 'astemplate' => $this['id'])),
                        'icon' => 'saveas',
                        'linkTitle' => __('Reuse for new item', $dom),
                        'linkText' => __('Reuse', $dom)
                    );
                }
                if (SecurityUtil::checkPermission($component, $instance, ACCESS_DELETE)) {
                    $this->_actions[] = array(
                        'url' => array('type' => 'admin', 'func' => 'delete', 'arguments' => array('ot' => 'track', 'id' => $this['id'])),
                        'icon' => 'delete',
                        'linkTitle' => __('Delete', $dom),
                        'linkText' => __('Delete', $dom)
                    );
                }
            }
            if ($currentFunc == 'display') {
                $this->_actions[] = array(
                    'url' => array('type' => 'admin', 'func' => 'view', 'arguments' => array('ot' => 'track')),
                    'icon' => 'back',
                    'linkTitle' => __('Back to overview', $dom),
                    'linkText' => __('Back to overview', $dom)
                );
            }
        }
        if ($currentLegacyControllerType == 'user') {
            if (in_array($currentFunc, array('main', 'view'))) {
                $this->_actions[] = array(
                    'url' => array('type' => 'user', 'func' => 'display', 'arguments' => array('ot' => 'track', 'id' => $this['id'])),
                    'icon' => 'display',
                    'linkTitle' => str_replace('"', '', $this->getTitleFromDisplayPattern()),
                    'linkText' => __('Details', $dom)
                );
            }
            if (in_array($currentFunc, array('main', 'view', 'display'))) {
                if (SecurityUtil::checkPermission($component, $instance, ACCESS_EDIT)) {
                    $this->_actions[] = array(
                        'url' => array('type' => 'user', 'func' => 'edit', 'arguments' => array('ot' => 'track', 'id' => $this['id'])),
                        'icon' => 'edit',
                        'linkTitle' => __('Edit', $dom),
                        'linkText' => __('Edit', $dom)
                    );
                    $this->_actions[] = array(
                        'url' => array('type' => 'user', 'func' => 'edit', 'arguments' => array('ot' => 'track', 'astemplate' => $this['id'])),
                        'icon' => 'saveas',
                        'linkTitle' => __('Reuse for new item', $dom),
                        'linkText' => __('Reuse', $dom)
                    );
                }
                if (SecurityUtil::checkPermission($component, $instance, ACCESS_DELETE)) {
                    $this->_actions[] = array(
                        'url' => array('type' => 'user', 'func' => 'delete', 'arguments' => array('ot' => 'track', 'id' => $this['id'])),
                        'icon' => 'delete',
                        'linkTitle' => __('Delete', $dom),
                        'linkText' => __('Delete', $dom)
                    );
                }
            }
            if ($currentFunc == 'display') {
                $this->_actions[] = array(
                    'url' => array('type' => 'user', 'func' => 'view', 'arguments' => array('ot' => 'track')),
                    'icon' => 'back',
                    'linkTitle' => __('Back to overview', $dom),
                    'linkText' => __('Back to overview', $dom)
                );
            }
        }
    }
    
    /**
     * Creates url arguments array for easy creation of display urls.
     *
     * @return array The resulting arguments list
     */
    public function createUrlArgs()
    {
        $args = array('ot' => $this['_objectType']);
    
        $args['id'] = $this['id'];
    
        if (property_exists($this, 'slug')) {
            $args['slug'] = $this['slug'];
        }
    
        return $args;
    }
    
    /**
     * Create concatenated identifier string (for composite keys).
     *
     * @return String concatenated identifiers
     */
    public function createCompositeIdentifier()
    {
        $itemId = $this['id'];
    
        return $itemId;
    }
    
    /**
     * Determines whether this entity supports hook subscribers or not.
     *
     * @return boolean
     */
    public function supportsHookSubscribers()
    {
        return true;
    }
    
    /**
     * Return lower case name of multiple items needed for hook areas.
     *
     * @return string
     */
    public function getHookAreaPrefix()
    {
        return 'musound.ui_hooks.tracks';
    }
    
    /**
     * Returns an array of all related objects that need to be persisted after clone.
     * 
     * @param array $objects The objects are added to this array. Default: array()
     * 
     * @return array of entity objects
     */
    public function getRelatedObjectsToPersist(&$objects = array()) 
    {
        return array();
    }
    
    /**
     * ToString interceptor implementation.
     * This method is useful for debugging purposes.
     *
     * @return string The output string for this entity
     */
    public function __toString()
    {
        return $this->getId();
    }
    
    /**
     * Clone interceptor implementation.
     * This method is for example called by the reuse functionality.
     * Performs a quite simple shallow copy.
     *
     * See also:
     * (1) http://docs.doctrine-project.org/en/latest/cookbook/implementing-wakeup-or-clone.html
     * (2) http://www.php.net/manual/en/language.oop5.cloning.php
     * (3) http://stackoverflow.com/questions/185934/how-do-i-create-a-copy-of-an-object-in-php
     */
    public function __clone()
    {
        // If the entity has an identity, proceed as normal.
        if ($this->id) {
            // unset identifiers
            $this->setId(0);
    
            // init validator
            $this->initValidator();
    
            // reset Workflow
            $this->resetWorkflow();
    
            // reset upload fields
            $this->setUploadTrack('');
            $this->setUploadTrackMeta(array());
            $this->setUploadZip('');
            $this->setUploadZipMeta(array());
    
            $this->setCreatedDate(null);
            $this->setCreatedUserId(null);
            $this->setUpdatedDate(null);
            $this->setUpdatedUserId(null);
    
            
        }
        // otherwise do nothing, do NOT throw an exception!
    }
}
