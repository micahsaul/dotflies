-- Hyper key config

k = hs.hotkey.modal.new({}, 'F18')

function enterHyper()
    k:enter()
end

function exitHyper()
    k:exit()
end

F19 = hs.hotkey.bind({}, 'F19', enterHyper, exitHyper)

-- Caffeine
local caffeine = hs.menubar.new()
function setCaffeineDisplay(state)
    if state then
        caffeine:setTitle("+")
    else
        caffeine:setTitle("-")
    end
end

function caffeineClicked()
    setCaffeineDisplay(hs.caffeinate.toggle("displayIdle"))
end

if caffeine then
    caffeine:setClickCallback(caffeineClicked)
    setCaffeineDisplay(hs.caffeinate.get("displayIdle"))
end
k:bind({}, 'F1', nil, caffeineClicked)

-- Window location
hs.window.animationDuration = 0

function windowLocation(geom)
    local win = hs.window.focusedWindow()
    local f = win:frame()
    local screen = win:screen()
    local max = screen:frame()

    local coordinates = {
        left = {x = max.x, y = max.y, w = max.w / 2, h = max.h},
        right = {x = max.x + max.w / 2 , y = max.y, w = max.w / 2, h = max.h},
        full = {x = max.x, y = max.y, w = max.w, h = max.h},
        center = {x = max.x + max.w / 6, y = max.y, w = max.w * 2/3, h = max.h * 5/6},
        topLeft = {x = max.x, y = max.y, w = max.w / 2, h = max.h / 2},
        topRight = {x = max.x + max.w / 2, y = max.y, w = max.w / 2, h = max.h / 2},
        bottomLeft = {x = max.x, y = max.y + max.h / 2, w = max.w / 2, h = max.h / 2},
        bottomRight = {x = max.x + max.w / 2, y = max.y + max.h / 2, w = max.w / 2, h = max.h / 2}
    }

    f.x = coordinates[geom]['x']
    f.y = coordinates[geom]['y']
    f.w = coordinates[geom]['w']
    f.h = coordinates[geom]['h']

    win:setFrame(f)
end

resizeHotkeys = {
    {'l', 'left'},
    {'r', 'right'},
    {'c', 'center'},
    {'f', 'full'},
    {'1', 'topLeft'},
    {'2', 'topRight'},
    {'3', 'bottomLeft'},
    {'4', 'bottomRight'}
}

for i, geom in ipairs(resizeHotkeys) do
    k:bind({}, geom[1], function() windowLocation(geom[2]) end)
end

-- Reload config when saved
function reloadConfig(files)
    doReload = false
    for _,file in pairs(files) do
        if file:sub(-4) == '.lua' then
            doReload = true
        end
    end
    if doReload then
        hs.reload()
    end
end
local myWatcher = hs.pathwatcher.new(os.getenv('HOME') .. '/.hammerspoon/', reloadConfig):start()
hs.alert.show('Config loaded')
