**2019-02-17 - 3.9-1**

 * updated to Alpine 3.9.0

**2018-08-15 - 3.8-1**

 * updated to Alpine 3.8.0

**2017-10-30 - 3.6-3**

 * fixed user detection for a specific user id - e.g. *0* for *root*

   the command ```grep "^.*:0" /etc/passwd``` delivers more than one entry

   ```
   root:x:0:0:root:/root:/bin/ash
   sync:x:5:0:sync:/sbin:/bin/sync
   shutdown:x:6:0:shutdown:/sbin:/sbin/shutdown
   halt:x:7:0:halt:/sbin:/sbin/halt
   operator:x:11:0:operator:/root:/bin/sh
   ```

   and due this I changed it to the command ```getent passwd 0``` which delivers only the corresponding one

   ```
   root:x:0:0:root:/root:/bin/ash
   ```

 * changed the cleanup of the temporary directory from ```rm -rf /tmp``` to ```rm -rf /tmp/*```

 * added the package `tree` into the base image to have the possibility 
   to easily check which timezone values are possible via the command

   ```docker exec -it <CONTAINER> tree /usr/share/zoneinfo```

   and added a file with the [possible timezone values](TIMEZONES.md).

 * updated the way of user creation & user id assignment if id is already in usage e.g. id=0 by root

**2017-06-03 - 3.6-2**

 * new version allows now usage of group id's __PGID__ < 1000 
 * enhanced group creation via usage of `addgroup` and `groupmod`
 * enhanced user creation via usage of `adduser` and `usermod`
 * updated installation part of `gosu` according to https://github.com/tianon/gosu/blob/master/INSTALL.md

**2017-05-25 - 3.6-1**

 * updated image to Alpine 3.6
 * new versioning (simplified), changed to the format `<Alpine Image Tag>-<TS2k Release Number>` 
   instead of `<Alpine Image Tag>-<TS2k Version Number>`, the release number is only a single number 
   whereas the version number was defined as semantic versioning with `<major>.<minor>.<patch>`.

**2017-02-05 - 3.5-1.0.0**

 * first image based on Alpine 3.5
 