CONTAINER_NAME:=`basename ${PWD}` + "-dev-1"

make:
    docker container exec {{CONTAINER_NAME}} make 

clean:
    docker container exec {{CONTAINER_NAME}} make clean

run1:
    /Applications/openMSX.app/Contents/MacOS/openmsx -machine Canon_V-20 -ext Philips_VY_0010 -diska dist/msxdos1

run2:
    /Applications/openMSX.app/Contents/MacOS/openmsx -machine Philips_NMS_8255 -ext msxdos2 -diska dist/msxdos2

