make:
    docker container exec $(basename ${PWD})-dev-1 make

clean:
    docker container exec $(basename ${PWD})-dev-1 make clean

run:
    /Applications/openMSX.app/Contents/MacOS/openmsx -machine Philips_NMS_8255 -ext msxdos2 -diska dsk/
