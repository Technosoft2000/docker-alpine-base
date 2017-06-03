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
 