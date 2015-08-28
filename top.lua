local wibox = require("wibox")
local awful = require("awful")

top_widget = wibox.widget.textbox()
top_widget:set_font("monospace 8")

-- Returns the total CPU usage (percent) as a string.
function get_total_cpu()
  local mpstat_cmd = "mpstat | awk '$3 ~ /CPU/ { for(i=1;i<=NF;i++) { "
  .. "if ($i ~ /%idle/) field=i } } $3 ~ /all/ { print 100 - $field }'"
  local fd = io.popen(mpstat_cmd)
  local total_cpu_status = fd:read("*all")
  fd:close()
  local total_cpu = total_cpu_status:match("%d+%.?%d*")
  return string.format("%.1f", tonumber(total_cpu))
end

-- Returns the total memory usage (percent) as a string.
function get_total_mem()
  local total_mem_cmd = "free -m | awk 'NR==2{var=$3*100/$2; print var}'"
  local fd = io.popen(total_mem_cmd)
  local total_mem_status = fd:read('*all')
  fd:close()
  return string.format("%.1f", tonumber(total_mem_status))
end

function get_proc_name(raw_proc_substr)
  proc_name = raw_proc_substr:gsub("%d", "")
  proc_name = proc_name:gsub("%s", "")
  proc_name = proc_name:gsub("%.", "")
  proc_name = proc_name:gsub(":", "")
  return proc_name:sub(0, 12)
end

-- Returns {@code max_len} spaces minus length of {@code str}.
function get_padding(max_len, str)
  return string.rep(" ", max_len - str:len())
end

function update_top(text_widget)
  local fd = io.popen("top -bn1 | sed '8q;d'")
  local proc_status = fd:read("*all")
  fd:close()

  -- Get CPU%, Mem%, Total CPU%, and process name.
  proc_substr = proc_status:match("(%d?%d%.%d.*%w+)")

  local cpu = proc_substr:match("(%d?%d%.%d)")
  local mem = proc_substr:match("%d?%d%.%d.*(%d+%.%d)")
  local total_cpu = get_total_cpu()
  local total_mem = get_total_mem()
  local proc_name = get_proc_name(proc_substr)

  proc_padding = get_padding(12, proc_name)
  cpu_padding = get_padding(4, cpu)
  mem_padding = get_padding(4, mem)
  total_cpu_padding = get_padding(5, total_cpu)
  total_mem_padding = get_padding(5, total_mem)

  proc_str = " Proc: " .. proc_name .. proc_padding
    .. " CPU: " .. cpu_padding .. cpu .. "%"
    .. " Mem: " .. mem_padding .. mem .. "%"
    .. " | Total CPU: " .. total_cpu_padding .. total_cpu .. "%"
    .. " Mem: " .. total_mem_padding .. total_mem .. "%"

  text_widget:set_markup(proc_str)
end

update_top(top_widget)
local mytimer = timer({ timeout = 1 })
mytimer:connect_signal("timeout", function () update_top(top_widget) end)
mytimer:start()
