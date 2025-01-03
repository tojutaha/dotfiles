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

  -- Git related plugins
  'tpope/vim-fugitive',
  'tpope/vim-rhubarb',

  -- 
  'duane9/nvim-rg',
  'skywind3000/asyncrun.vim',
  'junegunn/fzf.vim',
  'zackhsi/fzf-tags',
  'ervandew/supertab',
  'vim-scripts/TagHighlight',
  'dhananjaylatkar/cscope_maps.nvim',
  'hari-rangarajan/CCTree',
  'mg979/vim-visual-multi',
  'voldikss/vim-floaterm',
  'folke/zen-mode.nvim',
  'junegunn/vim-easy-align',
  'preservim/nerdtree',
  'ryanoasis/vim-devicons',
  -- Bionic reading
  -- 'FluxxField/bionic-reading.nvim',
  -- 'JellyApple102/easyread.nvim',
  -- 'HampusHauffman/bionic.nvim',

  -- Detect tabstop and shiftwidth automatically
  --'tpope/vim-sleuth',

  -- NOTE: This is where your plugins related to LSP can be installed.
  --  The configuration is done below. Search for lspconfig to find it below.
  {
    -- LSP Configuration & Plugins
    'neovim/nvim-lspconfig',
    dependencies = {
      -- Automatically install LSPs to stdpath for neovim
      { 'williamboman/mason.nvim', config = true },
      'williamboman/mason-lspconfig.nvim',

      -- Useful status updates for LSP
      -- NOTE: `opts = {}` is the same as calling `require('fidget').setup({})`
      { 'j-hui/fidget.nvim', opts = {} },

      -- Additional lua configuration, makes nvim stuff amazing!
      'folke/neodev.nvim',
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
      'rafamadriz/friendly-snippets',
    },
  },

  -- Useful plugin to show you pending keybinds.
  { 'folke/which-key.nvim', opts = {} },
  -- {
  --   -- Adds git related signs to the gutter, as well as utilities for managing changes
  --   'lewis6991/gitsigns.nvim',
  --   opts = {
  --     -- See `:help gitsigns.txt`
  --     signs = {
  --       add = { text = '+' },
  --       change = { text = '~' },
  --       delete = { text = '_' },
  --       topdelete = { text = '‾' },
  --       changedelete = { text = '~' },
  --     },
  --     on_attach = function(bufnr)
  --       local gs = package.loaded.gitsigns
  --
  --       local function map(mode, l, r, opts)
  --         opts = opts or {}
  --         opts.buffer = bufnr
  --         vim.keymap.set(mode, l, r, opts)
  --       end
  --
  --       -- Navigation
  --       map({ 'n', 'v' }, ']c', function()
  --         if vim.wo.diff then
  --           return ']c'
  --         end
  --         vim.schedule(function()
  --           gs.next_hunk()
  --         end)
  --         return '<Ignore>'
  --       end, { expr = true, desc = 'Jump to next hunk' })
  --
  --       map({ 'n', 'v' }, '[c', function()
  --         if vim.wo.diff then
  --           return '[c'
  --         end
  --         vim.schedule(function()
  --           gs.prev_hunk()
  --         end)
  --         return '<Ignore>'
  --       end, { expr = true, desc = 'Jump to previous hunk' })
  --
  --       -- Actions
  --       -- visual mode
  --       map('v', '<leader>hs', function()
  --         gs.stage_hunk { vim.fn.line '.', vim.fn.line 'v' }
  --       end, { desc = 'stage git hunk' })
  --       map('v', '<leader>hr', function()
  --         gs.reset_hunk { vim.fn.line '.', vim.fn.line 'v' }
  --       end, { desc = 'reset git hunk' })
  --       -- normal mode
  --       map('n', '<leader>hs', gs.stage_hunk, { desc = 'git stage hunk' })
  --       map('n', '<leader>hr', gs.reset_hunk, { desc = 'git reset hunk' })
  --       map('n', '<leader>hS', gs.stage_buffer, { desc = 'git Stage buffer' })
  --       map('n', '<leader>hu', gs.undo_stage_hunk, { desc = 'undo stage hunk' })
  --       map('n', '<leader>hR', gs.reset_buffer, { desc = 'git Reset buffer' })
  --       map('n', '<leader>hp', gs.preview_hunk, { desc = 'preview git hunk' })
  --       map('n', '<leader>hb', function()
  --         gs.blame_line { full = false }
  --       end, { desc = 'git blame line' })
  --       map('n', '<leader>hd', gs.diffthis, { desc = 'git diff against index' })
  --       map('n', '<leader>hD', function()
  --         gs.diffthis '~'
  --       end, { desc = 'git diff against last commit' })
  --
  --       -- Toggles
  --       map('n', '<leader>tb', gs.toggle_current_line_blame, { desc = 'toggle git blame line' })
  --       map('n', '<leader>td', gs.toggle_deleted, { desc = 'toggle git show deleted' })
  --
  --       -- Text object
  --       map({ 'o', 'x' }, 'ih', ':<C-U>Gitsigns select_hunk<CR>', { desc = 'select git hunk' })
  --     end,
  --   },
  -- },

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

  -- {
  --   -- Add indentation guides even on blank lines
  --   'lukas-reineke/indent-blankline.nvim',
  --   -- Enable `lukas-reineke/indent-blankline.nvim`
  --   -- See `:help ibl`
  --   main = 'ibl',
  --   opts = {},
  -- },

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
    },
  },

  {
    "fdschmidt93/telescope-egrepify.nvim",
  },

  { -- Scratch buffer
    "https://git.sr.ht/~swaits/scratch.nvim",
    lazy = true,
    keys = {
      { "<leader>bs", "<cmd>Scratch<cr>", desc = "Scratch Buffer", mode = "n" },
      { "<leader>bS", "<cmd>ScratchSplit<cr>", desc = "Scratch Buffer (split)", mode = "n" },
    },
    cmd = {
      "Scratch",
      "ScratchSplit",
    },
    opts = {},
  },

  {
    -- Highlight, edit, and navigate code
    'nvim-treesitter/nvim-treesitter',
    dependencies = {
      'nvim-treesitter/nvim-treesitter-textobjects',
    },
    build = ':TSUpdate',
  },

  -- DAP
  {
    "mfussenegger/nvim-dap",
    "theHamsta/nvim-dap-virtual-text",
    "rcarriga/nvim-dap-ui",
    "nvim-neotest/nvim-nio"
  },

  -- Themes
  {
    "rebelot/kanagawa.nvim",
    "savq/melange-nvim",
    "catppuccin/nvim",
    "folke/tokyonight.nvim",
    "xiyaowong/transparent.nvim",
    "ellisonleao/gruvbox.nvim",
    "wurli/cobalt.nvim",
    --priority = 100,
    --config = function()
      --vim.cmd([[colorscheme visual_studio_code]])
    --end
  },

  -- Godot
  {
    'habamax/vim-godot'
  }

  -- NOTE: Next Step on Your Neovim Journey: Add/Configure additional "plugins" for kickstart
  --       These are some example plugins that I've included in the kickstart repository.
  --       Uncomment any of the lines below to enable them.
  -- require 'kickstart.plugins.autoformat',
  -- require 'kickstart.plugins.debug',

  -- NOTE: The import below can automatically add your own plugins, configuration, etc from `lua/custom/plugins/*.lua`
  --    You can use this folder to prevent any conflicts with this init.lua if you're interested in keeping
  --    up-to-date with whatever is in the kickstart repo.
  --    Uncomment the following line and add your plugins to `lua/custom/plugins/*.lua` to get going.
  --
  --    For additional information see: https://github.com/folke/lazy.nvim#-structuring-your-plugins
  -- { import = 'custom.plugins' },
}, {})

