-- ImGui version 1.89.9 (or specify the actual version you're using)
project "ImGui"
kind "StaticLib"
language "C++"

-- Directory variables for easier maintenance
local IMGUI_DIR = "."
local BACKENDS_DIR = IMGUI_DIR .. "/backends"

targetdir ("bin/" .. outputdir .. "/%{prj.name}")
objdir ("bin-int/" .. outputdir .. "/%{prj.name}")

-- Vulkan SDK path handling with error checking
local vulkanSDK = os.getenv("VULKAN_SDK")
if not vulkanSDK then
    error("VULKAN_SDK environment variable is not set")
end

files
{
    IMGUI_DIR .. "/imconfig.h",
    IMGUI_DIR .. "/imgui.cpp",
    IMGUI_DIR .. "/imgui.h",
    IMGUI_DIR .. "/imgui_demo.cpp",
    IMGUI_DIR .. "/imgui_draw.cpp",
    IMGUI_DIR .. "/imgui_internal.h",
    IMGUI_DIR .. "/imgui_tables.cpp",
    IMGUI_DIR .. "/imgui_widgets.cpp",
    IMGUI_DIR .. "/imstb_rectpack.h",
    IMGUI_DIR .. "/imstb_textedit.h",
    IMGUI_DIR .. "/imstb_truetype.h",
    BACKENDS_DIR .. "/imgui_impl_glfw.h",
    BACKENDS_DIR .. "/imgui_impl_vulkan.h",
    BACKENDS_DIR .. "/imgui_impl_glfw.cpp",
    BACKENDS_DIR .. "/imgui_impl_vulkan.cpp"
}

includedirs
{
    IMGUI_DIR,
    "%{wks.location}/external/glfw/include",
    vulkanSDK .. "/Include"
}

-- Common settings across all platforms
warnings "Extra"

-- Platform specific configurations
filter "system:windows"
    systemversion "latest"
    cppdialect "C++20"
    defines { "IMGUI_API=__declspec(dllexport)" }
    
filter "system:linux"
    systemversion "latest"
    cppdialect "C++20"
    defines { "IMGUI_API=" }
    
filter "system:macosx"
    systemversion "latest"
    cppdialect "C++20"
    defines { "IMGUI_API=" }

-- Configuration specific settings
filter "configurations:Debug"
    staticruntime "On"
    runtime "Debug"
    symbols "on"
    defines { "IMGUI_DEBUG" }
    
filter "configurations:Release"
    staticruntime "On"
    runtime "Release"
    optimize "on"
    
-- Windows specific linker options
filter { "system:windows", "configurations:Debug or Release" }
    linkoptions { "/NODEFAULTLIB:LIBCMTD" }
