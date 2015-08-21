# top-awe
A [top](http://linux.die.net/man/1/top) process monitor widget for [awesomewm](http://awesome.naquadah.org/) 3.5.

![top-awe](https://cloud.githubusercontent.com/assets/5384433/9402154/69b79e4c-478e-11e5-99a7-b5da2e30841b.png)

## Installation
0. **Dependencies:** `sudo apt-get install top mpstat`
1. `cd ~/.config/awesome/lib`
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


