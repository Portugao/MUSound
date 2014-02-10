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
 * The musoundItemSelector plugin provides items for a dropdown selector.
 *
 * @param  array            $params All attributes passed to this function from the template.
 * @param  Zikula_Form_View $view   Reference to the view object.
 *
 * @return string The output of the plugin.
 */
function smarty_function_musoundItemSelector($params, $view)
{
    return $view->registerPlugin('MUSound_Form_Plugin_ItemSelector', $params);
}
