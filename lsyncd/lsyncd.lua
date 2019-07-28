settings {
        logfile         = "/home/krakapwa/.lsyncd/log/lsyncd.log",
        statusFile      = "/home/krakapwa/.lsyncd/log/lsyncd.stat",
        statusInterval = 1,
        nodaemon        = false
}

sync {
        default.rsyncssh,
        source = "/home/krakapwa/Documents/software",   
        host="laurent@130.92.124.90",
        targetdir = "/home/laurent.lejeune/Documents/software",
        delete = "running",
        delay = 3,

    }
