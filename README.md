# top-awe
A process monitor widget for [awesomewm](http://awesome.naquadah.org/) 3.5.

## Installation
1. `cd ~/.config/awesome/lib` (awesomewm config directory).
2. `git clone https://github.com/miraleung/top-awe.git`
3. `cd ..`
4. In `rc.lua`:
  1. Add to the top:
    ```
    local top require("lib.top-awe.top")
    ```
  2. After the line `if s == 1 then right_layout:add(wibox.widget.systray()) end`, add
    ```
    right_layout:add(top_widget)
    ```


