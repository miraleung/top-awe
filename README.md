# top-awe
A [top](http://linux.die.net/man/1/top) process monitor widget for [awesomewm](http://awesome.naquadah.org/) 3.5.

![top-awe](https://cloud.githubusercontent.com/assets/5384433/9540062/00bb52ea-4d0f-11e5-8d25-5003b4b151e6.png)

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
  2. After the line `if s == 1 then right_layout:add(wibox.widget.systray()) end`, add:

    ```
    right_layout:add(top_widget)
    ```


