settings {
        logfile         = "/home/krakapwa/.lsyncd/log/lsyncd.log",
        statusFile      = "/home/krakapwa/.lsyncd/log/lsyncd.stat",
        statusInterval = 1,
        nodaemon        = false
}

sync {
        default.rsyncssh,
        source = "/home/krakapwa/Documents/software",   
        host = "lejeune@submit.unibe.ch",
        targetdir = "/home/ubelix/artorg/lejeune/Documents/software",
        delay=1,
        rsync = {
                rsh = "/usr/bin/ssh -l lejeune -i /home/krakapwa/.ssh/id_rsa -o StrictHostKeyChecking=no"
        }
}


--sync {
--        default.rsyncssh,
--        source = "/home/krakapwa/Documents/software",   
--        host = "laurent@130.92.124.90",
--        targetdir = "/home/laurent/Documents/software",
--        delay=1,
--        rsync = {
--                rsh = "/usr/bin/ssh -l laurent -i /home/krakapwa/.ssh/id_rsa -o StrictHostKeyChecking=no"
--        }
--}
