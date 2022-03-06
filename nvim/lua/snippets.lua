local ls = require("luasnip")

ls.snippets = {
  all = {
  },

  typescriptreact = {
    ls.parser.parse_snippet("imr", "import React from 'react'"),
    ls.parser.parse_snippet("imrc", "import React from 'react'\n\nconst $TM_FILENAME_BASE = (): JSX.Element => {\n return (\n   <>$1</>\n )\n}\n\nexport default $TM_FILENAME_BASE")
  }
}
