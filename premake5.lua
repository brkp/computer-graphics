workspace "ComputerGraphics"
  configurations { "debug", "release" }

  newaction {
    trigger = "clean",
    description = "clean the project",
    execute = function()
      os.rmdir("build")
      os.remove("Makefile")
      os.remove("compile_commands.json")
    end
  }

  function generate_project(name, type, link, include)
    project(name)
      kind(type)
      language "C"
      location("build/" .. name)

      files({ name .. "/*.h", name .. "/*.c" })
      links(link)

      includedirs(link)
      includedirs(include)

      filter "configurations:debug"
        defines { "DEBUG" }
        symbols "on"

      filter "configurations:release"
        optimize "on"
  end

  function generate_test(name, link, include)
    project(name)
      kind "ConsoleApp"
      location "build/tests"

      files({ "tests/" .. name .. ".c" })
      links(link)

      includedirs(link)
      includedirs(include)
  end

  generate_project("linal", "StaticLib", {}, {})
  generate_project("canvas", "StaticLib", {}, {})

  -- generate_project("raytracer", "ConsoleApp", { "canvas", "linal" }, {})
  -- generate_project("rasterizer", "ConsoleApp", { "canvas", "linal" }, {})

  generate_test("test_canvas", "canvas", {})
  generate_test("test_linal_vec", "linal", {})