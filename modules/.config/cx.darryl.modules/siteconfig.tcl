set XDG_CONFIG_HOME [getenv XDG_CONFIG_HOME [file join [file home] .config]]
set XDG_DATA_HOME   [getenv XDG_DATA_HOME   [file join [file home] .local share]]
set XDG_CACHE_HOME  [getenv XDG_CACHE_HOME  [file join [file home] .cache]]
set XDG_STATE_HOME  [getenv XDG_STATE_HOME  [file join [file home] .local state]]

set extra_vars [list                 \
    XDG_CONFIG_HOME $XDG_CONFIG_HOME \
    XDG_DATA_HOME   $XDG_DATA_HOME   \
    XDG_CACHE_HOME  $XDG_CACHE_HOME  \
    XDG_STATE_HOME  $XDG_STATE_HOME  \
]

proc putSepLine {} {
    if {[module-info mode display]} {
        set cols [getConf term_width]
        if {$cols == 0} {
            set cols 80
        }
        set max_rep 67
        set rep [expr {$cols > $max_rep ? $max_rep : $cols}]
        puts stderr [string repeat - $rep]
    }
}

# Compute the Homebrew prefix from the OS/arch rather than reading
# HOMEBREW_PREFIX via getenv. getenv is unreliable during `module refresh`
# (new panes/subshells), where it can return empty and break path-derived
# source-sh calls. Computing locally is refresh-safe.
proc brew-prefix {} {
    switch -- [uname sysname] {
        Darwin {
            switch -- [uname machine] {
                arm64  { return [file join /opt homebrew] }
                x86_64 { return [file join /usr local]    }
            }
        }
        Linux {
            return [file join [file home] linuxbrew .linuxbrew]
        }
    }
}

set modulefile_extra_cmds {putSepLine putSepLine brew-prefix brew-prefix}
set modulefile_extra_vars $extra_vars
set modulerc_extra_vars $extra_vars

setConf implicit_default 0
