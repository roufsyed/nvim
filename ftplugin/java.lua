local project_name = vim.fn.fnamemodify(vim.fn.getcwd(), ':p:h:t')
local workspace_dir = vim.fn.stdpath('data') .. '/site/java/workspace-root/' .. project_name

local config = {
  cmd = {
    'java', -- or '/path/to/java18_or_newer/bin/java'
    '-Declipse.application=org.eclipse.jdt.ls.core.id2',
    '-Dosgi.bundles.defaultStartLevel=5',
    '-Declipse.product=org.eclipse.jdt.ls.core.product',
    '-Dlog.protocol=true',
    '-Dlog.level=ALL',
    '-Xms2g',
    '--add-modules=ALL-SYSTEM',
    '--add-opens', 'java.base/java.util=ALL-UNNAMED',
    '--add-opens', 'java.base/java.lang=ALL-UNNAMED',
    '-jar', vim.fn.glob('~/.local/share/nvim/mason/packages/jdtls/plugins/org.eclipse.equinox.launcher_*.jar'),
    '-configuration', '~/.local/share/nvim/mason/packages/jdtls/config_mac', -- Adjust for your OS: config_win or config_mac
    '-data', workspace_dir,
  },
  root_dir = require('jdtls.setup').find_root({'.git', 'mvnw', 'gradlew'}),
  settings = {
    java = {
      configuration = {
        runtimes = {
          {
            name = "JavaSE-16",
            path = "/path/to/java18",
          },
        },
      },
    },
  },
  init_options = {
    bundles = {},
  },
}

require('jdtls').start_or_attach(config)

