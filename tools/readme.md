# README

## achieve

howto refer to https://baihuqian.github.io/2019-10-20-how-to-mount-wd-mycloud-on-ubuntu-18-04/

| meaning | definition |
|-----------------|-----------------------|
| Access mycloud to ubuntu: |/media/lnmycloud |
| User should be |net, |
| password should be| uber500. |
| mount command | Sudo mount -a accesses /media/lnmycloud to net@192.168.178.33 |
| very important | first of all, install cifs-utils |


//192.168.178.33/net  /media/lnmycloud  cifs  uid=ubuntu,credentials=/home/ubuntu/.smbcredentials,iocharset=utf8 0 0
