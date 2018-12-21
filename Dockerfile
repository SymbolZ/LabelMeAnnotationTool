FROM ubuntu:16.04

RUN apt-get update -y &&\
	apt-get install apt-transport-https -y

COPY ./DockerFiles/ubuntu_16.04/99fixbadproxy /etc/apt/apt.conf.d
# update ubuntu config
RUN apt-get update -y

# install dependencies for labelme
RUN apt-get install -y \
 				apache2 \
 				git \
 				libapache2-mod-perl2 \
 				libcgi-session-perl \
 				libapache2-mod-php \
 				make \
 				php  \
				libdbd-mysql-perl 
# Throws error 				
#RUN apt-get install php5 libapache2-mod-php5 -y

# Config apache
RUN a2enmod include
RUN a2enmod rewrite
RUN a2enmod cgi

# apache2 configuration: enabling SSI and perl/CGI scripts  
COPY ./DockerFiles/ubuntu_16.04/000-default.conf /etc/apache2/sites-available/000-default.conf
COPY ./DockerFiles/ubuntu_16.04/apache2.conf /etc/apache2/apache2.conf

#Clone LabelMe,move it and make
RUN mkdir /var/www/html/LabelMeAnnotationTool/
ADD ./labelMe.tar.gz /var/www/html/LabelMeAnnotationTool/

RUN cd /var/www/html/LabelMeAnnotationTool/ && make
RUN chown -R www-data:www-data /var/www/html

# port binding
EXPOSE 80

# run
CMD ["/usr/sbin/apache2ctl", "-D", "FOREGROUND"]
