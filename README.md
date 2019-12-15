# Technosoft2000 Alpine Base image

[![Docker Stars](https://img.shields.io/docker/stars/technosoft2000/alpine-base.svg)]()
[![Docker Pulls](https://img.shields.io/docker/pulls/technosoft2000/alpine-base.svg)]()
[![](https://images.microbadger.com/badges/image/technosoft2000/alpine-base.svg)](https://microbadger.com/images/technosoft2000/alpine-base "Get your own image badge on microbadger.com")
[![](https://images.microbadger.com/badges/version/technosoft2000/alpine-base.svg)](https://microbadger.com/images/technosoft2000/alpine-base "Get your own version badge on microbadger.com")

## An Alpine Base image for all related images provided by Technosoft2000 ##

For easier creation and maintenance of docker images I've created an own base image which is based 
on the original [Alpine Image](https://hub.docker.com/_/alpine/) but with the following container startup lifecyle:

![alt text][lifecycle]

## Updates ##

**2019-12-15 - 3.10-2**

 * updated to Alpine 3.10.3
 * updated gosu to version 1.11

**2019-02-17 - 3.10-1**

 * updated to Alpine 3.10.0

For previous changes see at [full changelog](CHANGELOG.md).

## Features ##

 * well defined container startup lifecyle, but still conform with the docker idea to run only one application
 * no usage of a supervisor - be simple, be clean
 * support for release ASCII graphics and information which is shown at startup
 * integrated logging functions __TODO__

## Usage ##

__Create the container:__

```
docker create --name=<container name> --restart=always \
[-v <host folder>:<container folder> \
[-e APP_REPO=https://github.com/<insert here the app repo>.git \]
[-e APP_BRANCH=master \]
[-e SET_CONTAINER_TIMEZONE=true \]
[-e CONTAINER_TIMEZONE=<container timezone value> \]
[-e PGID=<group ID (gid)> -e PUID=<user ID (uid)> \]
-p <external port>:<internal port> \
<image name>
```

__Example for the `technosoft2000/calibre-web` image:__

```
docker create --name=calibre-web --restart=always \
-v /volume1/books:/books \
-v /etc/localtime:/etc/localtime:ro \
-e PGID=65539 -e PUID=1029 \
-p 8083:8083 \
technosoft2000/calibre-web
```

or

```
docker create --name=calibre-web --restart=always \
-v /volume1/books:/books \
-e SET_CONTAINER_TIMEZONE=true \
-e CONTAINER_TIMEZONE=Europe/Vienna \
-e PGID=65539 -e PUID=1029 \
-p 8083:8083 \
technosoft2000/calibre-web
```

__Start the container:__
```
docker start <container name>
```

## Parameters ##

### Introduction ###
The parameters are split into two parts which are separated via colon.
The left side describes the host and the right side the container. 
For example a port definition looks like this ```-p external:internal``` and defines the port mapping from internal (the container) to external (the host).
So ```-p 8080:80``` would expose port __80__ from inside the container to be accessible from the host's IP on port __8080__.
Accessing http://'host':8080 (e.g. http://192.168.0.10:8080) would then show you what's running **INSIDE** the container on port __80__.

### Details ###
* `-v /etc/localhost` - for timesync - __optional__
* `-e APP_REPO` - set it to the application GitHub repository
* `-e APP_BRANCH` - set which application GitHub repository branch you want to use, __master__ (default branch) - __optional__
* `-e SET_CONTAINER_TIMEZONE` - set it to `true` if the specified `CONTAINER_TIMEZONE` should be used - __optional__
* `-e CONTAINER_TIMEZONE` - container timezone as found under the directory `/usr/share/zoneinfo/` - __optional__
* `-e PGID` for GroupID - see below for explanation - __optional__
* `-e PUID` for UserID - see below for explanation - __optional__

### Container Timezone

In the case of the Synology NAS it is not possible to map `/etc/localtime` for timesync, and for this and similar case
set `SET_CONTAINER_TIMEZONE` to `true` and specify with `CONTAINER_TIMEZONE` which timezone should be used.
The possible container timezones can be found under the directory `/usr/share/zoneinfo/`.

Examples:

 * ```UTC``` - __this is the default value if no value is set__
 * ```Europe/Berlin```
 * ```Europe/Vienna```
 * ```America/New_York```
 * ...

Once the container is running you can get all possible timezones as tree via the command ```docker exec -it <CONTAINER> tree /usr/share/zoneinfo```

See also at [possible timezone values](TIMEZONES.md).

__Don't use the value__ `localtime` because it results into: `failed to access '/etc/localtime': Too many levels of symbolic links`

## User / Group Identifiers ##
Sometimes when using data volumes (-v flags) permissions issues can arise between the host OS and the container. We avoid this issue by allowing you to specify the user PUID and group PGID. Ensure the data volume directory on the host is owned by the same user you specify and it will "just work" ™.

In this instance PUID=1001 and PGID=1001. To find yours use id user as below:

```
  $ id <dockeruser>
    uid=1001(dockeruser) gid=1001(dockergroup) groups=1001(dockergroup)
```

## Additional ##
Shell access whilst the container is running: `docker exec -it <CONTAINER> /bin/bash`

Upgrade to the latest version of the application which runs in the container: `docker restart <CONTAINER>`

To monitor the logs of the container in realtime: `docker logs -f <CONTAINER>`

Show used base image version number of the container: `docker inspect -f '{{ index .Config.Labels "image.base.version" }}' <CONTAINER>`

[lifecycle]: https://rawgit.com/Technosoft2000/docker-alpine-base/master/docs/docker-alpine-base-lifecycle.svg "Technosoft2000 Alpine Base image lifecycle"
