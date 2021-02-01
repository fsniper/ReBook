#Rebook
--------------------

The missing book store for remarkable. 

Rebook is a standardebooks.com search and download application. 

Special thanks to:
* https://rmkit.dev/apps/rmkit 
* https://github.com/raisjn/okp
* https://www.boost.org/
* https://github.com/gocolly/colly 
* https://standardebooks.org/
* http://www.golang.org
* https://www.python.org


## Build

* **Make sure you have gcc-arm-linux-gnueabihf and okp installed**
* **Make sure you have go 1.15.6+ installed, go binary is in PATH, and GOPATH is set to rebook root dir.**

Downlad dependencies via running makedeps.sh
```
./makedeps.sh
```

Run make
```
make
```

## Install

For now rebook does not have a toltec package. 
1. You need to manually add rebook binary to your launchers list.
2. You need to copy rebook-go-standardebooks.arm into /opt/ directory as `rebook-go-standardebooks` file

## Usage

1. Make sure you are connected to the Internet 
2. Click on the search box
3. Enter a search term.
4. Click on a book to download into /home/root directory.
