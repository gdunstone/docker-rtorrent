This is based on  [linuxserver/rutorrent](https://github.com/linuxserver/docker-rutorrent)
however it has no rutorrent (only rtorrent)



## Usage

```
docker create --name=rtorrent \
-v <path to torrents>:/torrents \
-v <path to download directory>:/downloads \
-e TZ=<timezone> \
-p 51413:51413 -p 6881:6881/udp \
stormv/rtorrent
```

## Parameters

`The parameters are split into two halves, separated by a colon, the left hand side representing the host and the right the container side.
For example with a port -p external:internal - what this shows is the port mapping from internal to external of the container.`

* `-p 51413` - the port(s)
* `-p 6881/udp` - the port(s)
* `-v /torrents` - where rtorrent should check for torrent files
* `-v /downloads` - path to your downloads folder
* `-e PGID` for GroupID - see below for explanation
* `-e PUID` for UserID - see below for explanation
* `-e TZ` for timezone information, eg Europe/London

It is based on alpine linux with s6 overlay, for shell access whilst the container is running do `docker exec -it rutorrent /bin/bash`.

### User / Group Identifiers

Sometimes when using data volumes (`-v` flags) permissions issues can arise between the host OS and the container. We avoid this issue by allowing you to specify the user `PUID` and group `PGID`. Ensure the data volume directory on the host is owned by the same user you specify and it will "just work" ™.

In this instance `PUID=1001` and `PGID=1001`. To find yours use `id user` as below:

```
  $ id <dockeruser>
    uid=1001(dockeruser) gid=1001(dockergroup) groups=1001(dockergroup)
```

## Setting up the application

** The Port Assignments and configuration folder structure has been changed from the previous ubuntu based versions of this container and we recommend a clean install **

Umask can be set in the /rtorrent.rc file by changing value in `system.umask.set`

If you are seeing this error `Caught internal_error: 'DhtRouter::get_tracker did not actually insert tracker.'.` , a possible fix is to disable dht in `/rtorrent.rc` by changing the following values.

```shell
dht = disable
peer_exchange = no
```

## Info

* Shell access whilst the container is running: `docker exec -it rtorrent /bin/bash`
* To monitor the logs of the container in realtime: `docker logs -f rtorrent`

* container version number

`docker inspect -f '{{ index .Config.Labels "build_version" }}' rtorrent`

* image version number

`docker inspect -f '{{ index .Config.Labels "build_version" }}' stormv/rtorrent`
