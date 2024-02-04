add_rules("mode.debug", "mode.release")
add_rules("set_export_all_symbols")

rule("set_export_all_symbols")
do
    on_load(
        function(target)
            if target:kind() == "static" then
                target:set("kind", "static")
            elseif target:kind() == "shared" then
                import("core.tool.toolchain")
                target:set("kind", "shared")
                if is_plat("windows") and toolchain.load("msvc"):config("vs") then
                    import("core.project.rule")
                    local rule = rule.rule("utils.symbols.export_all")
                    target:rule_add(rule)
                    target:extraconf_set("rules", "utils.symbols.export_all", {export_classes = true})
                end
            end
        end
    )
end

target("shared_lib")
do
    set_kind("shared")
    add_files("src/shared_lib/libabc_shared.cpp")
end

target("main")
do
    set_kind("binary")
    add_files("src/main/main.cpp")
    add_deps("shared_lib")
end
