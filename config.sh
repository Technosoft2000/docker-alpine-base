#!/bin/bash

# set default values for userid, username, groupid and groupname if not set yet
PUID=${PUID:=15000}
PUSER=${PUSER:=app}
PGID=${PGID:=15000}
PGROUP=${PGROUP:=app}

# create internal APP group and user
# (which will be mapped to external group and user, and used to run the process)
GN=`getent group $PGID | awk -F':' '{print \$1}'`
if [ $GN ]; then
  echo "[WARNING] A group with id $PGID exists already [in use by $GN] and will be modified."
  # rename the existing group to the specified app group name
  echo "[WARNING] The group $GN will be renamed to $PGROUP"
  groupmod -o -n "$PGROUP" "$GN"
else
  echo "[INFO] Create group $PGROUP with id $PGID"
  # create group similar to:
  #  addgroup --gid $PGID $PGROUP
  addgroup -g $PGID $PGROUP
fi

UN=`grep "^.*:$PUID" /etc/passwd | awk -F':' '{print \$1}'`
if [ $UN ]; then
  echo "[WARNING] A user with id $PUID exists already [in use by $UN] and will be modified."
  # rename the existing user to the specified app user name
  echo "[WARNING] The user $UN will renamed to $PUSER and assigned to group $PGROUP"
  usermod -o -l "$PUSER" -g "$PGROUP" "$UN"
else
  echo "[INFO] Create user $PUSER with id $PUID"
  #create user similar to:
  #  adduser --shell /bin/bash --no-create-home --uid $PUID --ingroup $PGROUP --disabled-password --gecos "" $PUSER
  adduser -s /bin/bash -H -u $PUID -G $PGROUP -D -g "" $PUSER
fi

# set the timezone
source /init/set_timezone.sh
