# quick-3.3-docker
##  lua加密，支持10.14 以上系统。主要是为了解决Mac系统不支持32位quick-3.3

# install docker-desktop and start docker

# build docker
```
docker build . -t quick 
```

```
docker run --rm -v ${SRCROOT}/../../../:/data/  -i quick /opt/quick-3.3/quick/bin/compile_scripts.sh -i /data/src -o /data/upd/src -m files -e xxtea_chunk -ek encrypt-key -es encrypt-sign
```