vim.api.nvim_set_keymap('t', '<Esc>', '<C-\\><C-n>', { noremap = true, silent = true })
vim.api.nvim_set_keymap('n', '<leader>t', ':NERDTreeToggle<CR>', {noremap = true, silent = true})

-- replace word but keep the yank
local function replace_word_with_yank()
  -- Delete the word under the cursor without affecting the default register
  vim.cmd('normal! "_diw')
  -- Paste the yanked text
  vim.cmd('normal! viw"0p')
end

-- Godot
-- local gdproject = io.open(vim.fn.getcwd()..'/project.godot', 'r')
-- if gdproject then
--     io.close(gdproject)
--     vim.fn.serverstart './godothost'
-- end

vim.api.nvim_set_keymap('n', 'viwp', '', {
  noremap = true,
  silent = true,
  callback = replace_word_with_yank
})

-- DAP
local ok, dap = pcall(require, 'dap')
if ok then
  dap.adapters.gdb = {
    id = 'gdb',
    type = 'executable',
    command = 'gdb',
    args = { '--quiet', '--interpreter=dap' },
  }

  dap.configurations.c = {
    {
        name = 'Run executable (GDB)',
        type = 'gdb',
        request = 'launch',
        -- This requires special handling of 'run_last', see
        -- https://github.com/mfussenegger/nvim-dap/issues/1025#issuecomment-1695852355
        program = function()
            local path = vim.fn.input({
                prompt = 'Path to executable: ',
                default = vim.fn.getcwd() .. '/',
                completion = 'file',
            })

            return (path and path ~= '') and path or dap.ABORT
        end,
    },
    {
        name = 'Run executable with arguments (GDB)',
        type = 'gdb',
        request = 'launch',
        -- This requires special handling of 'run_last', see
        -- https://github.com/mfussenegger/nvim-dap/issues/1025#issuecomment-1695852355
        program = function()
            local path = vim.fn.input({
                prompt = 'Path to executable: ',
                default = vim.fn.getcwd() .. '/',
                completion = 'file',
            })

            return (path and path ~= '') and path or dap.ABORT
        end,
        args = function()
            local args_str = vim.fn.input({
                prompt = 'Arguments: ',
            })
            return vim.split(args_str, ' +')
        end,
    },
    {
        name = 'Attach to process (GDB)',
        type = 'gdb',
        request = 'attach',
        processId = require('dap.utils').pick_process,
    },
  }
  -- Copy pasta..
  dap.configurations.cpp = {
    {
        name = 'Run executable (GDB)',
        type = 'gdb',
        request = 'launch',
        -- This requires special handling of 'run_last', see
        -- https://github.com/mfussenegger/nvim-dap/issues/1025#issuecomment-1695852355
        program = function()
            local path = vim.fn.input({
                prompt = 'Path to executable: ',
                default = vim.fn.getcwd() .. '/',
                completion = 'file',
            })

            return (path and path ~= '') and path or dap.ABORT
        end,
    },
    {
        name = 'Run executable with arguments (GDB)',
        type = 'gdb',
        request = 'launch',
        -- This requires special handling of 'run_last', see
        -- https://github.com/mfussenegger/nvim-dap/issues/1025#issuecomment-1695852355
        program = function()
            local path = vim.fn.input({
                prompt = 'Path to executable: ',
                default = vim.fn.getcwd() .. '/',
                completion = 'file',
            })

            return (path and path ~= '') and path or dap.ABORT
        end,
        args = function()
            local args_str = vim.fn.input({
                prompt = 'Arguments: ',
            })
            return vim.split(args_str, ' +')
        end,
    },
    {
        name = 'Attach to process (GDB)',
        type = 'gdb',
        request = 'attach',
        processId = require('dap.utils').pick_process,
    },
  }
