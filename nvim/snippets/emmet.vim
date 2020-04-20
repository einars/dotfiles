let g:user_emmet_settings = {
      \  'javascript': { 'extends': 'jsx' },
      \  'html': {
      \    'snippets': {
      \      '!': join(readfile(EditorRoot() . '/snippets/html.s'), "\r"),
      \      'test': 'this works',
      \    }
      \  },
      \}
