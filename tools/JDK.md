
# JDK
refer to https://www.linuxuprising.com/2019/04/install-latest-openjdk-12-11-or-8-in.html
Azul Systems provides tested, certified builds of OpenJDK, under the name of Zulu. Zulu is free and open source software (and freely redistributable), and offers up to date OpenJDK builds of Java 17, 16, 15, 13, 11, 8, and 7.
# Table of contents
1. [Download / install Zulu OpenJDK](#Instance_Configuration)
2. [Some paragraph](#paragraph1)
    1. [Sub paragraph](#subparagraph1)
3. [Another paragraph](#paragraph2)

## Download / install Zulu OpenJDK 17, 16, 15, 13, 11, 8 or 7 in Ubuntu, Debian, Linux Mint, RHEL, etc.
Zulu OpenJDK 17, 16, 15, 13, 11, 8 or 7 builds for Windows, macOS and Linux can be downloaded from this page. On Linux there are binaries available as DEB, RPM and .tar.gz (64bit).

Zulu OpenJDK is also available in repositories (for 64bit only) provided by Azul Systems, for Debian, Ubuntu and other Debian or Ubuntu based Linux distributions like Linux Mint, elementary OS and so on, as well as RHEL, Oracle Linux or SLES.

### Sub paragraph <a name="subparagraph1"></a>
This is a sub paragraph, formatted in heading 3 style

## Another paragraph <a name="paragraph2"></a>
The second paragraph text
========================================

## Instance Configuration <a name="Instance_Configurationn"></a>
Jenkins URL: | http://192.168.178.54:8080/
------------ | ---------------------------
password | in /var/log/jenkins/jenkins.log

## Install Jenkins
Refer to https://www.digitalocean.com/community/tutorials/how-to-install-jenkins-on-ubuntu-20-04-de or https://tecadmin.net/how-to-install-jenkins-on-ubuntu-20-04/
**Steps**
- [ ] install jenkins to pi by referring to last link


```properties
wget -q -O - https://pkg.jenkins.io/debian-stable/jenkins.io.key | sudo apt-key add -
``` 
OK as result

```properties
sudo sh -c 'echo deb http://pkg.jenkins.io/debian-stable binary/ > /etc/apt/sources.list.d/jenkins.list'
```
then
```properties
sudo apt update
```
then
```properties
sudo apt install jenkins
```
then
```properties
sudo systemctl start jenkins
sudo systemctl status jenkins
sudo ufw allow 8080
sudo ufw status
sudo cat /var/lib/jenkins/secrets/initialAdminPassword
6ff9e649de834a73bc9dc0da91318a3b
```
## Create first Admin User
Column | input
------ | -----
Username | pi
Password | über500
Email | net.support@xiang-liang.de

## add python plugins
Configuration Jenkins > Global Tool Configuration
plugins | usage
------- | -----
Python | ability to execute python
ShiningPanda | ?
Pyenv Pipeline | ?
