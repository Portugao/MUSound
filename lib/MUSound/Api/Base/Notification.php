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
 * Notification api base class.
 */
class MUSound_Api_Base_Notification extends Zikula_AbstractApi
{
    /**
     * List of notification recipients.
     *
     * @var array $recipients
     */
    private $recipients = array();
    
    /**
     * Which type of recipient is used ("creator", "moderator" or "superModerator").
     *
     * @var string recipientType
     */
    private $recipientType = '';
    
    /**
     * The entity which has been changed before.
     *
     * @var Zikula_EntityAccess entity
     */
    private $entity = '';
    
    /**
     * Name of workflow action which is being performed.
     *
     * @var string action
     */
    private $action = '';
    
    
    /**
     * Sends a mail to either an item's creator or a group of moderators.
     */
    public function process($args)
    {
        if (!isset($args['recipientType']) || !$args['recipientType']) {
            return false;
        }
    
        if (!isset($args['action']) || !$args['action']) {
            return false;
        }
    
        if (!isset($args['entity']) || !$args['entity']) {
            return false;
        }
    
        $this->recipientType = $args['recipientType'];
        $this->action = $args['action'];
        $this->entity = $args['entity'];
    
        $uid = UserUtil::getVar('uid');
    
        $this->collectRecipients();
    
        if (!count($this->recipients)) {
            return true;
        }
    
        if (!ModUtil::available('Mailer') || !ModUtil::loadApi('Mailer', 'user')) {
            return LogUtil::registerError($this->__('Could not inform other persons about your amendments, because the Mailer module is not available - please contact an administrator about that!'));
        }
    
        $result = $this->sendMails();
    
        SessionUtil::delVar($this->name . 'AdditionalNotificationRemarks');
    
        return $result;
    }
    
    /**
     * Collects the recipients.
     */
    protected function collectRecipients()
    {
        $this->recipients = array();
    
        if ($this->recipientType == 'moderator' || $this->recipientType == 'superModerator') {
            $objectType = $this->entity['_objectType'];
            $moderatorGroupId = $this->getVar('moderationGroupFor' . $objectType, 2);
            if ($this->recipientType == 'superModerator') {
                $moderatorGroupId = $this->getVar('superModerationGroupFor' . $objectType, 2);
            }
    
            $moderatorGroup = ModUtil::apiFunc('Groups', 'user', 'get', array('gid' => $moderatorGroupId));
            foreach (array_keys($moderatorGroup['members']) as $uid) {
                $this->addRecipient($uid);
            }
        } elseif ($this->recipientType == 'creator' && isset($this->entity['createdUserId'])) {
            $creatorUid = $this->entity['createdUserId'];
    
            $this->addRecipient($creatorUid);
        }
    
        if (isset($args['debug']) && $args['debug']) {
            // add the admin, too
            $this->addRecipient(2);
        }
    }
    
    /**
     * Collects data for building the recipients array.
     *
     * @param $userId Id of treated user
     */
    protected function addRecipient($userId)
    {
        $userVars = UserUtil::getVars($userId);
    
        $recipient = array(
            'name' => (isset($userVars['name']) && !empty($userVars['name']) ? $userVars['name'] : $userVars['uname']),
            'email' => $userVars['email']
        );
        $this->recipients[] = $recipient;
    
        return $recipient;
    }
    
    /**
     * Performs the actual mailing.
     */
    protected function sendMails()
    {
        $objectType = $this->entity['_objectType'];
        $siteName = System::getVar('sitename');
    
        $view = Zikula_View::getInstance('MUSound');
        $templateType = $this->recipientType == 'creator' ? 'Creator' : 'Moderator';
        $template = 'email/notify' . ucfirst($objectType) . $templateType .  '.tpl';
    
        $mailData = $this->prepareEmailData();
        $subject = $this->getMailSubject();
    
        // send one mail per recipient
        $totalResult = true;
        foreach ($this->recipients as $recipient) {
            if (!isset($recipient['username']) || !$recipient['username']) {
                continue;
            }
            if (!isset($recipient['email']) || !$recipient['email']) {
                continue;
            }
    
            $view->assign('recipient', $recipient)
                 ->assign('mailData', $mailData);
    
            $mailArgs = array(
                'fromname' => $siteName,
                'toname' => $recipient['name'],
                'toaddress' => $recipient['email'],
                'subject' => $this->getMailSubject(),
                'body' => $view->fetch($template),
                'html' => true
            );
    
            $totalResult &= ModUtil::apiFunc('Mailer', 'user', 'sendmessage', $mailArgs);
        }
    
        return $totalResult;
    }
    
    protected function getMailSubject()
    {
        $mailSubject = '';
        if ($this->recipientType == 'moderator' || $this->recipientType == 'superModerator') {
            if ($this->action == 'submit') {
                $mailSubject = $this->__('New content has been submitted');
            } else {
                $mailSubject = $this->__('Content has been updated');
            }
        } elseif ($this->recipientType == 'creator') {
            $mailSubject = $this->__('Your submission has been updated');
        }
    
        return $mailSubject;
    }
    
    protected function prepareEmailData()
    {
        $serviceManager = ServiceUtil::getManager();
        $workflowHelper = new MUSound_Util_Workflow($serviceManager);
    
        $objectType = $this->entity['_objectType'];
        $state = $this->entity['workflowState'];
        $stateInfo = $workflowHelper->getStateInfo($state);
    
        $remarks = SessionUtil::getVar($this->name . 'AdditionalNotificationRemarks', '');
    
        $urlArgs = $this->entity->createUrlArgs();
        $displayUrl = '';
        $editUrl = '';
    
        if ($this->recipientType == 'moderator' || $this->recipientType == 'superModerator') {
            $displayUrl = ModUtil::url($this->name, 'admin', 'display', $urlArgs, null, null, true); // absolute
            $editUrl = ModUtil::url($this->name, 'admin', 'edit', $urlArgs, null, null, true); // absolute
        } elseif ($this->recipientType == 'creator') {
            $displayUrl = ModUtil::url($this->name, 'user', 'display', $urlArgs, null, null, true); // absolute
            $editUrl = ModUtil::url($this->name, 'user', 'edit', $urlArgs, null, null, true); // absolute
        }
    
        $emailData = array(
            'name' => $this->entity->getTitleFromDisplayPattern(),
            'newState' => $stateInfo['text'],
            'remarks' => $remarks,
            'displayUrl' => $displayUrl,
            'editUrl' => $editUrl
        );
    
        return $emailData;
    }
}
