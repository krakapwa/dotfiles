settings {
        logfile         = "/home/krakapwa/log/lsyncd/lsyncd.log",
        statusFile      = "/home/krakapwa/log/lsyncd/lsyncd.stat",
        statusInterval = 1,
        nodaemon        = false
}

sync {
        default.rsyncssh,
        source = "/home/krakapwa/Documents",   
        host="laurent@130.92.124.90",
        targetdir = "/home/laurent.lejeune/Documents",
        delay           = 5,
        rsync = {
             archive = true,
             compress = false,
             whole_file = false
           }
}
