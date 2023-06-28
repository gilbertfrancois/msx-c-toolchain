# Dockerized MSX Fusion-C build environment 

_Gilbert François Duivesteijn_

## About

This repository creates a out-of-the-box consistent cross-platform MSX C-programming development environment for all computers with ARM and Intel processors. It runs on macOS (Apple Silicon or Intel), Linux (ARM64 or x86_64) and Windows.

It uses:

- **Docker image**, based on Ubuntu 22.04
- **SDCC 4.0.0**, compiled from source and *z80.ref* patched for Fusion-C.
- **Hex2bin** tool, compiled from source and patched to make it work with gcc > 11.
- **Fusion-C 1.2** library, compiled from source, compatible with SDCC 4.0.0

Since all libraries are compiled from source, one gets native speed on all architectures. On your native host system, install [openMSX](http://openmsx.org) and the [editor](https://neovim.io) of your choice. You only compile the programs in the Docker container. You can edit the source files in the native host system in the editor that you prefer. Running and testing in openMSX happens also on your native operating system.



The location of the tools in the docker container are:

| Tool             | Location                    |
| ---------------- | --------------------------- |
| sdcc             | /usr/local/bin/sdcc         |
| sdasz80          | /usr/local/bin/sdas80       |
| sdcc libraries   | /usr/local/share/sdcc       |
| hex2bin          | /usr/local/bin/hex2bin      |
| Fusion-C include | /usr/local/fusion-c/include |
| Fusion-C library | /usr/local/fusion-c/lib     |
| Fusion-C header  | /usr/local/fusion-c/header  |

Use these locations in your Makefile. See the example in this project 



## Installation

Install [Docker](https://www.docker.com) on your system if you don't have that yet. Then open a terminal and run:

```sh
docker compose up -d
```

At first time, it builds the docker image and compiles SDCC, Hex2bin and Fusion-C. That will take some time. The next time, the startup will be super fast. When you want to close your docker container, run:

```sh
docker compose down
```



## Using the development environment

- Start the docker container `docker compose up`
- Use the editor that you like, place the source files in `/src`
- Run `docker exec msx-cc-dev-1 make` to build your code, where *msx-cc-dev-1* is the name of the docker container. (Or use `just`, as described in the section [Easy shortscuts](## Easy shortcuts)).

- Test in openMSX your artefact (bin, rom, com)

- When you're done with development, close the container with `docker compose down`.



## Easy shortcuts

I higly recommend installing [just](https://github.com/casey/just) and edit the file `Justfile` to your likings. As an example, instead of typing the full command `docker exec [docker_container_name] make`, you can shorten it to:

```sh
just make
```

And starting openMSX and testing your program would be like:

```sh
just run
```



## Random notes

At the moment, Fusion-C 1.2 is compatible with SDCC up to version 4.0.0. Higher versions of SDCC are incompatible due to a breaking change in the bundled assembler. 

Patching sdcc's z80.ref library is needed, because functions like printf and putchar are not compatible with MSX. Fusion-C provides own implementations for these functions. The patch is implemented in *Dockerfile*.



## References

- [Fusion-C library](https://www.ebsoft.fr/shop/en/19-fusion-c) MSX C library by Eric Boez.

- [SDCC](https://sdcc.sourceforge.net), a retargettable, optimizing Standard C (ANSI C89, ISO C99, ISO C11) compiler suite.

- [msx.org](https://www.msx.org) MSX Resource Center has great info and discussions about Fusion C and more...