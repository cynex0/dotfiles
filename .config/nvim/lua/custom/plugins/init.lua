-- You can add your own plugins here or in other files in this directory!
--  I promise not to create any merge conflicts in this directory :)
--
-- See the kickstart.nvim README for more information
return {
  {
    'ThePrimeagen/harpoon',
    branch = 'harpoon2',
    dependencies = { 'nvim-lua/plenary.nvim', 'nvim-telescope/telescope.nvim' },
    config = function()
      local harpoon = require 'harpoon'
      harpoon:setup()
      local conf = require('telescope.config').values
      local function toggle_telescope(harpoon_files)
        local finder = function()
          local paths = {}
          for _, item in ipairs(harpoon_files.items) do
            table.insert(paths, item.value)
          end

          return require('telescope.finders').new_table {
            results = paths,
          }
        end

        local file_paths = {}
        for _, item in ipairs(harpoon_files.items) do
          table.insert(file_paths, item.value)
        end

        require('telescope.pickers')
          .new({}, {
            prompt_title = 'Harpoon',
            finder = require('telescope.finders').new_table {
              results = file_paths,
            },
            previewer = conf.file_previewer {},
            sorter = conf.generic_sorter {},
            attach_mappings = function(prompt_bufnr, map)
              map('i', '<C-d>', function()
                local state = require 'telescope.actions.state'
                local selected_entry = state.get_selected_entry()
                local current_picker = state.get_current_picker(prompt_bufnr)

                table.remove(harpoon_files.items, selected_entry.index)
                current_picker:refresh(finder())
              end)
              return true
            end,
          })
          :find()
      end

      vim.keymap.set('n', '<leader>hh', function()
        toggle_telescope(harpoon:list())
        -- harpoon.ui:toggle_quick_menu(harpoon:list())
      end, { desc = 'Open harpoon list' })

      vim.keymap.set('n', '<leader>ha', function()
        harpoon:list():add()
      end, { desc = 'Add to Harpoon' })

      vim.keymap.set('n', '<leader>h1', function()
        harpoon:list():select(1)
      end, { desc = 'Harpoon: File 1' })
      vim.keymap.set('n', '<leader>h2', function()
        harpoon:list():select(2)
      end, { desc = 'Harpoon: File 2' })
      vim.keymap.set('n', '<leader>h3', function()
        harpoon:list():select(3)
      end, { desc = 'Harpoon: File 3' })
      vim.keymap.set('n', '<leader>h4', function()
        harpoon:list():select(4)
      end, { desc = 'Harpoon: File 4' })

      -- Toggle previous & next buffers stored within Harpoon list
      vim.keymap.set('n', '<leader>hp', function()
        harpoon:list():prev()
      end, { desc = 'Harpoon: [P]revious file' })
      vim.keymap.set('n', '<leader>hn', function()
        harpoon:list():next()
      end, { desc = 'Harpoon: [N]ext file' })
    end,
  },
  {
    'jasonpanosso/harpoon-tabline.nvim',
    requires = { { 'ThePrimeagen/harpoon' } },
    config = function()
      require('harpoon-tabline').setup()
    end,
  },
  {
    'tpope/vim-fugitive',
    key = { '<leader>gs' },
    cmd = { 'G', 'Git', 'Gdiffsplit', 'Gread', 'Gwrite', 'Ggrep', 'GMove', 'GDelete', 'GBrowse', 'GRemove', 'GRename', 'Glgrep', 'Gedit' },
    keys = {
      {
        '<leader>gg',
        function()
          vim.cmd 'G'
        end,
        desc = '[G]it status',
      },
      {
        '<leader>gc',
        function()
          vim.cmd 'Git commit'
        end,
        desc = '[G]it [c]ommit',
      },
      {
        '<leader>gA',
        function()
          vim.cmd 'Git add .'
        end,
        desc = '[G]it [a]dd all',
      },
      {
        '<leader>ga',
        function()
          vim.cmd 'Git add %'
        end,
        desc = '[G]it [a]dd current',
      },
      {
        '<leader>gl',
        function()
          vim.cmd 'Git log --pretty=format:"%h - %d %s (%cr) <%an>" --oneline --graph'
        end,
        desc = '[G]it [l]og',
      },
      {
        '<leader>gs',
        function()
          vim.cmd 'Git pull'
          vim.cmd 'Git push'
        end,
        desc = '[G]it [s]sync (pull&push)',
      },
      {
        '<leader>gps',
        function()
          vim.cmd 'Git push'
        end,
        desc = '[G]it [p]u[s]h',
      },
      {
        '<leader>gpl',
        function()
          vim.cmd 'Git pull'
        end,
        desc = '[G]it [p]u[l]l',
      },
    },
  },
  -- {
  --   'wfxr/minimap.vim',
  --   build = 'cargo install --locked code-minimap',
  --   lazy = false,
  --   cmd = { 'Minimap', 'MinimapClose', 'MinimapToggle', 'MinimapRefresh', 'MinimapUpdateHighlight' },
  --   init = function()
  --     vim.cmd 'let g:minimap_width = 10'
  --     vim.cmd 'let g:minimap_auto_start = 1'
  --     vim.cmd 'let g:minimap_auto_start_win_enter = 1'
  --   end,
  -- },
  {
    'ghillb/llama.vim',

    init = function()
      vim.g.llama_config = {
        endpoint = 'http://localhost:8000/infill',
        show_info = 0,
      }

      -- Check if the container is running
      -- local handle = io.popen "docker ps --filter 'name=ze-llm' --format '{{.ID}}'"
      -- if handle == nil then
      --   vim.notify('Skill issue', vim.log.levels.ERROR)
      --   vim.g.llm_enabled = false
      --   return
      -- end
      --
      -- local result = handle:read '*a'
      -- handle:close()
      -- if result == '' then
      --   vim.notify('Starting ze LLMs', vim.log.levels.INFO)
      --   local job_id = vim.fn.jobstart('docker start ze-llm', {
      --     detach = true,
      --     on_exit = function(_, code)
      --       if code == 0 then
      --         vim.notify('Ze LLMs are online', vim.log.levels.INFO)
      --         vim.g.llm_enabled = true
      --       else
      --         vim.notify('Ze LLMs failed to start', vim.log.levels.ERROR)
      --         vim.g.llm_enabled = false
      --       end
      --     end,
      --   })
      -- else
      --   vim.notify('Ze LLMs are online', vim.log.levels.INFO)
      --   vim.g.llm_enabled = true
      -- end
      --
      -- -- Stop the container when Neovim exits
      -- vim.api.nvim_create_autocmd('VimLeavePre', {
      --   callback = function()
      --     vim.notify('Stopping ze LLMs', vim.log.levels.INFO)
      --     vim.fn.jobstart('docker stop ze-llm', {
      --       detach = true,
      --     })
      --   end,
      -- })
    end,

    keys = {
      {
        '<leader>cl',
        function()
          vim.g.llm_enabled = not vim.g.llm_enabled
          print((vim.g.llm_enabled and 'Enabled' or 'Disabled') .. ' ze LLMs')
          if vim.g.llm_enabled then
            vim.cmd 'LlamaEnable'
          else
            vim.cmd 'LlamaDisable'
          end
        end,
        desc = 'Toggle Ze [L]LMs',
      },
    },
  },
  -- {
  --   'Exafunction/codeium.nvim',
  --   dependencies = {
  --     'nvim-lua/plenary.nvim',
  --     'hrsh7th/nvim-cmp',
  --   },
  --   config = function()
  --     local codeium = require 'codeium'
  --     local cfg = {
  --       enable_chat = false,
  --       enable_cmp_source = false,
  --       virtual_text = {
  --         enabled = true,
  --         idle_delay = 100,
  --         key_bindings = {
  --           accept = '<M-j>',
  --           accept_word = false,
  --           accept_line = '<M-J>',
  --           next = '<M-]>',
  --           prev = '<M-[>',
  --         },
  --       },
  --     }
  --     codeium.setup(cfg)
  --
  --     vim.g.codeium_enabled = true
  --     vim.keymap.set('n', '<leader>cl', function()
  --       vim.g.codeium_enabled = not vim.g.codeium_enabled
  --       cfg.virtual_text.enabled = vim.g.codeium_enabled
  --       codeium.setup(cfg)
  --       print('Codeium ' .. (vim.g.codeium_enabled and 'Enabled' or 'Disabled'))
  --     end, { desc = 'Toggle Ze [L]LMs' })
  --   end,
  -- },
  {
    'declancm/cinnamon.nvim',
    version = '*', -- use latest release
    config = function()
      local cinnamon = require 'cinnamon'
      cinnamon.setup {
        disabled = false,
        keymaps = {
          -- Enable the provided 'basic' keymaps
          basic = true,
          -- Enable the provided 'extra' keymaps
          extra = false,
        },
        options = {
          max_delta = {
            time = 100,
          },
          delay = 4,
        },
      }

      vim.keymap.set('n', '<C-U>', function()
        cinnamon.scroll '<C-U>zz'
      end)
      vim.keymap.set('n', '<C-D>', function()
        cinnamon.scroll '<C-D>zz'
      end)

      -- LSP:
      vim.keymap.set('n', 'gd', function()
        cinnamon.scroll(vim.lsp.buf.definition)
      end)
      vim.keymap.set('n', 'gD', function()
        cinnamon.scroll(vim.lsp.buf.declaration)
      end)
    end,
  },
}
