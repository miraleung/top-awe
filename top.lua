local wibox = require("wibox")
local awful = require("awful")

top_widget = wibox.widget.textbox()

function update_top(text_widget)
  local fd = io.popen("top -bn1 | sed '8q;d'")
  local proc_status = fd:read("*all")
  fd:close()

  -- Get %CPU, %MEM, TIME+, and process name
  local proc_str = string.match(proc_status,
    "(%d?%d%.%d.*%w+)");

  text_widget:set_markup(proc_str)
end

update_top(top_widget)
mytimer = timer({ timeout = 1 })
mytimer:connect_signal("timeout", function () update_top(top_widget) end)
mytimer:start()
