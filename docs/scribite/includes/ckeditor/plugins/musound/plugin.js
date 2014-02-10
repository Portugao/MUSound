CKEDITOR.plugins.add('MUSound', {
    requires: 'popup',
    lang: 'en,nl,de',
    init: function (editor) {
        editor.addCommand('insertMUSound', {
            exec: function (editor) {
                var url = Zikula.Config.baseURL + Zikula.Config.entrypoint + '?module=MUSound&type=external&func=finder&editor=ckeditor';
                // call method in MUSound_Finder.js and also give current editor
                MUSoundFinderCKEditor(editor, url);
            }
        });
        editor.ui.addButton('musound', {
            label: 'Insert MUSound object',
            command: 'insertMUSound',
         // icon: this.path + 'images/ed_musound.png'
            icon: '/images/icons/extrasmall/favorites.png'
        });
    }
});
