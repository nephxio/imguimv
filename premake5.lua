project "ImGui"
	kind "StaticLib"
	language "C++"

	targetdir ("bin/" .. outputdir .. "/%{prj.name}")
	objdir ("bin-int/" .. outputdir .. "/%{prj.name}")

	files
	{
        "imconfig.h",
        "imgui.cpp",
        "imgui.h",
        "imgui_demo.cpp",
        "imgui_draw.cpp",
        "imgui_internal.h",
        "imgui_tables.cpp",
        "imgui_widgets.cpp",
        "imstb_rectpack.h",
        "imstb_textedit.h",
        "imstb_truetype.h",
        "./backends/imgui_impl_glfw.h",
        "./backends/imgui_impl_vulkan.h",
        "./backends/imgui_impl_glfw.cpp",
        "./backends/imgui_impl_vulkan.cpp"
	}
	
	includedirs
	{
		".",
		"%{wks.location}/external/glfw/include",
		os.getenv("VULKAN_SDK") .. "/Include"
	}
	

	filter "system:windows"
		systemversion "latest"
		cppdialect "C++20"
		staticruntime "On"

	filter "configurations:Debug"
		runtime "Debug"
		symbols "on"
		linkoptions { "/NODEFAULTLIB:LIBCMTD" }

	filter "configurations:Release"
		runtime "Release"
		optimize "on"
		linkoptions { "/NODEFAULTLIB:LIBCMTD" }