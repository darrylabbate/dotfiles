help([[
Enable Homebrew-installed GNU coreutils
]])

whatis("GNU coreutils")

local brew_prefix = os.getenv("HOMEBREW_PREFIX")
prepend_path("PATH", pathJoin(brew_prefix, "opt/coreutils/libexec/gnubin"))
prepend_path("MANPATH", pathJoin(brew_prefix, "opt/coreutils/libexec/gnuman"))

local ls_opts = "--color --group-directories-first"
set_alias("l", "ls -Fh " .. ls_opts)
set_alias("la", "ls -AFh " .. ls_opts)
set_alias("ll", "ls -AFhlo " .. ls_opts)