end

dap.adapters.godot = {
  type = 'server',
  host = '127.0.0.1',
  port = 6006,
}

dap.configurations.gdscript = {
  {
    name = 'Launch Scene',
    type = 'godot',
    request = 'launch',
    project = '${workspaceFolder}',
    launch_scene = true,
  },
}

vim.api.nvim_set_keymap("n", "<leader>du", ":lua require('dapui').toggle()<CR>", { noremap = true })
vim.api.nvim_set_keymap("n", "<leader>dd", ":DapNew<CR>", { noremap = true })
vim.api.nvim_set_keymap("n", "<leader>dt", ":DapTerminate<CR>", { noremap = true })
vim.api.nvim_set_keymap("n", "<leader>db", ":DapToggleBreakpoint<CR>", { noremap = true, silent = true })
vim.api.nvim_set_keymap("n", "<F8>", ":DapStepOver<CR>", { noremap = true, silent = true })
vim.api.nvim_set_keymap("n", "<F10>", ":DapStepInto<CR>", { noremap = true, silent = true })

require('dapui').setup()

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

-- vim.api.nvim_exec([[
--   highlight AnnotateColor guifg=#ff0000
--   augroup AnnotateScope
--     autocmd!
--     autocmd CursorMoved,CursorMovedI,InsertLeave * lua clear_virtual_text()
--     autocmd CursorHold,CursorHoldI,InsertEnter * lua annotate_scope()
--   augroup END
-- ]], false)

