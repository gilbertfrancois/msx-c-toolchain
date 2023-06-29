# Dockerized MSX Fusion-C build environment 

_Gilbert François Duivesteijn_

## About

This repository provides an out-of-the-box consistent cross-platform MSX C-programming development environment for ~~all~~ most computers with ARM or Intel processors. It runs on macOS (Apple Silicon or Intel), Linux (ARM64 or x86_64) and Windows.




https://github.com/gilbertfrancois/msx-c-toolchain/assets/15607023/1b9fa267-eded-4fe3-88b4-19333b3ba87b





It uses:

- **Docker image**, based on Ubuntu 22.04
- **SDCC 4.0.0**, compiled from source and *z80.ref* patched for Fusion-C.
- **Hex2bin** tool, compiled from source and patched to make it work with GCC > 11.
- **Fusion-C 1.2** library, compiled from source, compatible with SDCC 4.0.0

All libraries are compiled from source, which allows to get native speed on all CPU architectures. On your native host system, install [openMSX](http://openmsx.org) and the [editor](https://neovim.io) of your choice. You only compile the programs in the Docker container. You can edit the source files in the native host system in the editor that you prefer. Running and testing in openMSX happens also on your native operating system.



The location of the tools in the docker container are:

| Tool                          | Location                     | Compiler arguments<br/>Import statement in src file      |
| ----------------------------- | ---------------------------- | -------------------------------------------------------- |
| sdcc                          | /usr/local/bin/sdcc          |                                                          |
| sdasz80                       | /usr/local/bin/sdas80        |                                                          |
| sdcc libraries                | /usr/local/share/sdcc        |                                                          |
| hex2bin                       | /usr/local/bin/hex2bin       |                                                          |
| Fusion-C include              | /usr/local/fusion-c/include  | /usr/local/fusion-c/include/<filename.rel>               |
| Fusion-C library              | /usr/local/fusion-c/lib      | -L /usr/local/fusion-c/lib -l fusion.lib                 |
| Fusion-C header               | /usr/local/fusion-c/header   | -I /usr/local/fusion-c/header<br/>#import <msx_fusion.h> |
| Fusion-C header (alternative) | [src folder]/fusion-c/header | #import "fusion-c/header/msx_fusion.h"                   |

Use these locations in your [Makefile](./Makefile). See the [example](./Makefile) in this repository.



## Installation

Install [Docker](https://www.docker.com) on your system if you don't have that yet. Then open a terminal and run:

```sh
git pull https://github.com/gilbertfrancois/msx-c-toolchain.git
cd msx-c-toolchain

docker compose up -d
```

The first time, it pulls the docker image from [Docker Hub](https://hub.docker.com/r/gilbertfrancois/msx-c-toolchain/tags) and selects your CPU architecture automatically. That might take some seconds, depending on your internet download speed. The next time, the startup will be super fast. When you want to close your docker container, run:

```sh
docker compose down
```

This repository does not provide a version of MSX-DOS. You have to copy it yourself in the folders `./dist/msxdos1` and/or .`/dist/msxdos2`.

## Using the development environment

- `docker compose up`: Start the docker container.
- Use the editor that you like, place the source files in `/src`
- `docker exec [container-id] [command]` : 
    + `docker exec msx-c-toolchain-dev-1 make`': Run **make**
    + `docker exec msx-c-toolchain-dev-1 make clean`': Run **make clean**
- `/dsk/[artefact]`: Test in openMSX on the host your compiled artefact (bin, rom, com)
- `docker compose down`: Stop the docker container when you're done developing.



## Easy shortcuts

I higly recommend installing [just](https://github.com/casey/just) and edit the file `Justfile` to your likings. As an example, instead of typing the full command `docker exec [container_id] [command]`, you can shorten it to:

```sh
just clean   # make clean
just make    # make
```

And starting openMSX and testing your program would be like:

```sh
just run1    # MSX1 computer with floppy drive
just run2    # MSX2 computer with floppy drive

# ... and any shortcut you create yourself in Justfile.
```



## Random notes

​	At the moment, Fusion-C 1.2 is compatible with SDCC up to version 4.0.0. Higher versions of SDCC are incompatible due to a breaking change in the bundled assembler. 

​	Patching sdcc's `z80.ref` library is needed, because functions like printf and putchar are not compatible with MSX. Fusion-C provides own implementations for these functions. The patch is implemented in *Dockerfile*.

​	You can build the docker image yourself very easily. Go to the `./docker` folder inside this project and run `docker_xbuild_all.sh`.

​	Docker is in transition of making the CLI commands more consistent, but on some Linux distributions, the old CLI commands are still available only. E.g. if `docker compose` (v2 version) does not work, try `docker-compose`, the v1 version. [reference](https://stackoverflow.com/questions/66514436/difference-between-docker-compose-and-docker-compose)



## References

- [Fusion-C library](https://www.ebsoft.fr/shop/en/19-fusion-c),  MSX C library by Eric Boez.
- [MSXgl](https://github.com/aoineko-fr/MSXgl), Game library for MSX, written in C, by Aioneko.
- [SDCC](https://sdcc.sourceforge.net), a retargettable, optimizing Standard C (ANSI C89, ISO C99, ISO C11) compiler suite.
- [msx.org](https://www.msx.org) MSX Resource Center has great info and discussions about Fusion C and more...
- [MSX DOS](https://download.file-hunter.com/OS/) at file hunter.
- [MSX C toolchain docker images](https://hub.docker.com/r/gilbertfrancois/msx-c-toolchain/tags) at Docker Hub, by Gilbert François.

