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
 * Permission check for workflow schema 'none'.
 * This function allows to calculate complex permission checks.
 * It receives the object the workflow engine is being asked to process and the permission level the action requires.
 *
 * @param array  $obj         The currently treated object.
 * @param int    $permLevel   The required workflow permission level.
 * @param int    $currentUser Id of current user.
 * @param string $actionId    Id of the workflow action to be executed.
 *
 * @return bool Whether the current user is allowed to execute the action or not.
 */
function MUSound_workflow_none_permissioncheck($obj, $permLevel, $currentUser, $actionId)
{

    // calculate the permission component
    $objectType = $obj['_objectType'];
    $component = 'MUSound:' . ucwords($objectType) . ':';

    // calculate the permission instance
    $idFields = ModUtil::apiFunc('MUSound', 'selection', 'getIdFields', array('ot' => $objectType));
    $instanceId = '';
    foreach ($idFields as $idField) {
        if (!empty($instanceId)) {
            $instanceId .= '_';
        }
        $instanceId .= $obj[$idField];
    }
    $instance = $instanceId . '::';

    // now perform the permission check
    $result = SecurityUtil::checkPermission($component, $instance, $permLevel, $currentUser);

    // check whether the current user is the owner
    if (!$result && isset($obj['createdUserId']) && $obj['createdUserId'] == $currentUser) {
        // allow author update operations for all states which occur before 'approved' in the object's life cycle.
        $result = in_array($actionId, array('initial', 'accepted'));
    }

    return $result;
}

/**
 * This helper functions cares for including the strings used in the workflow into translation.
 */
function MUSound_workflow_none_gettextstrings()
{
    return array(
        'title' => no__('None workflow (no approval)'),
        'description' => no__('This is like a non-existing workflow. Everything is online immediately after creation.'),

        // state titles
        'states' => array(
            no__('Initial') => no__('Pseudo-state for content which is just created and not persisted yet.'),
            no__('Approved') => no__('Content has been approved and is available online.'),
            no__('Deleted') => no__('Pseudo-state for content which has been deleted from the database.')
        ),

        // action titles and descriptions for each state
        'actions' => array(
            'initial' => array(
                no__('Submit') => no__('Submit content.'),
            )
            ,
            'approved' => array(
                no__('Update') => no__('Update content.'),
                no__('Delete') => no__('Delete content permanently.')
            )
            ,
            'deleted' => array(
            )
        )
    );
}
