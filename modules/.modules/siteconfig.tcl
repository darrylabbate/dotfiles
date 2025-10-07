# Cache the output of a command to a file for later use with source-sh
# This is useful when a module needs to post-process the script output before
# invoking source-sh
proc cache-cmd {command {source_file ""}} {
    set cache_file [file join [getenv USER_MODULES_CACHE_DIR] "[string map {/ _ " " _} [join $command _]].[module-info shell]"]
    
    if {![file exists $cache_file] || 
        ($source_file ne "" && [file exists $source_file] && [file mtime $source_file] > [file mtime $cache_file])} {
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

set modulefile_extra_cmds {cache-cmd cache-cmd source-cmd source-cmd}