vim.api.nvim_set_keymap('n', '<F5>', ':lua toggle_annotate_scope()<CR>', {noremap = true})

vim.api.nvim_exec([[
  augroup AnnotateScope
    autocmd!
    autocmd CursorMoved * lua clear_virtual_text()
    autocmd CursorHold * lua annotate_scope()
  augroup END
]], false)
--

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
vim.wo.number = true
vim.wo.relativenumber = true

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

-- Enable cursorline
vim.opt.cursorline = true

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
vim.wo.signcolumn = 'yes'

-- Decrease update time
vim.o.updatetime = 250
vim.o.timeoutlen = 300

-- Set completeopt to have a better completion experience
vim.o.completeopt = 'menuone,noselect'

-- NOTE: You should make sure your terminal supports this
vim.o.termguicolors = true
require("gruvbox").setup({
  undercurl = true,
  underline = true,
  bold = true,
  italic = {
    strings = true,
    emphasis = true,
    comments = true,
    operators = false,
    folds = true,
  },
  strikethrough = true,
  invert_selection = false,
  invert_signs = false,
  invert_tabline = false,
  invert_intend_guides = false,
  inverse = true, -- invert background for search, diffs, statuslines and errors
  contrast = "hard", -- can be "hard", "soft" or empty string
  palette_overrides = {},
  overrides = {},
  dim_inactive = false,
  transparent_mode = false,
})

vim.o.background = "dark"
-- vim.cmd [[colorscheme gruvbox]]
vim.cmd [[colorscheme dracula]]
-- vim.cmd [[colorscheme PaperColor]]

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

-- Configure cscope_maps
require('cscope_maps').setup()

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
    ensure_installed = { 'gdscript', 'godot_resource', 'gdshader', 'c', 'cpp', 'go', 'lua', 'python', 'rust', 'tsx', 'javascript', 'typescript', 'vimdoc', 'vim', 'bash' },

    -- Autoinstall languages that are not installed. Defaults to false (but you can change for yourself!)
    auto_install = true,
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

-- document existing key chains
require('which-key').add {
    { "<leader>c", desc = "[C]ode" },
    { "<leader>d", desc = "[D]ocument" },
    { "<leader>r", desc = "[R]ename" },
    { "<leader>s", desc = "[S]earch" },
    { "<leader>w", desc = "[W]orkspace" },
    { "<leader>t", desc = "[T]oggle" },
    { "<leader>h", desc = "Git [H]unk", mode = { "n", "v" } },
}

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
      -- diagnostics = { disable = { 'missing-fields' } },
    },
  },
}

-- Setup neovim lua configuration
require('neodev').setup()

-- nvim-cmp supports additional completion capabilities, so broadcast that to servers
local capabilities = vim.lsp.protocol.make_client_capabilities()
capabilities = require('cmp_nvim_lsp').default_capabilities(capabilities)
require('lspconfig').gdscript.setup(capabilities)

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
      disabled = true,
    }
  end,
}

local lspconfig = require('lspconfig')
lspconfig.ols.setup({});

lspconfig.clangd.setup{
  cmd = {
    "clangd",
    "--background-index",
    "--clang-tidy",
    "--completion-style=detailed",
    "--function-arg-placeholders",
    "--header-insertion=never",
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
      behavior = cmp.ConfirmBehavior.Replace,
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
    { name = 'luasnip' },
    { name = 'path' },
  },
}

-- The line beneath this is called `modeline`. See `:help modeline`
-- vim: ts=2 sts=2 sw=2 et
