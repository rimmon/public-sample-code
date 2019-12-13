#!/bin/sh
/usr/bin/php /root/bin/update_dns.php --name oasis      --ip eth0
/usr/bin/php /root/bin/update_dns.php --name phpmyadmin --ip eth0
/usr/bin/php /root/bin/update_dns.php --name lab        --ip eth0
#
/usr/bin/php /root/bin/update_dns.php --name ci         --ip 172.30.0.135
