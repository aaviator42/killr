# killr

## What is this?
__`killr`__ is a super simple remote killswitch for Windows PCs.

All code is under AGPLv3.

## Installation
Download the following files and keep them all in the same directory:
```
 1. index1.html - primary html doc
 2. index2.html - secondary html doc
 3. killr.cmd   - main script
 4. nc.exe      - netcat executable compiled for Windows
 5. pass.txt    - text file with your passphrase
 6. res.txt     - HTML headers
```

`killr` requires netcat (`nc.exe`). You can compile it yourself, if you wish. Get the code [here](https://github.com/aaviator42/netcat-for-windows).

Next:
1. edit `pass.txt` to contain _only_ your password.  
2. edit the `port` and `comfile` variables at the top of `killr.cmd`.
3. create a scheduled task to run `killr.cmd` on startup.

`comfile` should be the path of a script or executable which gets called when the killswitch is activated.  
`port` should be the port on which killr listens.

## Invocation
`killr` is invoked by sending a GET request:
`hostname:port/?password=<password>`.

If you visit `https://hostname:port/` in your browser, it should show you a form which allows you to do the same thing.  

When `killr` is invoked, it executes the script defined in `comfile`, stops accepting any requests, and will only display a static HTML page.

When the killswitch is activated, it deletes the password file, forcing you to set up a new one in order to reset the killswitch. _This is by design_. Because your connection with `killr` is _not_ encrypted, a third party can get your password through a MITM attack. For this reason, please choose a _new and unique_ password each time you reset `killr`.

## Logs
You can access `killr`'s logs in `killr_log.txt`.

## Temporary Files
`killr` makes two temporary files: `__input` and `__pas`. These are safe to delete at any point, they'll just be recreated.
