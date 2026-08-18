local function get_nvim_count()
  local nvim_count = vim.fn.system 'pgrep -c nvim'
  return tonumber(nvim_count)
end

local function start_container_job()
  vim.fn.jobstart('docker start ze-llm', {
    detach = true,
    on_exit = function(_, code)
      if code == 0 then
        vim.notify('Ze LLMs are online', vim.log.levels.INFO)
        vim.g.llm_ready = true
      else
        vim.notify('Ze LLMs failed to start', vim.log.levels.ERROR)
      end
    end,
  })
end

local function start_container()
  -- Check if the container is running
  vim.fn.jobstart("docker ps --filter 'name=ze-llm' --format '{{.ID}}'", {
    on_stdout = function(_, result)
      if result == '' then -- if container is not running
        vim.schedule(start_container_job)
      else
        vim.notify('Ze LLMs are online', vim.log.levels.INFO)
        vim.g.llm_ready = true
      end
    end,
    on_stderr = function(_, err)
      if not err == '' then
        vim.notify('Skill issue: ' .. vim.inspect(err), vim.log.levels.ERROR)
      else
        vim.schedule(start_container_job)
      end
    end,
  })
end

local function stop_container()
  local nvim_count = get_nvim_count()
  if nvim_count <= 2 then -- if this was the last nvim instance
    vim.fn.jobstart('docker stop ze-llm', { detach = true })
  end
end

return {
  'ghillb/llama.vim',

  init = function()
    vim.g.llama_config = {
      endpoint = 'http://localhost:8000/infill',
      show_info = 1,
      keymap_accept_full = '<M-j>',
      keymap_accept_line = '<M-J>',
      keymap_accept_word = '<M-l>',
    }

    vim.g.llm_ready = false
    vim.g.llm_enabled = false

    vim.schedule(function()
      vim.notify('Starting ze LLMs', vim.log.levels.INFO)
      start_container()
    end)

    -- Attach callback to stop the container when Neovim exits
    vim.api.nvim_create_autocmd('VimLeavePre', {
      callback = stop_container,
    })
  end,

  keys = {
    {
      '<leader>cl',
      function()
        if not vim.g.llm_ready then
          print 'Ze LLMs are not ready, sire'
          if vim.g.llm_enabled then
            vim.g.llm_enabled = false
            vim.cmd 'LlamaDisable'
          end
          return
        end

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
