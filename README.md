
# john-docker
Docker container for john the ripper
[https://github.com/openwall/john](https://github.com/openwall/john)

## Building
The following `make` targets are availible for building

|target|description
|------|------|
|**build**|build the docker image|
|**john**|run jon against a dummy hash|
|**push**|push image to docker hub|
|**shell**|run a shell in the docker container as an unpriviledged user (usefulfor debugging)|
|**shell-root**|run a shell in the docker container as root (useful for debugging)|
|**test**|run all tests|

## Sample Usage
```
docker run --rm  -v YOUR_DATA_DIR:/data/ jbeley/john /run/john /data/yourhash.txt
```


## JTR's license
see https://github.com/openwall/john/blob/bleeding-jumbo/doc/LICENSE

## Credits

* [http://jmkhael.io/makefiles-for-your-dockerfiles/](http://jmkhael.io/makefiles-for-your-dockerfiles/)
* [https://github.com/jessfraz/dockerfiles](https://github.com/jessfraz/dockerfiles)
* [https://github.com/openwall/john](https://github.com/openwall/john)
