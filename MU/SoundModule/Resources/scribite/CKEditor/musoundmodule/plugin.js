CKEDITOR.plugins.add('musoundmodule', {
    requires: 'popup',
    lang: 'en,nl,de',
    init: function (editor) {
        editor.addCommand('insertMUSoundModule', {
            exec: function (editor) {
                var url = Routing.generate('musoundmodule_external_finder', { objectType: 'collection', editor: 'ckeditor' });
                // call method in MUSoundModule.Finder.js and provide current editor
                MUSoundModuleFinderCKEditor(editor, url);
            }
        });
        editor.ui.addButton('musoundmodule', {
            label: editor.lang.musoundmodule.title,
            command: 'insertMUSoundModule',
            icon: this.path.replace('scribite/CKEditor/musoundmodule', 'public/images') + 'admin.png'
        });
    }
});
