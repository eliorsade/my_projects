FROM levintovich/myfirstwebserver:latest

COPY ./index.html /var/www/html/
CMD ["/usr/sbin/apachectl", "-D", "FOREGROUND"]
