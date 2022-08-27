FROM eliorsade/web-server:1.0.3
CMD mkdir /var/www/webosmaster
chmod -R 755 /var/www/webosmaster
COPY ./webosmaster.ga /var/www/webosmaster
CMD a2ensite webosmaster.conf
CMD a2dissite 000-default.conf
CMD service apache2 reload
COPY ./html/* /var/www/webosmaster/
