local platform = require('utils.platform')

local function path_exists(path)
   local file = io.open(path, 'r')
   if file then
      file:close()
      return true
   end
   return false
end

local function linux_shell()
   local shell = os.getenv('SHELL')
   if shell and path_exists(shell) then
      return shell
   end

   if path_exists('/usr/bin/zsh') then
      return '/usr/bin/zsh'
   end

   return '/usr/bin/bash'
end

local options = {
   default_prog = {},
   launch_menu = {},
}

if platform.is_win then
   options.default_prog = { 'powershell.exe', '-NoLogo' }
   options.launch_menu = {
      { label = 'Windows PowerShell', args = { 'powershell.exe', '-NoLogo' } },
      { label = 'Command Prompt', args = { 'cmd.exe' } },
      {
         label = 'Git Bash',
         args = { 'E:\\Git\\bin\\bash.exe', '-l' },
      },
   }
elseif platform.is_mac then
   options.default_prog = { '/opt/homebrew/bin/fish', '-l' }
   options.launch_menu = {
      { label = 'Bash', args = { 'bash', '-l' } },
      { label = 'Fish', args = { '/opt/homebrew/bin/fish', '-l' } },
      { label = 'Nushell', args = { '/opt/homebrew/bin/nu', '-l' } },
      { label = 'Zsh', args = { 'zsh', '-l' } },
   }
elseif platform.is_linux then
   local preferred_shell = linux_shell()

   options.default_prog = { preferred_shell, '-l' }
   options.launch_menu = {
      { label = 'Bash', args = { '/usr/bin/bash', '-l' } },
   }

   if path_exists('/usr/bin/zsh') then
      table.insert(options.launch_menu, { label = 'Zsh', args = { '/usr/bin/zsh', '-l' } })
   end

   if path_exists('/usr/bin/fish') then
      table.insert(options.launch_menu, { label = 'Fish', args = { '/usr/bin/fish', '-l' } })
   end
end

return options
