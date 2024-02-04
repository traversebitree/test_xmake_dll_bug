set_project("test_xmake")
set_xmakever("2.8.6")
set_version("0.1.0", { build = "%Y%m%d%H%M" })
set_languages("cxx20")

add_rules("mode.debug", "mode.release")
add_rules("set_export_all_symbols")
add_rules("set_rpath")

add_requires("fmt 10.x", {
  debug = is_mode("debug"),
  configs = {
    shared = true,
  },
})

rule("set_export_all_symbols")
do
  on_load(function(target)
    if target:kind() == "static" then
      target:set("kind", "static")
    elseif target:kind() == "shared" then
      import("core.tool.toolchain")
      target:set("kind", "shared")
      if is_plat("windows") and toolchain.load("msvc"):config("vs") then
        import("core.project.rule")
        local rule = rule.rule("utils.symbols.export_all")
        target:rule_add(rule)
        target:extraconf_set("rules", "utils.symbols.export_all", { export_classes = true })
      end
    end
  end)
end
rule_end()

rule("set_rpath")
do
  on_load(function(target)
    if target:kind() == "binary" and not is_plat("windows") then
      target:add_rpathdirs("$ORIGIN")
    end
  end)
end
rule_end()

target("shared_lib")
do
  set_kind("shared")
  add_files("src/shared_lib/libabc_shared.cpp")
  add_includedirs("include/", { public = true })
  add_headerfiles("include/shared_lib/libabc_shared.hpp", { install = true, prefixdir = "shared_lib" })
  add_packages("fmt")
end
target_end()

target("main")
do
  set_kind("binary")
  add_files("src/main/main.cpp")
  add_deps("shared_lib")
  after_install(function(target)
    os.execv("xmake run main")
  end)
end
target_end()
