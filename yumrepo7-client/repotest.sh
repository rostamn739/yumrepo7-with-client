#!/bin/bash

yum-config-manager -y --add-repo http://yumrepo7/
yum refresh -y

yum install -y --nogpgcheck  --downloadonly --disablerepo=\* --enablerepo=yumrepo7_ --downloaddir=/ aspell-bn
ls /

runuser -u root -- /bin/bash
