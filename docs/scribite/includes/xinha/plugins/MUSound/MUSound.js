// MUSound plugin for Xinha
// developed by Michael Ueberschaer
//
// requires MUSound module (http://webdesign-in-bremen.com)
//
// Distributed under the same terms as xinha itself.
// This notice MUST stay intact for use (see license.txt).

'use strict';

function MUSound(editor) {
    var cfg, self;

    this.editor = editor;
    cfg = editor.config;
    self = this;

    cfg.registerButton({
        id       : 'MUSound',
        tooltip  : 'Insert MUSound object',
     // image    : _editor_url + 'plugins/MUSound/img/ed_MUSound.gif',
        image    : '/images/icons/extrasmall/favorites.png',
        textMode : false,
        action   : function (editor) {
            var url = Zikula.Config.baseURL + 'index.php'/*Zikula.Config.entrypoint*/ + '?module=MUSound&type=external&func=finder&editor=xinha';
            MUSoundFinderXinha(editor, url);
        }
    });
    cfg.addToolbarElement('MUSound', 'insertimage', 1);
}

MUSound._pluginInfo = {
    name          : 'MUSound for xinha',
    version       : '1.0.0',
    developer     : 'Michael Ueberschaer',
    developer_url : 'http://webdesign-in-bremen.com',
    sponsor       : 'ModuleStudio 0.6.1',
    sponsor_url   : 'http://modulestudio.de',
    license       : 'htmlArea'
};
