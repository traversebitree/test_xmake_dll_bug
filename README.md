
## Project tree
```
test_xmake_static_or_shared
├─ src
│  ├─ main
│  │  └─ main.cpp
│  └─ shared_lib
│     └─ libabc_shared.cpp
└─ xmake.lua

```

## `xmake.lua`
```lua
add_rules("mode.debug", "mode.release")

target("shared_lib")
    set_kind("shared")
    add_files("src/shared_lib/libabc_shared.cpp")
    -- Debug info
    if is_kind("shared") then
       print("[Debug Print] is shared.") 
    end
    if is_kind("static") then
       print("[Debug Print] is static") 
    end
    -- End Debug info
    if is_plat("windows") and is_kind("shared") then
        add_rules("utils.symbols.export_all", {export_classes = true})
    end

target("main")
    set_kind("binary")
    add_files("src/main/main.cpp")
    add_deps("shared_lib")
```
