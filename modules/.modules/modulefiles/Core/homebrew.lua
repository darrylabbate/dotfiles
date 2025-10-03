help([[
Configures environment variables for using Homebrew. This is essentiall a modulefile wrapper for `brew shellenv`
]])

whatis("Homebrew package manager")

local system = capture("uname -s"):gsub("\n$", "")
local arch = capture("uname -m"):gsub("\n$", "")
local brew_prefix, shellenv_prefix

if system == "Darwin" then
    if arch == "arm64" then
        brew_prefix = "/opt/homebrew"
    else
        brew_prefix = "/usr/local"
    end
    shellenv_prefix = brew_prefix
elseif system == "Linux" then
    brew_prefix = "/home/linuxbrew/.linuxbrew"
    shellenv_prefix = pathJoin(brew_prefix, "Homebrew")
else
    LmodError("Unsupported platform: " .. system)
end

local shellenv_source = pathJoin(shellenv_prefix, "Library/Homebrew/cmd/shellenv.sh")
local cache_dir = pathJoin(os.getenv("MODULES_ROOTDIR"), "cache")
local script_path = pathJoin(cache_dir, "brew-shellenv.bash")

-- Create cache directory if it doesn't exist
if not isDir(cache_dir) then
    os.execute("mkdir -p " .. cache_dir)
end

-- Update script if source is newer or script doesn't exist
if not isFile(script_path) then
    local shellenv_output = capture(pathJoin(brew_prefix, "bin/brew") .. " shellenv")
    local f = io.open(script_path, "w")
    if f then
        f:write(shellenv_output)
        f:close()
    else
        LmodError("Failed to create " .. script_path)
    end
end

source_sh("bash", script_path)
source_sh("bash", pathJoin(brew_prefix, "etc/profile.d/bash_completion.sh"))

setenv("HOMEBREW_CURLRC", "1")
setenv("HOMEBREW_FORCE_BREWED_CURL", "1")
setenv("HOMEBREW_NO_AUTO_UPDATE", "1")
