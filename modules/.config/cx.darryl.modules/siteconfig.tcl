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

set modulefile_extra_cmds {putSepLine putSepLine}
set modulefile_extra_vars $extra_vars
set modulerc_extra_vars $extra_vars

setConf implicit_default 0
