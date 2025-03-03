return {
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
}
