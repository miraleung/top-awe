local wibox = require("wibox")
local awful = require("awful")

top_widget = wibox.widget.textbox()
top_widget:set_font("monospace 8")

function update_top(text_widget)
  local fd = io.popen("top -bn1 | sed '8q;d'")
  local proc_status = fd:read("*all")
  fd:close()

  -- Get %CPU, %MEM, TIME+, and process name
  local proc_substr = string.match(proc_status,
    "(%d?%d%.%d.*%w+)")

  cpu = string.match(proc_substr, "(%d?%d%.%d)")
  mem = string.match(proc_substr, "%d?%d%.%d.*(%d+%.%d)")
  proc_name = proc_substr:gsub("%d", "")
  proc_name = proc_name:gsub("%s", "")
  proc_name = proc_name:gsub("%.", "")
  num_spaces = 14 - proc_name:len()
  padding = string.rep(" ", num_spaces)
  proc_str = " Proc: " .. proc_name .. padding .. " CPU: " .. cpu .. "  Mem: " .. mem


  text_widget:set_markup(proc_str)
end

update_top(top_widget)
local mytimer = timer({ timeout = 1 })
mytimer:connect_signal("timeout", function () update_top(top_widget) end)
mytimer:start()
