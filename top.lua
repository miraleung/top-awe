local wibox = require("wibox")
local awful = require("awful")

top_widget = wibox.widget.textbox()
top_widget:set_font("monospace 8")

function update_top(text_widget)
  local fd = io.popen("top -bn1 | sed '8q;d'")
  local proc_status = fd:read("*all")
  fd:close()

  fd = io.popen("mpstat | awk '$3 ~ /CPU/ { for(i=1;i<=NF;i++) { if ($i ~ /%idle/) field=i } } $3 ~ /all/ { print 100 - $field }'")
  local total_cpu_status = fd:read('*all')
  fd:close()

  -- Get %CPU, %MEM, TIME+, and process name
  local proc_substr = string.match(proc_status,
    "(%d?%d%.%d.*%w+)")

  cpu = string.match(proc_substr, "(%d?%d%.%d)")
  mem = string.match(proc_substr, "%d?%d%.%d.*(%d+%.%d)")
  proc_name = proc_substr:gsub("%d", "")
  proc_name = proc_name:gsub("%s", "")
  proc_name = proc_name:gsub("%.", "")
  proc_name = proc_name:gsub(":", "")
  proc_name = proc_name:sub(0, 12)
  total_cpu_status:gsub("%%", "")
  num_proc_spaces = 12 - proc_name:len()
  num_cpu_spaces = 4 - cpu:len()
  num_mem_spaces = 4 - mem:len()
  num_total_cpu_spaces = 6 - total_cpu_status:len()
  proc_padding = string.rep(" ", num_proc_spaces)
  cpu_padding = string.rep(" ", num_cpu_spaces)
  mem_padding = string.rep(" ", num_mem_spaces)
  total_cpu_padding = string.rep(" ", num_total_cpu_spaces)
  proc_str = " Proc: " .. proc_name .. proc_padding
    .. " CPU: " .. cpu_padding .. cpu
    .. " Mem: " .. mem_padding .. mem
    .. " | Total CPU: " .. total_cpu_padding .. total_cpu_status

  text_widget:set_markup(proc_str)
end

update_top(top_widget)
local mytimer = timer({ timeout = 1 })
mytimer:connect_signal("timeout", function () update_top(top_widget) end)
mytimer:start()
