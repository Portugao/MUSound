<?php
/**
 * MUSound.
 *
 * @copyright Michael Ueberschaer (MU)
 * @license 
 * @package MUSound
 * @author Michael Ueberschaer <kontakt@webdesign-in-bremen.com>.
 * @link http://webdesign-in-bremen.com
 * @link http://zikula.org
 * @version Generated by ModuleStudio 0.6.1 (http://modulestudio.de).
 */

/**
 * Event handler base class for user-related events.
 */
class MUSound_Listener_Base_User
{
    /**
     * Listener for the `user.gettheme` event.
     *
     * Called during UserUtil::getTheme() and is used to filter the results.
     * Receives arg['type'] with the type of result to be filtered
     * and the $themeName in the $event->data which can be modified.
     * Must $event->stop() if handler performs filter.
     *
     * @param Zikula_Event $event The event instance.
     */
    public static function getTheme(Zikula_Event $event)
    {
    }
    
    /**
     * Listener for the `user.account.create` event.
     *
     * Occurs after a user account is created. All handlers are notified.
     * It does not apply to creation of a pending registration.
     * The full user record created is available as the subject.
     * This is a storage-level event, not a UI event. It should not be used for UI-level actions such as redirects.
     * The subject of the event is set to the user record that was created.
     *
     * @param Zikula_Event $event The event instance.
     */
    public static function create(Zikula_Event $event)
    {
    }
    
    /**
     * Listener for the `user.account.update` event.
     *
     * Occurs after a user is updated. All handlers are notified.
     * The full updated user record is available as the subject.
     * This is a storage-level event, not a UI event. It should not be used for UI-level actions such as redirects.
     * The subject of the event is set to the user record, with the updated values.
     *
     * @param Zikula_Event $event The event instance.
     */
    public static function update(Zikula_Event $event)
    {
    }
    
    /**
     * Listener for the `user.account.delete` event.
     *
     * Occurs after a user is deleted from the system.
     * All handlers are notified.
     * The full user record deleted is available as the subject.
     * This is a storage-level event, not a UI event. It should not be used for UI-level actions such as redirects.
     * The subject of the event is set to the user record that is being deleted.
     *
     * @param Zikula_Event $event The event instance.
     */
    public static function delete(Zikula_Event $event)
    {
        ModUtil::initOOModule('MUSound');
    
        $userRecord = $event->getSubject();
        $uid = $userRecord['uid'];
        $serviceManager = ServiceUtil::getManager();
        $entityManager = $serviceManager->getService('doctrine.entitymanager');
        
        $repo = $entityManager->getRepository('MUSound_Entity_Album');
        // delete all albums created by this user
        $repo->deleteCreator($uid);
        // note you could also do: $repo->updateCreator($uid, 2);
        
        // set last editor to admin (2) for all albums updated by this user
        $repo->updateLastEditor($uid, 2);
        // note you could also do: $repo->deleteLastEditor($uid);
        
        $repo = $entityManager->getRepository('MUSound_Entity_Track');
        // delete all tracks created by this user
        $repo->deleteCreator($uid);
        // note you could also do: $repo->updateCreator($uid, 2);
        
        // set last editor to admin (2) for all tracks updated by this user
        $repo->updateLastEditor($uid, 2);
        // note you could also do: $repo->deleteLastEditor($uid);
        
        $repo = $entityManager->getRepository('MUSound_Entity_Collection');
        // delete all collections created by this user
        $repo->deleteCreator($uid);
        // note you could also do: $repo->updateCreator($uid, 2);
        
        // set last editor to admin (2) for all collections updated by this user
        $repo->updateLastEditor($uid, 2);
        // note you could also do: $repo->deleteLastEditor($uid);
    }
}
