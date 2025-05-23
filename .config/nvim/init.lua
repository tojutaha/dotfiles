-- Set <space> as the leader key
-- See `:help mapleader`
--  NOTE: Must happen before plugins are required (otherwise wrong leader will be used)
vim.g.mapleader = ' '
vim.g.maplocalleader = ' '
vim.keymap.set('i', 'jj', '<Esc>')

-- [[ Install `lazy.nvim` plugin manager ]]
--    https://github.com/folke/lazy.nvim
--    `:help lazy.nvim.txt` for more info
local lazypath = vim.fn.stdpath 'data' .. '/lazy/lazy.nvim'
if not vim.loop.fs_stat(lazypath) then
  vim.fn.system {
    'git',
    'clone',
    '--filter=blob:none',
    'https://github.com/folke/lazy.nvim.git',
    '--branch=stable', -- latest stable release
    lazypath,
  }
end
vim.opt.rtp:prepend(lazypath)

-- [[ Configure plugins ]]
-- NOTE: Here is where you install your plugins.
--  You can configure plugins using the `config` key.
--
--  You can also configure plugins after the setup call,
--    as they will be available in your neovim runtime.
require('lazy').setup({

  'duane9/nvim-rg',
  'skywind3000/asyncrun.vim',
  'junegunn/fzf.vim',
  'zackhsi/fzf-tags',
  -- 'ervandew/supertab',
  'mg979/vim-visual-multi',
  -- 'voldikss/vim-floaterm',
  'junegunn/vim-easy-align',
  'folke/zen-mode.nvim',
  'ryanoasis/vim-devicons',

  {
    'nvimdev/lspsaga.nvim',
    config = function()
      require('lspsaga').setup({})
    end,
    dependencies = {
      'nvim-treesitter/nvim-treesitter',
      'nvim-tree/nvim-web-devicons',
    }
  },

  {
    'Chaitanyabsprip/fastaction.nvim',
      ---@type FastActionConfig
      opts = {},
  },

  {
    "supermaven-inc/supermaven-nvim",
    config = function()
      require("supermaven-nvim").setup({
        -- keymaps = {
        --   accept_suggestion = "<Tab>",
        --   clear_suggestion = "<C-]>",
        --   accept_word = "<C-j>",
        -- },
        -- ignore_filetypes = { cpp = true }, -- or { "cpp", }
        -- color = {
        --   suggestion_color = "#ffffff",
        --   cterm = 244,
        -- },
        log_level = "info", -- set to "off" to disable logging completely
        disable_inline_completion = false, -- disables inline completion for use with cmp
        disable_keymaps = true, -- disables built in keymaps for more manual control
        condition = function()
          return false
        end -- condition to check for stopping supermaven, `true` means to stop supermaven when the condition is true
      })
    end,
  },

  {
    'p00f/clangd_extensions.nvim',
    config = function()
      require('clangd_extensions').setup({
        inlay_hints = {
          inline = vim.fn.has("nvim-0.10") == 1,
          -- Options other than `highlight' and `priority' only work
          -- if `inline' is disabled
          -- Only show inlay hints for the current line
          only_current_line = false,
          -- Event which triggers a refresh of the inlay hints.
          -- You can make this { "CursorMoved" } or { "CursorMoved,CursorMovedI" } but
          -- note that this may cause higher CPU usage.
          -- This option is only respected when only_current_line is true.
          only_current_line_autocmd = { "CursorHold" },
          -- whether to show parameter hints with the inlay hints or not
          show_parameter_hints = true,
          -- prefix for parameter hints
          parameter_hints_prefix = "<- ",
          -- prefix for all the other hints (type, chaining)
          other_hints_prefix = "=> ",
          -- whether to align to the length of the longest line in the file
          max_len_align = false,
          -- padding from the left if max_len_align is true
          max_len_align_padding = 1,
          -- whether to align to the extreme right or not
          right_align = false,
          -- padding from the right if right_align is true
          right_align_padding = 7,
          -- The color of the hints
          highlight = "Comment",
          -- The highlight group priority for extmark
          priority = 100,
        },
        ast = {
          -- These are unicode, should be available in any font
          role_icons = {
            type = "🄣",
            declaration = "🄓",
            expression = "🄔",
            statement = ";",
            specifier = "🄢",
            ["template argument"] = "🆃",
          },
          kind_icons = {
            Compound = "🄲",
            Recovery = "🅁",
            TranslationUnit = "🅄",
            PackExpansion = "🄿",
            TemplateTypeParm = "🅃",
            TemplateTemplateParm = "🅃",
            TemplateParamObject = "🅃",
          },
          --[[ These require codicons (https://github.com/microsoft/vscode-codicons)
          role_icons = {
            type = "",
            declaration = "",
            expression = "",
            specifier = "",
            statement = "",
            ["template argument"] = "",
          },

          kind_icons = {
            Compound = "",
            Recovery = "",
            TranslationUnit = "",
            PackExpansion = "",
            TemplateTypeParm = "",
            TemplateTemplateParm = "",
            TemplateParamObject = "",
          }, ]]

          highlights = {
            detail = "Comment",
          },
        },
        memory_usage = {
          border = "none",
        },
        symbol_info = {
          border = "none",
        },
      })
    end,
  },

  -- NOTE: This is where your plugins related to LSP can be installed.
  --  The configuration is done below. Search for lspconfig to find it below.
  {
    -- LSP Configuration & Plugins
    'neovim/nvim-lspconfig',
    dependencies = {
      -- Automatically install LSPs to stdpath for neovim
      { 'williamboman/mason.nvim', config = true },
      'williamboman/mason-lspconfig.nvim',
    },
  },

  {
    'ray-x/lsp_signature.nvim',
    event = 'VeryLazy',
    opts = {},
    config = function(_, opts) require'lsp_signature'.setup(opts) end
  },

  {
    -- Autocompletion
    'hrsh7th/nvim-cmp',
    dependencies = {
      -- Snippet Engine & its associated nvim-cmp source
      'L3MON4D3/LuaSnip',
      'saadparwaiz1/cmp_luasnip',

      -- Adds LSP completion capabilities
      'hrsh7th/cmp-nvim-lsp',
      'hrsh7th/cmp-path',

      -- Adds a number of user-friendly snippets
      -- 'rafamadriz/friendly-snippets',
    },
  },

  {
    -- Set lualine as statusline
    'nvim-lualine/lualine.nvim',
    -- See `:help lualine.txt`
    opts = {
      options = {
        icons_enabled = false,
        theme = 'auto',
        component_separators = '|',
        section_separators = '',
      },
    },
  },

  -- "gc" to comment visual regions/lines
  { 'numToStr/Comment.nvim', opts = {} },

  -- Fuzzy Finder (files, lsp, etc)
  {
    'nvim-telescope/telescope.nvim',
    branch = '0.1.x',
    dependencies = {
      'nvim-lua/plenary.nvim',
      -- Fuzzy Finder Algorithm which requires local dependencies to be built.
      -- Only load if `make` is available. Make sure you have the system
      -- requirements installed.
      {
        'nvim-telescope/telescope-fzf-native.nvim',
        -- NOTE: If you are having trouble with this installation,
        --       refer to the README for telescope-fzf-native for more instructions.
        build = 'make',
        cond = function()
          return vim.fn.executable 'make' == 1
        end,
      },

      config = function()
        require('telescope').setup {
          extensions = {
            fzf = {}
          }
        }

        require('telescope').load_extension('fzf')
      end
    },
  },

  {
    "fdschmidt93/telescope-egrepify.nvim",
  },

  {
    -- Highlight, edit, and navigate code
    'nvim-treesitter/nvim-treesitter',
    dependencies = {
      'nvim-treesitter/nvim-treesitter-textobjects',
    },
    build = ':TSUpdate',
  },

  -- Themes
  {
    -- "askfiy/visual_studio_code",
    -- "rebelot/kanagawa.nvim",
    -- "folke/tokyonight.nvim",
    -- "savq/melange-nvim",
    -- "catppuccin/nvim",
    -- "rose-pine/neovim",
    "xiyaowong/transparent.nvim",
    "ellisonleao/gruvbox.nvim",
    "comfysage/evergarden",
  },

}, {})

-- Terminal

vim.api.nvim_create_autocmd('TermOpen', {
  group = vim.api.nvim_create_augroup('TermOpen', { clear = true }),
  callback = function()
    vim.opt.number = false
    vim.opt.relativenumber = false
  end,
})

local job_id = 0
vim.keymap.set('n', '<space>tt', function()
  vim.cmd.vnew()
  vim.cmd.term()
  vim.cmd.wincmd('J')
  vim.api.nvim_win_set_height(0, 10)
  -- vim.api.nvim_open_win()
  job_id = vim.bo.channel
end)

vim.keymap.set('n', '<space>tc', function()
  vim.fn.chansend(job_id, { "ls -la\r\n" })
end)

vim.api.nvim_set_keymap('t', '<Esc>', '<C-\\><C-n>', { noremap = true, silent = true })
vim.api.nvim_set_keymap('n', '<leader>t', ':NERDTreeToggle<CR>', {noremap = true, silent = true})

-- replace word but keep the yank
local function replace_word_with_yank()
  -- Delete the word under the cursor without affecting the default register
  vim.cmd('normal! "_diw')
  -- Paste the yanked text
  vim.cmd('normal! viw"0p')
end

vim.api.nvim_set_keymap('n', 'viwp', '', {
  noremap = true,
  silent = true,
  callback = replace_word_with_yank
})

-- Floaterm
vim.api.nvim_set_keymap('n', '<leader>ft', ':FloatermToggle<CR>', {noremap = true, silent = true})


-- Scope annotation
local api = vim.api
local ns_id = vim.api.nvim_create_namespace("AnnotatePlugin")
vim.g.annotate_scope_enabled = false

function clear_virtual_text()
    if not vim.g.annotate_scope_enabled then
        return
    end
    local buf = api.nvim_get_current_buf()
    -- Clear the previous virtual text
    api.nvim_buf_clear_namespace(buf, ns_id, 0, -1)
end

function annotate_scope()
    if not vim.g.annotate_scope_enabled then
        return
    end
    local buf = api.nvim_get_current_buf()
    local cursor = api.nvim_win_get_cursor(0)
    local line = cursor[1]
    --local col = cursor[2]
    local lines = api.nvim_buf_get_lines(buf, 0, -1, false)
    local scope_stack = {}

    -- Clear the previous virtual text
    api.nvim_buf_clear_namespace(buf, ns_id, 0, -1)

    for i = 1, #lines do
        for j = 1, #lines[i] do
            local char = lines[i]:sub(j, j)
            if char == '{' then
                -- Push the current line and line number onto the scope stack
                table.insert(scope_stack, {scope = lines[i-1], line = i})
            elseif char == '}' then
                if #scope_stack > 0 then
                    -- Pop the last scope from the stack and remove leading whitespace
                    local last_open_scope = table.remove(scope_stack)
                    local scope = last_open_scope.scope:gsub("^%s*(.-)%s*$", "%1")
                    local open_line = last_open_scope.line
                    -- Add virtual text to the end of the line with the closing brace
                    -- only if the cursor is between the lines of the opening and closing braces
                    if line > open_line and line <= i then
                        api.nvim_buf_set_virtual_text(buf, ns_id, i-1, {{'' .. scope, 'Comment'}}, {})
                        --api.nvim_buf_set_virtual_text(buf, 0, i-1, {{'' .. scope, 'AnnotateColor'}}, {})
                    end
                end
            end
        end
    end
end

function toggle_annotate_scope()
    vim.g.annotate_scope_enabled = not vim.g.annotate_scope_enabled
    local buf = api.nvim_get_current_buf()
    api.nvim_buf_clear_namespace(buf, ns_id, 0, -1)
end

vim.api.nvim_set_keymap('n', '<F5>', ':lua toggle_annotate_scope()<CR>', {noremap = true})

vim.api.nvim_exec([[
  augroup AnnotateScope
    autocmd!
    autocmd CursorMoved * lua clear_virtual_text()
    autocmd CursorHold * lua annotate_scope()
  augroup END
]], false)

require('lsp_signature').setup({
    bind = true,
    handler_opts = {
        border = "rounded"
    }
})

require('lualine').setup {
    options = {
        icons_enabled = true,
        theme = 'auto',
        component_separators = { left = '', right = ''},
        section_separators = { left = '', right = ''},
        disabled_filetypes = {
            statusline = {},
            winbar = {},
        },
        ignore_focus = {},
        always_divide_middle = true,
        globalstatus = false,
        refresh = {
            statusline = 1000,
            tabline = 1000,
            winbar = 1000,
        }
    },
    sections = {
        lualine_a = {'mode'},
        --lualine_b = {'branch', 'diff', 'diagnostics'},
        --lualine_b = {'diagnostics'},
        lualine_b = {},
        lualine_c = {'filename'},
        lualine_x = {'encoding', 'fileformat', 'filetype'},
        lualine_y = {'progress'},
        lualine_z = {'location'}
    },
    inactive_sections = {
        lualine_a = {},
        --lualine_b = {'branch'},
        lualine_b = {},
        lualine_c = {'filename'},
        lualine_x = {'location'},
        lualine_y = {},
        lualine_z = {}
    },
    tabline = {},
    winbar = {},
    inactive_winbar = {},
    extensions = {}
}

-- [[ Setting options ]]
-- See `:help vim.o`
-- NOTE: You can change these options as you wish!
-- Set highlight on search
vim.o.hlsearch = false

-- vim.opt.guicursor = "n-v-c-i:block,i:block"
vim.opt.guicursor = "n-v-c-i:block-nCursor,i:ver25-nCursor,o:hor50-nCursor"

-- Preview substitutions live, as you type
--vim.opt.inccommand = "true"

-- Make line numbers default
vim.wo.number = false
vim.wo.relativenumber = false

-- Enable mouse mode
vim.o.mouse = 'a'

-- Sync clipboard between OS and Neovim.
--  Remove this option if you want your OS clipboard to remain independent.
--  See `:help 'clipboard'`
vim.o.clipboard = 'unnamedplus'

-- Enable break indent
vim.o.breakindent = true

-- Save undo history
vim.o.undofile = true
-- Remember last cursor position
vim.api.nvim_create_autocmd("BufReadPost", {
  pattern = "*",
  callback = function()
    local last_pos = vim.fn.line("'\"")
    if last_pos > 0 and last_pos <= vim.fn.line("$") then
      vim.cmd("normal! g`\"")
    end
  end,
})

-- Case-insensitive searching UNLESS \C or capital in search
vim.opt.ignorecase = true
vim.opt.smartcase = true

vim.opt.shiftwidth = 4
vim.opt.tabstop = 4
vim.opt.expandtab = true
vim.opt.smartindent = true
vim.opt.scrolloff = 4

-- Disable word wrap
vim.o.wrap = false

-- Disable jumping into warnings
vim.cmd [[set errorformat^=%-G%f:%l:\ warning:\ %m]]

-- functions keys
--map <F1> :set number!<CR> :set relativenumber!<CR>
vim.api.nvim_set_keymap('n', '<F1>', ':set number!<CR>:set relativenumber!<CR>', {noremap = true, silent = true})
--set pastetoggle=<F3>
--map <F5> :set cursorline!<CR>

vim.api.nvim_set_keymap('n', '<leader>z', ':ZenMode<CR>', {noremap = true, silent = true})

-- Quickfix
function is_quickfix_open()
  local windows = vim.api.nvim_list_wins()
  for _, win in ipairs(windows) do
    local buf = vim.api.nvim_win_get_buf(win)
    local buftype = vim.api.nvim_buf_get_option(buf, 'buftype')
    if buftype == 'quickfix' then
      return true
    end
  end
  return false
end

function _G.toggle_quickfix()

    if is_quickfix_open() then
        vim.cmd('cclose')
    else
        vim.cmd('copen')
    end
end

--vim.keymap.set('n', '<leader>q', ':lua toggle_quickfix()<CR>', { desc = 'Open Quickfix' })
vim.api.nvim_set_keymap('n', '<leader>q', ':lua toggle_quickfix()<CR>', {noremap = true, silent = true, desc = 'Open Quickfix' })
vim.api.nvim_set_keymap('n', '<A-n>', ':cn<CR>', {noremap = true, silent = true})
vim.api.nvim_set_keymap('n', '<A-N>', ':cp<CR>', {noremap = true, silent = true})

-- Move lines
vim.api.nvim_set_keymap('v', 'J', ":m '>+1<CR>gv=gv", {noremap = true, silent = true})
vim.api.nvim_set_keymap('v', 'K', ":m '<-2<CR>gv=gv", {noremap = true, silent = true})

-- Build
if vim.fn.has('win32') == 1 then
    vim.api.nvim_set_keymap('n', '<A-b>', ':AsyncRun Build.bat<CR>', {noremap = true, silent = true})
    vim.api.nvim_set_keymap('n', '<A-t>', ':AsyncRun GenerateTags.bat<CR>', {noremap = true, silent = true})
else
    -- Linux version here:
    vim.api.nvim_set_keymap('n', '<A-b>', ':AsyncRun ./build.sh<CR>', {noremap = true, silent = true})
    vim.api.nvim_set_keymap('n', '<A-r>', ':AsyncRun ./run.sh<CR>',   {noremap = true, silent = true})
    vim.api.nvim_set_keymap('n', '<A-t>', ':AsyncRun ctags -R .<CR>', {noremap = true, silent = true})
end

-- Neovide
if vim.g.neovide ~= nil then
-- vim.opt.guifont = "Jetbrains Mono:h12"
function _G.toggle_fullscreen()
    local is_fullscreen = vim.api.nvim_eval('g:neovide_fullscreen')
    if is_fullscreen == true then
        vim.api.nvim_command('let g:neovide_fullscreen = v:false')
    else
        vim.api.nvim_command('let g:neovide_fullscreen = v:true')
    end
end

vim.api.nvim_set_keymap('n', '<F11>', ':lua toggle_fullscreen()<CR>', {noremap = true, silent = true})

vim.api.nvim_command('let g:neovide_scale_factor = 1.0')
vim.api.nvim_command('let g:neovide_cursor_vfx_mode = "pixiedust"')
end

-- Keep signcolumn on by default
vim.wo.signcolumn = 'no'

-- Decrease update time
vim.o.updatetime = 250
vim.o.timeoutlen = 300

-- Set completeopt to have a better completion experience
vim.o.completeopt = 'menuone,noselect'

-- NOTE: You should make sure your terminal supports this
vim.o.termguicolors = true

require("evergarden").setup({
  transparent_backgground = false,
  contrast_dark = 'hard',
  override_terminal = true,
  style = {
    tabline = { reverse = true, color = 'green' },
    search = { reverse = false, inc_reverse = true },
    types = { italic = false },
    keyword = { italic = false },
    comment = { italic = false },
  },
  overrides = {},
})
vim.cmd [[colorscheme evergarden]]

-- Font
-- vim.o.guifont = "Consolas:h14"
vim.o.guifont = "JetBrains Mono NL:h12"

-- [[ Basic Keymaps ]]

-- Keymaps for better default experience
-- See `:help vim.keymap.set()`
vim.keymap.set({ 'n', 'v' }, '<Space>', '<Nop>', { silent = true })

-- Remap for dealing with word wrap
vim.keymap.set('n', 'k', "v:count == 0 ? 'gk' : 'k'", { expr = true, silent = true })
vim.keymap.set('n', 'j', "v:count == 0 ? 'gj' : 'j'", { expr = true, silent = true })

-- Diagnostic settings
vim.diagnostic.config({signs = false})

-- Diagnostic keymaps
vim.keymap.set('n', '[d', vim.diagnostic.goto_prev, { desc = 'Go to previous diagnostic message' })
vim.keymap.set('n', ']d', vim.diagnostic.goto_next, { desc = 'Go to next diagnostic message' })
vim.keymap.set('n', '<leader>e', vim.diagnostic.open_float, { desc = 'Open floating diagnostic message' })
--vim.keymap.set('n', '<leader>q', vim.diagnostic.setloclist, { desc = 'Open diagnostics list' })

-- [[ Highlight on yank ]]
-- See `:help vim.highlight.on_yank()`
local highlight_group = vim.api.nvim_create_augroup('YankHighlight', { clear = true })
vim.api.nvim_create_autocmd('TextYankPost', {
  callback = function()
    vim.highlight.on_yank()
  end,
  group = highlight_group,
  pattern = '*',
})

-- Highlight search hits (Clear with ctrl+L)
vim.o.hlsearch = true
vim.o.incsearch = true
vim.o.linebreak = true

vim.api.nvim_set_keymap('n', '<C-L>', ':nohl<CR><C-L>', {noremap = true, silent = true})

-- [[ Configure Telescope ]]
-- See `:help telescope` and `:help telescope.setup()`
require('telescope').setup {
  defaults = {
    mappings = {
      i = {
        ['<C-u>'] = false,
        ['<C-d>'] = false,
      },
    },
  },
  pickers = {
    colorscheme = {
      enable_preview = true,
    },
  },
}

require 'telescope'.load_extension "egrepify"

-- Enable telescope fzf native, if installed
pcall(require('telescope').load_extension, 'fzf')

-- Telescope live_grep in git root
-- Function to find the git root directory based on the current buffer's path
local function find_git_root()
  -- Use the current buffer's path as the starting point for the git search
  local current_file = vim.api.nvim_buf_get_name(0)
  local current_dir
  local cwd = vim.fn.getcwd()
  -- If the buffer is not associated with a file, return nil
  if current_file == '' then
    current_dir = cwd
  else
    -- Extract the directory from the current file's path
    current_dir = vim.fn.fnamemodify(current_file, ':h')
  end

  -- Find the Git root directory from the current file's path
  local git_root = vim.fn.systemlist('git -C ' .. vim.fn.escape(current_dir, ' ') .. ' rev-parse --show-toplevel')[1]
  if vim.v.shell_error ~= 0 then
    print 'Not a git repository. Searching on current working directory'
    return cwd
  end
  return git_root
end

-- Custom live_grep function to search in git root
local function live_grep_git_root()
  local git_root = find_git_root()
  if git_root then
    require('telescope.builtin').live_grep {
      search_dirs = { git_root },
    }
  end
end

vim.api.nvim_create_user_command('LiveGrepGitRoot', live_grep_git_root, {})

-- See `:help telescope.builtin`
vim.keymap.set('n', '<leader>?', require('telescope.builtin').oldfiles, { desc = '[?] Find recently opened files' })
vim.keymap.set('n', '<leader><space>', require('telescope.builtin').buffers, { desc = '[ ] Find existing buffers' })
vim.keymap.set('n', '<leader>/', function()
  -- You can pass additional configuration to telescope to change theme, layout, etc.
  require('telescope.builtin').current_buffer_fuzzy_find(require('telescope.themes').get_dropdown {
    winblend = 10,
    previewer = false,
  })
end, { desc = '[/] Fuzzily search in current buffer' })

local function telescope_live_grep_open_files()
  require('telescope.builtin').live_grep {
    grep_open_files = true,
    prompt_title = 'Live Grep in Open Files',
  }
end

local buildin = require("telescope.builtin")
vim.keymap.set('n', '<leader>s/', telescope_live_grep_open_files, { desc = '[S]earch [/] in Open Files' })
vim.keymap.set('n', '<leader>ss', buildin.builtin, { desc = '[S]earch [S]elect Telescope' })
vim.keymap.set('n', '<leader>gf', buildin.git_files, { desc = 'Search [G]it [F]iles' })
vim.keymap.set('n', '<leader>sf', buildin.find_files, { desc = '[S]earch [F]iles' })
vim.keymap.set('n', '<leader>sh', buildin.help_tags, { desc = '[S]earch [H]elp' })
vim.keymap.set('n', '<leader>sk', buildin.keymaps, { desc = '[S]earch [K]eymaps' })
vim.keymap.set('n', '<leader>st', buildin.tags, { desc = '[S]earch [T]ag' })
vim.keymap.set('n', '<leader>sw', buildin.grep_string, { desc = '[S]earch current [W]ord' })
vim.keymap.set('n', '<leader>sg', buildin.live_grep, { desc = '[S]earch by [G]rep' })
vim.keymap.set('n', '<leader>sG', ':LiveGrepGitRoot<cr>', { desc = '[S]earch by [G]rep on Git Root' })
vim.keymap.set('n', '<leader>sd', buildin.diagnostics, { desc = '[S]earch [D]iagnostics' })
vim.keymap.set('n', '<leader>sr', buildin.resume, { desc = '[S]earch [R]esume' })

-- [[ Configure Treesitter ]]
-- See `:help nvim-treesitter`
-- Defer Treesitter setup after first render to improve startup time of 'nvim {filename}'
vim.defer_fn(function()
  require('nvim-treesitter.configs').setup {
    -- Add languages to be installed here that you want installed for treesitter
    ensure_installed = { 'c', 'cpp', 'go', 'lua', 'python', 'rust', 'tsx', 'javascript', 'typescript', 'vimdoc', 'vim', 'bash' },

    -- Autoinstall languages that are not installed. Defaults to false (but you can change for yourself!)
    auto_install = false,
    -- Install languages synchronously (only applied to `ensure_installed`)
    sync_install = false,
    -- List of parsers to ignore installing
    ignore_install = {},
    -- You can specify additional Treesitter modules here: -- For example: -- playground = {--enable = true,-- },
    modules = {},
    highlight = { enable = true },
    --indent = { enable = true },
    indent = { disable = 'cpp' },
    incremental_selection = {
      enable = true,
      keymaps = {
        init_selection = '<c-space>',
        node_incremental = '<c-space>',
        scope_incremental = '<c-s>',
        node_decremental = '<M-space>',
      },
    },
    textobjects = {
      select = {
        enable = true,
        lookahead = true, -- Automatically jump forward to textobj, similar to targets.vim
        keymaps = {
          -- You can use the capture groups defined in textobjects.scm
          ['aa'] = '@parameter.outer',
          ['ia'] = '@parameter.inner',
          ['af'] = '@function.outer',
          ['if'] = '@function.inner',
          ['ac'] = '@class.outer',
          ['ic'] = '@class.inner',
        },
      },
      move = {
        enable = true,
        set_jumps = true, -- whether to set jumps in the jumplist
        goto_next_start = {
          [']m'] = '@function.outer',
          [']]'] = '@class.outer',
        },
        goto_next_end = {
          [']M'] = '@function.outer',
          [']['] = '@class.outer',
        },
        goto_previous_start = {
          ['[m'] = '@function.outer',
          ['[['] = '@class.outer',
        },
        goto_previous_end = {
          ['[M'] = '@function.outer',
          ['[]'] = '@class.outer',
        },
      },
      swap = {
        enable = true,
        swap_next = {
          ['<leader>a'] = '@parameter.inner',
        },
        swap_previous = {
          ['<leader>A'] = '@parameter.inner',
        },
      },
    },
  }
end, 0)

-- [[ Configure LSP ]]
--  This function gets run when an LSP connects to a particular buffer.
local on_attach = function(_, bufnr)
  -- NOTE: Remember that lua is a real programming language, and as such it is possible
  -- to define small helper and utility functions so you don't have to repeat yourself
  -- many times.
  --
  -- In this case, we create a function that lets us more easily define mappings specific
  -- for LSP related items. It sets the mode, buffer and description for us each time.
  local nmap = function(keys, func, desc)
    if desc then
      desc = 'LSP: ' .. desc
    end

    --vim.keymap.set('n', keys, func, { buffer = bufnr, desc = desc })
    vim.keymap.set('n', keys, func, { desc = desc })
  end

  nmap('<leader>rn', vim.lsp.buf.rename, '[R]e[n]ame')
  nmap('<leader>ca', vim.lsp.buf.code_action, '[C]ode [A]ction')
  vim.api.nvim_set_keymap('n', '<M-f>', '<cmd>ClangdSwitchSourceHeader<CR>', {noremap = true, silent = true})

  nmap('gd', require('telescope.builtin').lsp_definitions, '[G]oto [D]efinition')
  nmap('gr', require('telescope.builtin').lsp_references, '[G]oto [R]eferences')
  nmap('gI', require('telescope.builtin').lsp_implementations, '[G]oto [I]mplementation')
  nmap('<leader>D', require('telescope.builtin').lsp_type_definitions, 'Type [D]efinition')
  nmap('<leader>ds', require('telescope.builtin').lsp_document_symbols, '[D]ocument [S]ymbols')
  nmap('<leader>ws', require('telescope.builtin').lsp_dynamic_workspace_symbols, '[W]orkspace [S]ymbols')

  -- See `:help K` for why this keymap
  nmap('K', vim.lsp.buf.hover, 'Hover Documentation')
  nmap('<C-k>', vim.lsp.buf.signature_help, 'Signature Documentation')

  -- Lesser used LSP functionality
  nmap('gD', vim.lsp.buf.declaration, '[G]oto [D]eclaration')
  nmap('<leader>wa', vim.lsp.buf.add_workspace_folder, '[W]orkspace [A]dd Folder')
  nmap('<leader>wr', vim.lsp.buf.remove_workspace_folder, '[W]orkspace [R]emove Folder')
  nmap('<leader>wl', function()
    print(vim.inspect(vim.lsp.buf.list_workspace_folders()))
  end, '[W]orkspace [L]ist Folders')

  -- Create a command `:Format` local to the LSP buffer
  vim.api.nvim_buf_create_user_command(bufnr, 'Format', function(_)
    vim.lsp.buf.format()
  end, { desc = 'Format current buffer with LSP' })
end

-- mason-lspconfig requires that these setup functions are called in this order
-- before setting up the servers.
require('mason').setup()
require('mason-lspconfig').setup()

-- Enable the following language servers
--  Feel free to add/remove any LSPs that you want here. They will automatically be installed.
--
--  Add any additional override configuration in the following tables. They will be passed to
--  the `settings` field of the server config. You must look up that documentation yourself.
--
--  If you want to override the default filetypes that your language server will attach to you can
--  define the property 'filetypes' to the map in question.
local servers = {
  clangd = {},
  -- gopls = {},
  -- pyright = {},
  -- rust_analyzer = {},
  -- tsserver = {},
  -- html = { filetypes = { 'html', 'twig', 'hbs'} },

  lua_ls = {
    Lua = {
      workspace = { checkThirdParty = false },
      telemetry = { enable = false },
      -- NOTE: toggle below to ignore Lua_LS's noisy `missing-fields` warnings
      diagnostics = { disable = { 'missing-fields' } },
    },
  },
}

-- nvim-cmp supports additional completion capabilities, so broadcast that to servers
local capabilities = vim.lsp.protocol.make_client_capabilities()
capabilities = require('cmp_nvim_lsp').default_capabilities(capabilities)

-- Ensure the servers above are installed
local mason_lspconfig = require 'mason-lspconfig'

mason_lspconfig.setup {
  ensure_installed = vim.tbl_keys(servers),
}

mason_lspconfig.setup_handlers {
  function(server_name)
    require('lspconfig')[server_name].setup {
      capabilities = capabilities,
      on_attach = on_attach,
      settings = servers[server_name],
      filetypes = (servers[server_name] or {}).filetypes,
    }
  end,
}

local lspconfig = require('lspconfig')
lspconfig.ols.setup({});

lspconfig.clangd.setup{
  on_attach = on_attach,
  capabilities = capabilities,
  cmd = {
    "clangd",
    "--all-scopes-completion",
    "--background-index",
    "--clang-tidy",
    "--completion-parse=always",
    -- "--completion-style=detailed",
    "--completion-style=bundled",
    "--cross-file-rename",
    "--enable-config",
    "--function-arg-placeholders",
    "--header-insertion=never",
    "-j=4",
  },
    diagnostics = {
        underline = true,
        update_in_insert = true,
        virtual_text = {
            spacing = 4,
            source = "if_many",
            -- prefix = "●",
            -- this will set set the prefix to a function that returns the diagnostics icon based on the severity
            -- this only works on a recent 0.10.0 build. Will be set to "●" when not supported
            prefix = "icons",
        },
    },
    opts = {
        inlay_hints = { enabled = true },
    },
}
-- [[ Configure nvim-cmp ]]
-- See `:help cmp`
local cmp = require 'cmp'
local luasnip = require 'luasnip'
require('luasnip.loaders.from_vscode').lazy_load()
luasnip.config.setup {}

cmp.setup {
  snippet = {
    expand = function(args)
      luasnip.lsp_expand(args.body)
    end,
  },
  completion = {
    completeopt = 'menu,menuone,noinsert',
  },
  mapping = cmp.mapping.preset.insert {
    ['<C-n>'] = cmp.mapping.select_next_item(),
    ['<C-p>'] = cmp.mapping.select_prev_item(),
    ['<C-b>'] = cmp.mapping.scroll_docs(-4),
    ['<C-f>'] = cmp.mapping.scroll_docs(4),
    ['<C-Space>'] = cmp.mapping.complete {},
    ['<CR>'] = cmp.mapping.confirm {
      -- behavior = cmp.ConfirmBehavior.Replace,
      behavior = cmp.ConfirmBehavior.Insert,
      select = true,
    },
    ['<Tab>'] = cmp.mapping(function(fallback)
      if cmp.visible() then
        cmp.select_next_item()
      elseif luasnip.expand_or_locally_jumpable() then
        luasnip.expand_or_jump()
      else
        fallback()
      end
    end, { 'i', 's' }),
    ['<S-Tab>'] = cmp.mapping(function(fallback)
      if cmp.visible() then
        cmp.select_prev_item()
      elseif luasnip.locally_jumpable(-1) then
        luasnip.jump(-1)
      else
        fallback()
      end
    end, { 'i', 's' }),
  },
  sources = {
    { name = 'nvim_lsp' },
    { name = 'supermaven' },
    { name = 'luasnip' },
    { name = 'path' },
    { name = 'buffer' },
  },

  vim.api.nvim_set_hl(0, 'CmpItemKindSupermaven', { fg = "#44bdff" })
}

-- The line beneath this is called `modeline`. See `:help modeline`
-- vim: ts=2 sts=2 sw=2 et
