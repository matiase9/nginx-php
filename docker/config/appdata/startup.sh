#!/bin/sh
#
# Set the correct file permissions for Magento 2

PATH_ROOT_SITE="/var/www/html"

while true;
do
	# Change group to 33 (www-data inside the container)
	chgrp 33 $PATH_ROOT_SITE
	chgrp 33 $PATH_ROOT_SITE/bin/magento

	for D in $(ls $PATH_ROOT_SITE); do
        chgrp -R 33 "$PATH_ROOT_SITE/${D}"

        find "$PATH_ROOT_SITE/${D}" -type d -exec chmod ug+rwx {} \; # Make folders traversable and read/write
		find "$PATH_ROOT_SITE/${D}" -type f -exec chmod ug+rw {} \;  # Make files read/write 
	done

	chmod 775 $PATH_ROOT_SITE/bin/magento

  sleep 1800 # 30 minutes
done