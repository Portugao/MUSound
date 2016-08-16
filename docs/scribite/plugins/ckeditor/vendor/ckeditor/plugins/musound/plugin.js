CKEDITOR.plugins.add('musound', {
    requires: 'popup',
    lang: 'en,nl,de',
    init: function (editor) {
        editor.addCommand('insertMUSound', {
            exec: function (editor) {
                var url = Zikula.Config.baseURL + Zikula.Config.entrypoint + '?module=MUSound&type=external&func=finder&editor=ckeditor';
                // call method in MUSound_finder.js and provide current editor
                MUSoundFinderCKEditor(editor, url);
            }
        });
        editor.ui.addButton('musound', {
            label: editor.lang.musound.title,
            command: 'insertMUSound',
         // icon: this.path + 'images/ed_musound.png'
            icon: '/images/icons/extrasmall/favorites.png'
        });
    }
});
