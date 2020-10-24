FROM centos:centos7

ENV nginxversion="1.14.0-1" \
    os="centos" \
    osversion="7" \
    elversion="7_4"

RUN yum install -y wget openssl sed &&\
    yum -y autoremove &&\
    yum clean all &&\
    wget http://nginx.org/packages/$os/$osversion/x86_64/RPMS/nginx-$nginxversion.el$elversion.ngx.x86_64.rpm &&\
    rpm -iv nginx-$nginxversion.el$elversion.ngx.x86_64.rpm &&\
    mkdir -p /data/www

COPY nginx.conf /etc/nginx/nginx.conf
COPY secret.123.key /secret.123.key

ENV PASSPHRASE="123" 

RUN cd /data/www/ \ 
	&& yum install -y wget createrepo gnupg2 \    
	&& wget 'https://rpms.remirepo.net/enterprise/7/safe/x86_64/aspell-bn-0.01.1-5.el7.remi.x86_64.rpm' \
	&& createrepo . \
	&& gpg --batch --import /secret.123.key 
# All in all this does not work with old centos7 gpg, so no repository signing :(
#
#	&& echo '123' | gpg --pinentry-mode loopback --command-fd 0  --batch --detach-sign --armor --default-key 'nasibullin@nasibullin.com'  ./repodata/repomd.xml
#

RUN echo '[repository]' > /data/www/yumrepo7.repo \
	&& echo 'name=yumrepo7' >> /data/www/yumrepo7.repo \
	&& echo 'baseurl=http://yumrepo7:80/' >> /data/www/yumrepo7.repo 

EXPOSE 80

CMD ["nginx", "-g", "daemon off;"]
