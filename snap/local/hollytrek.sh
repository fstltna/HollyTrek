#!/bin/sh
# HollyTrek reads sst.doc and SST_Logo.txt from the current folder and
# writes saved games (*.trk) and plaques there too. Run it from the snap's
# own writable folder, which is kept across updates:
#   ~/snap/hollytrek/common
cd "$SNAP_USER_COMMON" || exit 1
for f in sst.doc SST_Logo.txt; do
	ln -sf "$SNAP/share/hollytrek/$f" "$f"
done
exec "$SNAP/bin/hollytrek-bin" "$@"
