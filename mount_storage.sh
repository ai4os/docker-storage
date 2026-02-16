# Obscure the RCLONE password on behalf of the user
export RCLONE_CONFIG_RSHARE_PASS=$(rclone obscure $RCLONE_CONFIG_RSHARE_PASS)

rclone mount $REMOTE_PATH $LOCAL_PATH --allow-non-empty --allow-other --vfs-cache-mode minimal

# FLAGS:
# * "allow-non-empty": needed starting from 1.57
#    https://forum.rclone.org/t/1-57-seems-to-cause-directory-already-mounted-use-allow-non-empty-to-mount-anyway-error-under-docker/27387
# * "allow-other":
#    https://stackoverflow.com/questions/50817985/docker-tries-to-mkdir-the-folder-that-i-mount/61686833#61686833
# * "vfs-cache-mode": needed to save streaming objects (e.g. "command >> /storage/log.txt"). Still the log will only save when the file is closed (the command completed)
#    Minimal was chosen for increased compatibility while still maintaining low disk usage.
#    https://rclone.org/commands/rclone_mount/#vfs-file-caching
