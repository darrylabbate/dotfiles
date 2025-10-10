set modulesroot    [file join [file home] .modules]
set modulefilesdir [file join $modulesroot modulefiles]
set cachedir       [file join $modulesroot cache]

set extra_vars [list               \
    modulefilesdir $modulefilesdir \
    cachedir       $cachedir       \
]

proc putSepLine {} {
    set cols [getConf term_width]
    if {$cols == 0} {
        set cols 80
    }
    set max_rep 67
    set rep [expr {$cols > $max_rep ? $max_rep : $cols}]
    puts stderr [string repeat - $rep]
}

proc is-newer {file1 file2} {
    return [file mtime $file1] > [file mtime $file2]
}

# Cache the output of a command to a file for later use with source-sh
# This is useful when a module needs to post-process the script output before
# invoking source-sh
proc cache-cmd {command {source_file ""}} {
    global cachedir
    set cache_file [file join $cachedir "[string map {/ _ " " _} [join $command _]].[module-info shell]"]
    
    if {![file exists $cache_file] || 
        ($source_file ne "" && [file exists $source_file] && [is-newer $source_file $cache_file])} {
        file mkdir [file dirname $cache_file]
        set fd [open $cache_file w]
        puts $fd [exec {*}$command]
        close $fd
    }
    return $cache_file
}

# source-sh the output of `command`
# This writes the output to a file first, since source-sh requires a file path
# to the script to be sourced in order to properly reverse the operation upon
# unloading
proc source-cmd {command {source_file ""}} {
    source-sh [module-info shell] [cache-cmd $command $source_file]
}

set modulefile_extra_cmds {cache-cmd cache-cmd source-cmd source-cmd putSepLine putSepLine}
set modulefile_extra_vars $extra_vars
set modulerc_extra_vars $extra_vars

setConf implicit_default 0
