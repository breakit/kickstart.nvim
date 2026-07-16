
-- /home/yk/.config/nvim/lua/custom/plugins/server_keymaps.lua
local M = {}
local server_job_id = nil
local active_url = nil -- Stores the precise IP/port link for Chrome

-- Helper function to fetch the raw Linux bridge IP inside WSL
local function get_wsl_ip()
  -- Runs a shell pipeline to extract the WSL machine's local eth0 address
  local handle = io.popen("ip route show | grep eth0 | awk '{print $9}'")
  if not handle then return "localhost" end
  local result = handle:read("*a")
  handle:close()
  -- Clean up trailing newlines
  result = result:gsub("%s+", "")
  return (result == "" or not result) and "localhost" or result
end

-- Helper function that mini.statusline calls to see if a server is active
function M.get_status()
  if server_job_id and active_url then
    return "    " .. active_url -- Visual anchor badge for your bar
  end
  return "" -- Invisible when the server is off
end

function M.setup()
  -- KEYMAP: Start the Python Live Reload Server with interface binding
  vim.keymap.set('n', '<leader>ls', function()
    if server_job_id then
      print("Server is already running!")
      return
    end

    -- Prompt user for a port number dynamically
    vim.ui.input({ prompt = 'Enter port number (default: 8004): ' }, function(input)
      local port = (input == nil or input == "") and "8004" or input
      
      -- 1. Grab your Linux network interface IP address
      local ip_addr = get_wsl_ip()
      active_url = ip_addr .. ":" .. port

      -- 2. Launch reloadserver binding to 0.0.0.0 (All interfaces)
      -- NOTE: If using Method 1 (.venv), replace 'reloadserver' with './.venv/bin/reloadserver'
      server_job_id = vim.fn.jobstart({ 'reloadserver', '-b', '0.0.0.0', port }, {
        on_exit = function() 
          server_job_id = nil 
          active_url = nil
        end
      })
      
      -- 3. Print the absolute clickable link directly to your console
      print("Live Reload server started! Open in Windows Chrome: http://" .. active_url)
    end)
  end, { desc = 'Start Python Live Reload Server' })

  -- KEYMAP: Stop the Live Reload Python Server safely
  vim.keymap.set('n', '<leader>lq', function()
    if not server_job_id then 
      print("No server running.") 
      return 
    end
    vim.fn.jobstop(server_job_id)
    server_job_id = nil
    active_url = nil
    print("Live Reload server stopped.")
  end, { desc = 'Stop Python Live Reload Server' })

  -- AUTO-KILL: Terminate background servers cleanly when Neovim exits
  vim.api.nvim_create_autocmd("VimLeavePre", {
    desc = "Kill background reloadserver on exit",
    callback = function()
      if server_job_id then
        vim.fn.jobstop(server_job_id)
      end
    end,
  })
end

return M
