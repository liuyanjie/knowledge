# Commands

* [Bash Reference Manual](https://www.gnu.org/software/bash/manual/html_node/index.html)
* [Shell & Utilities](http://pubs.opengroup.org/onlinepubs/9699919799/utilities/contents.html)

## 用户相关

相关文件

* /etc/passwd - 账户信息
* /etc/shadow - 密码信息
* /etc/group - 组信息
* /etc/default/useradd
* /etc/login.defs
* /etc/skel

用户管理

* adduser - 创建用户
* useradd - 它会添加这个用户名，并创建和用户名相同的组名，但它并不在/home目录下创建基于用户名的目录,也不提示创建新的密码
* usermod - 修改用户的基本信息
* userdel - 删除用户

组管理

* groupadd - 创建组
* groupmod - 修改组
* groupdel - 删除组
* groups - 输出指定用户所在组的组成员
* groupmems - 更改和查看组成员
* gpasswd - 管理组，将用户从组中添加、删除

账密

* passwd - 设置用户的认证信息，包括用户密码、密码过期时间等
* chage - 用来修改帐号和密码的有效期限
* chpasswd - 批量更新用户口令

登入登出

* login - 登入
* logout - 登出
* newgrp - 指令类似login指令，当它是以相同的帐号，另一个群组名称，再次登入系统

切换用户

* su - 在已登录的会话中切换到另外一个用户。
* sudo - sudo 命令需要输入当前用户的密码，su 命令需要输入 root 用户的密码。就安全而言，sudo 命令更好。

登录信息

* logname - 查看登录名
* whoami - 查看当前登录到系统的用户的名字
* users - 查看当前登录到系统的所有用户的名字
* who - 查看当前谁登录到系统
* w - 查看当前的登录用户以及在做什么
* ac - 统计的用户登录时间

登录记录

* id - 打印真实和有效的UID和GID信息
* last - 显示系统用户最近的登录信息
* lastb - 显示错误的尝试登录信息
* lastlog - 显示系统所有的用户最近的登录信息

账密系统管理

* pwck - 命令用来验证系统认证文件 `/etc/passwd` 和 `/etc/shadow` 的内容和格式的完整性
* pwconv - 命令用来开启用户的投影密码
* pwunconv - 命令与 `pwconv` 功能相反，用来关闭用户的投影密码，它会把密码从 `shadow` 文件内，重回存到 `passwd` 文件里

* grpck - 命令用于验证组文件的完整性，在验证之前，需要先锁定（lock）组文件 `/etc/group` 和 `/etc/shadow`
* grpconv - 命令用来开启群组的投影密码
* grpunconv - 命令用来关闭群组的投影密码，它会把密码从 `gshadow` 文件内，回存到 `group` 文件里

用户配置信息

* umask - 设置权限掩码
* chsh - change shell
* chfn - change finger
* chacl - 更改文件或目录的访问控制列表的命令，其和chmod功能很像。但是比chmod更为强大，更为精细。
* finger 命令用于查找并显示用户信息。

* nologin 命令可以实现礼貌地拒绝用户登录系统，同时给出信息。

## 目录及文件

目录栈

* dirs - 显示目录栈
* pushd - 将当前目录加入目录栈
* popd - 删除目录栈中的记录

目录

* ls - 显示目录内容列表
* tree - 树状图列出目录的内容
* cd - 切换用户当前工作目录
* pwd - 绝对路径方式显示用户当前工作目录
* mkdir - 用来创建目录
* rmdir - 用来删除目录
* touch - 创建新的空文件
* rm - 用于删除给定的文件和目录
* rename - 用字符串替换的方式批量改变文件名
* dd - 复制文件并对原文件的内容进行转换和格式化处理

* dirname 去除文件名中的非目录部分
* basename 打印目录或者文件的基本名称

符号链接

* ln - 用来为文件创件连接
* unlink - 系统调用函数unlink去删除指定的文件

ACL权限控制

* getfacl - 查看文件或目录的访问控制列表
* setfacl - 设置文件或目录的访问控制列表

文件属性（元信息）

* stat 用于显示文件的状态信息
* chown - change owner
* chgrp - change group
* chmod - change mode
* chcon - 修改对象（文件）的安全上下文，比如：用户、角色、类型、安全级别。
* chattr - 改变文件属性
* lsattr - 查看文件的第二扩展文件系统属性

文件拷贝

* cp - 用来将一个或多个源文件或者目录复制到指定的目的文件或目录
* scp - 加密的方式在本地主机和远程主机之间复制文件
* rcp - 使在两台Linux主机之间的文件复制操作更简单

文件查找

* find - 在指定目录下查找文件
* locate/slocate - 查找文件或目录
* updatedb - 创建或更新slocate命令所必需的数据库文件
* whereis - 命令只能用于程序名的搜索，而且只搜索二进制文件（参数-b）、man说明文件（参数-m）和源代码文件（参数-s）。
* which - 命令的作用是，在PATH变量指定的路径中，搜索某个系统命令的位置，并且返回第一个搜索结果。

文件内容信息

* file 用来探测给定文件的类型

文件内容查看

* cat - 连接文件并打印到标准输出设备上
* head - 在屏幕上显示指定文件的开头若干行
* tail - 在屏幕上显示指定文件的末尾若干行
* more - 显示文件内容，每次显示一屏
* less - 分屏上下翻页浏览文件内容

文件内容查看

* expand - 将文件的制表符转换为空白字符
* unexpand - 将文件的空白字符转换为制表符
* strings - 在对象文件或二进制文件中查找可打印的字符串
* hexdump - 显示文件十六进制格式
* od - 输出文件的八进制、十六进制等格式编码的字节
* nl - 带行号显示文件内容
* tac - 将文件已行为单位的反序输出
* rev - 将文件内容以字符为单位反序输出
* sort - 将文件进行排序并输出

文件内容转换

* iconv - 转换文件的编码方式
* tr - 转换或者删除一段文字

文件内容过滤

* col - 过滤控制字符
* colrm - 删除文件中的指定列

文件内容统计

* wc - 统计文件的字节数、字数、行数
* uniq - 报告或忽略文件中的重复行

文件内容查找

* grep
* fgrep
* egrep - 在文件内查找指定的字符串
* look - 显示文件中以指定字符串开头的任意行

文件内容检查

* spell - 对文件进行拼写检查
* ispell - 检查文件中出现的拼写错误

文件内容分割

* split - 分割任意大小的文件
* csplit - 将一个大文件分割成小的碎片文件

文件内容拼接

* join - 两个文件中指定栏位内容相同的行连接起来

文件比较

* cmp - 比较两个文件是否有差异
* comm - 两个文件之间的比较
* diff - 比较给定的两个文件的不同
* diff3 - 用于比较3个文件，将3个文件的不同的地方显示到标准输出
* diffstat - 显示diff命令输出信息的柱状图

文本分析工具

* awk - 强大的文本分析工具
* nawk
* gawk

文件内容编辑（流式）

* sed - 功能强大的流式文本编辑器

文件内容编辑（交互式）

* vi - 功能强大的纯文本编辑器
* ex - 启动vim编辑器的ex编辑模式
* ed - 单行纯文本编辑器
* joe - 强大的纯文本编辑器
* jed - 主要用于编辑代码的编辑器
* nano - 字符终端文本编辑器
* pico - 功能强大全屏幕的文本编辑器
* emacs - 功能强大的全屏文本编辑器

文件打包解包压缩解压

* tar
* pack - 打包
* unpack - 解包
* pcat - 输出包内容

文件压缩解压

* compress
* uncompress

文件压缩解压（zip）

* zip
* zipsplit
* zipinfo
* zipcloak
* zipgrep
* zipnote
* unzip

文件压缩解压（gzip）

* gzip - 用来压缩文件。文件经它压缩过后，其名称后面会多处“.gz”扩展名
* gunzip - 用来解压缩文件
* zcat - 用于不真正解压缩文件，就能显示压缩包中文件的内容的场合
* zfore - 强制为gzip格式的压缩文件添加“.gz”后缀
* znew - 用于将使用compress命令压缩的“.Z”压缩包重新转化为使用gzip命令压缩的“.gz”压缩包
* gzexe - 用来压缩可执行文件，压缩后的文件仍然为可执行文件，在执行时进行自动解压缩

文件压缩解压（bzip）

* bzip2
* bzip2recover
* bunzip2

文件压缩解压（bz）

* bzcat
* bzdiff
* bzcmp
* bzgrep
* bzmore
* bzless
* bzr_prompt_info

文件压缩解压（xz）

* xz - xz 是一个使用LZMA压缩算法的无损数据压缩文件格式

文件压缩解压（7z）

* 7z - LZMA and LZMA2 https://www.7-zip.org/

## 网络相关

URL

* curl
* wget

IP

* ipcalc - 简单的ip地址计算器，可以完成简单的IP地址计算任务

远程登录

* ssh
* telnet
* rlogin - 从当前终端登录到远程Linux主机
* rexec - 用于在指定的远程Linux系统主机上执行命令，向远程rexec服务器发出执行命令的请求
* rsh - 用于连接到远程的指定主机并执行指定的命令

IPtables

* iptstate
* iptables
* iptables-save
* iptables-restore

Network Diagnostic Tool

* ping
* mtr - [Linux网络诊断工具：MTR](https://www.zhukun.net/archives/7636)
* tracert
* traceroute
* tracepath
* hping3 - 用于生成和解析TCPIP协议数据包的开源工具，是安全审计、防火墙测试等工作的标配工具。
* tcpdump - 对网络上的数据包进行截获的包分析工具
* nc/netcat - netcat(简写是nc)是linux上非常有用的网络工具，它能通过TCP和UDP在网络中读写数据
* lnstat
* nstat/rtacct
* ss
* netstat
* iperf
* iptraf
* ifstat
* iftop
* atop
* htop
* iotop

```txt
[Linux 下大家喜欢用什么命令查看流量？](https://www.zhihu.com/question/19862245)
监控总体带宽使用――nload、bmon、slurm、bwm-ng、cbm、speedometer和netload
监控总体带宽使用（批量式输出）――vnstat、ifstat、dstat和collectl
每个套接字连接的带宽使用――iftop、iptraf、tcptrack、pktstat、netwatch和trafshow
每个进程的带宽使用――nethogs
```

Network Manager

* nmap - 网络探测和安全审核，用于在远程机器上探测网络，执行安全扫描，网络审计和搜寻开放端口。
* nmcli - 地址配置工具

DomainName

* nisdomainname
* dnsdomainname
* ypdomainname
* domainname

NIS (Network Information Services)

* hostname
* route
* ip

WHOIS

* whois

DNS

* host
* dig
* nslookup

[IW](https://hewlettpackard.github.io/wireless-tools/Tools.html)

* iwconfig
* iwlist
* iwspy
* iwpriv

IF

* ifrename - 网络接口重命名脚本。如果您有十块网卡，您应该开启它
* ifconfig
* ifcfg
* ifdown
* ifup
* ifplugstatus@ifplugd

[DHCP](https://en.wikipedia.org/wiki/Dynamic_Host_Configuration_Protocol)

* dhclient
* dhcpd
* dhcrelay

[ARP/RARP](https://en.wikipedia.org/wiki/Address_Resolution_Protocol)

* arp
* arping
* arpwatch
* arptables
* arpd
* rarp
* ethtool

FTP

* ftp
* tftp
* lftp
* lftpget
* ftpwho
* ftptop
* ftpcount
* ftpshut

MAIL

* mail
* mailstat
* mailq
* sendmail
* elm

SMB

* smbclient
* smbpassword

## 进程管理

* ps
* pstree
* pgrep
* pidof
* top
* htop
* atop
* sleep
* nice
* renice
* fg
* bg
* jobs
* at
* nohup
* chroot
* chrt
* time
* date
* vmstat
* dstat
* watch 命令以周期性的方式执行给定的指令，指令输出以全屏方式显示。
* kill
* skill 命令用于向选定的进程发送信号，冻结进程。
* killall 命令使用进程的名称来杀死进程，使用此指令可以杀死一组同名进程。
* pkill 命令可以按照进程名杀死进程。
* batch 命令用于在指定时间，当系统不繁忙时执行任务，用法与at相似。
* at 命令用于在指定时间执行命令。at允许使用一套相当复杂的指定时间的方法。
* atq 命令显示系统中待执行的任务列表，也就是列出当前用户的at任务列表。
* atrm 命令用于删除待执行任务队列中的指定任务。
* crontab 命令被用来提交和管理用户的需要周期性执行的任务

## 内存相关

* procrank
* procmem
* meminfo
* vmstat

## 包管理

* dpkg-query
* dpkg-preconfigure
* dpkg-trigger
* dpkg-deb
* dpkg-divert
* dpkg-reconfigure
* dpkg-statoverride
* dpkg
* apt-get
* apt-key
* apt-sortpkgs
* aptitude
* rpm2cpio
* rpmbuild
* rpmdb
* rpmsign
* rpm
* yum
* dnf

## 文件系统

### 磁盘文件系统

[E2fsprogs](https://zh.wikipedia.org/wiki/E2fsprogs)

ext2，ext3，ext4，xfs，btrfs，reiserfs，jfs，swap

1. Linux文件系统：ext2，ext3，ext4，xfs，btrfs，reiserfs，jfs，swap

    * swap：交换分区
    * 光盘：iso9660
    * Unix：FFS,UFS,JFS2
    * 网络文件系统：NFS,CIFS
    * 系群文件系统：GFS2,OCFS2
    * 分布式文件系统：ceph，moosefs，mogilefs，GlusterFS，Lustre

    根据其是否支持“journal”功能分为：

    * 日志型文件系统：ext3，ext4，xfs….
    * 非日志型文件系统：ext2，vfat….

1. 文件系统的组成部分：

    * 内核中的模块：ext4,xfs,vfat
    * 用户空间的管理工具：mkfs.ext,mkfs.xfs,mkfs.vfat
    * Linux的虚拟文件系统：VFS

命令：

* dump 用于备份ext2或者ext3文件系统
* restore 所进行的操作和dump指令相反
* fsck 命令被用于检查并且试图修复文件系统中的错误。
* mkswap 创建交换分区
* swapon  挂载交换分区
* swapoff 关闭交换分区
* mount 命令用于加载文件系统到指定的加载点。
* umount 文件系统的卸载。
* mountpoint 命令用来判断指定的目录是否是加载点，如果是挂载点返回0，如果不是就返回非0。
* quotaon 命令用于激活Linux内核中指定文件系统的磁盘配额功能。
* quotaoff 命令用于关闭Linux内核中指定文件系统的磁盘配额功能。
* quotastats 命令用于显示Linux系统当前的磁盘配额运行状态信息。
* quotacheck 命令通过扫描指定的文件系统，获取磁盘的使用情况，创建、检查和修复磁盘配额（quota）文件。
* edquota 命令用于编辑指定用户或工作组磁盘配额。
* repquota 命令以报表的格式输出指定分区，或者文件系统的磁盘配额信息。

### LVM

* lvcreate 命令用于创建LVM的逻辑卷。逻辑卷是创建在卷组之上的。
* lvremove 命令用于删除指定LVM逻辑卷。如果逻辑卷已经使用mount命令加载，则不能使用lvremove命令删除。
* lvextend 命令用于在线扩展逻辑卷的空间大小，而不中断应用程序对逻辑卷的访问。
* lvresize 命令用于调整LVM逻辑卷的空间大小，可以增大空间和缩小空间。
* lvdisplay 命令用于显示LVM逻辑卷空间大小、读写状态和快照信息等属性。
* lvscan   命令用于扫描当前系统中存在的所有的LVM逻辑卷。

* pvs 命令用于输出格式化的物理卷信息报表。
* pvcreate 命令用于将物理硬盘分区初始化为物理卷，以便LVM使用。
* pvremove 命令用于删除一个存在的物理卷。
* pvchange 命令允许管理员改变物理卷的分配许可。如果物理卷出现故障，可以使用pvchange命令禁止分配物理卷上的PE。
* pvdisplay 命令用于显示物理卷的属性。物理卷信息包括：物理卷名称、所属的卷组、物理卷大小、PE大小、总PE数、可用PE数、已分配的PE数和UUID。
* pvscan 命令会扫描系统中连接的所有硬盘，列出找到的物理卷列表。
* pvck 命令用来检测物理卷的LVM元数据的一致性。

* vgcreate 命令用于创建LVM卷组。
* vgremove 命令用于用户删除LVM卷组。
* vgextend 命令用于动态扩展LVM卷组，它通过向卷组中添加物理卷来增加卷组的容量。
* vgchange 命令用于修改卷组的属性，经常被用来设置卷组是处于活动状态或非活动状态。
* vgconvert 命令用于转换指定LVM卷组的元数据格式，通常将“LVM1”格式的卷组转换为“LVM2”格式。
* vgreduce 命令通过删除LVM卷组中的物理卷来减少卷组容量。
* vgdisplay 命令用于显示LVM卷组的信息。
* vgscan 命令查找系统中存在的LVM卷组，并显示找到的卷组列表。

* blockdev 命令在命令调用“ioxtls”函数，以实现对设备的控制。
* blkid 查看块设备的文件系统类型、LABEL、UUID等信息
* lsblk 命令用于列出所有可用块设备的信息，而且还能显示他们之间的依赖关系，但是它不会列出RAM盘的信息。

* badblock 命令用于查找磁盘中损坏的区块。硬盘是一个损耗设备，当使用一段时间后可能会出现坏道等物理故障。
* fdisk 命令用于观察硬盘实体使用情况，也可对硬盘分区。
* sfdisk 硬盘分区工具程序，可显示分区的设定信息，并检查分区是否正常。
* parted 命令是由GNU组织开发的一款功能强大的磁盘分区和分区大小调整工具，与fdisk不同，它支持调整分区的大小。
* partprobe 命令用于重读分区表，当出现删除文件后，出现仍然占用空间。可以partprobe在不重启的情况下重读分区。

* mkisofs 命令用来将指定的目录与文件做成ISO 9660格式的映像文件，以供刻录光盘。
* mkbootdisk 命令用来为当前运行的系统创建能够单独使用的系统引导软盘，以便在系统出现故障时能够启动操作进行适当的修复工作。
* mkinitrd 命令建立要载入ramdisk的映像文件，以供Linux开机时载入ramdisk。
* mknod 命令用于创建Linux中的字符设备文件和块设备文件。
* mkswap 命令用于在一个文件或者设备上建立交换分区。在建立完之后要使用sawpon命令开始使用这个交换区。
* convertquota 命令用于将老的磁盘额数据文件（“quota.user”和“quota.group”）转换为新格式的文件

* hdparm 命令提供了一个命令行的接口用于读取和设置IDE或SCSI硬盘参数。

* hwclock 命令是一个硬件时钟访问工具，它可以显示当前时间、设置硬件时钟的时间和设置硬件时钟为系统时间，也可设置系统时间为硬件时钟的时间。

## 设备管理

[使用 udev 高效、动态地管理 Linux 设备文件](https://www.ibm.com/developerworks/cn/linux/l-cn-udev/index.html)

> mem proc sysfs devfs udev udevadm

## 硬件设备管理

* arch 命令用于显示当前主机的硬件架构类型。
* lspci 命令用于显示当前主机的所有PCI总线信息，以及所有已连接的PCI设备信息。
* setpci 命令是一个查询和配置PCI设备的使用工具。
* systool 命令指令显示基于总线、类和拓扑显示系统中设备的信息。
* dmidecode 命令可以让你在Linux系统下获取有关硬件方面的信息。
* volname 命令用于显示指定的“ISO-9660”格式的设备的卷名称，通常这种格式的设备为光驱。
* lsusb 命令用于显示本机的USB设备列表，以及USB设备的详细信息。

## 系统管理

* syslog 是Linux系统默认的日志守护进程。默认的syslog配置文件是 `/etc/syslog.conf` 文件。

* logrotate 命令用于对系统日志进行轮转、压缩和删除，也可以将日志发送到指定邮箱。
* logsave 命令运行给定的命令，并将命令的输出信息保存到指定的日志文件中。
* logwatch 命令是一个可定制和可插入式的日志监视系统，它通过遍历给定时间范围内的系统日志文件而产生日志报告。

* ipcs 命令用于报告Linux中进程间通信设施的状态，显示的信息包括消息列表、共享内存和信号量的信息。
* ipcrm 命令用来删除一个或更多的消息队列、信号量集或者共享内存标识。

* systemctl 命令是系统服务管理器指令，它实际上将 `service` 和 `chkconfig` 这两个命令组合到一起。
* service 命令是Redhat Linux兼容的发行版中用来控制系统服务的实用工具，它以启动、停止、重新启动和关闭系统服务，还可以显示所有系统服务的当前状态。
* chkconfig

* seinfo 命令是用来查询SELinux的策略提供多少相关规则
* semanage 命令是用来查询与修改SELinux默认目录的安全上下文。
* sesearch 使用seinfo命令可以查询SELinux的策略提供多少相关规则，如果查到的相关类型或者布尔值，想要知道详细规则时，使用sesearch命令查询。
* getsebool 命令是用来查询SElinux策略内各项规则的布尔值。
* setsebool 命令是用来修改SElinux策略内各项规则的布尔值。

* chcon 命令是修改对象（文件）的安全上下文，比如：用户、角色、类型、安全级别。
* restorecon 命令用来恢复SELinux文件属性即恢复文件的安全上下文。

* findfs 命令依据卷标（Label）和UUID查找文件系统所对应的设备文件。

* poweroff 命令用来关闭计算机操作系统并且切断系统电源。
* halt 命令用来关闭正在运行的Linux操作系统。halt命令会先检测系统的runlevel，若runlevel为0或6，则关闭系统，否则即调用shutdown来关闭系统。
* shutdown 命令用来系统关机命令。shutdown指令可以关闭所有程序，并依用户的需要，进行重新开机或关机的动作。
* reboot 命令用来重新启动正在运行的Linux操作系统。
* ctrlaltdel 命令用来设置组合键“Ctrl+Alt+Del”的功能。

* telint 命令用于切换当前正在运行的Linux系统的运行等级。
* runlevel 命令用于打印当前Linux系统的运行等级。
* init 命令是Linux下的进程初始化工具，init进程是所有Linux进程的父进程，它的进程号为1。

* lsb_release 命令用来显示LSB和特定版本的相关信息。
* uname 命令用于打印当前系统相关信息（内核版本号、硬件架构、主机名称和操作系统类型等）。

* modprobe 命令用于智能地向内核中加载模块或者从内核中移除模块。
* insmod 命令用于将给定的模块加载到内核中。Linux有许多功能是通过模块的方式，在需要时才载入kernel。
* rmmod 命令用于从当前运行的内核中移除指定的内核模块。
* depmod 命令可产生模块依赖的映射文件，在构建嵌入式系统时，需要由这个命令来生成相应的文件，由modprobe使用。
* lsmod 命令用于显示已经加载到内核中的模块的状态信息。
* bmodinfo 命令用于显示给定模块的详细信息。
* get_module 命令用于获取Linux内核模块的详细信息。
* dmesg 命令被用于检查和控制内核的环形缓冲区。kernel会将开机信息存储在ring buffer中。您若是开机时来不及查看信息，可利用dmesg来查看。
* kexec 命令是Linux内核的一个补丁，让您可以从当前正在运行的内核直接引导到一个新内核。
* lilo 命令用于安装核心载入，开机管理程序。lilo是个Linux系统核心载入程序，同时具备管理开机的功能。

* sysctl 时动态地修改内核的运行参数

* login 命令用于给出登录界面，可用于重新登录或者切换用户身份，也可通过它的功能随时更换登入身份。
* logout 命令用于退出当前登录的Shell，logout指令让用户退出系统，其功能和login指令相互对应。

* inotify-tools
* inotifywait
* inotifywatch

* fuser 命令用于报告进程使用的文件和网络套接字
* lsof 命令用于查看你进程开打的文件，打开文件的进程，进程打开的端口(TCP、UDP)。找回/恢复删除的文件。

* uptime 命令能够打印系统总共运行了多长时间和系统的平均负载。
* mpstat 命令指令主要用于多CPU环境下，它显示各个可用CPU的状态系你想。
* ifstat 统计网络接口流量状态
* iostat 命令被用于监视系统输入输出设备和CPU的使用情况。
* vmstat 命令的含义为显示虚拟内存状态（“Viryual Memor Statics”），但是它可以报告关于进程、内存、I/O等系统整体运行状态。
* netstat 命令用来打印Linux中网络系统的状态信息，可让你得知整个Linux系统的网络情况。
* nfsstat 命令用于列出NFS客户端和服务器的工作状态。
* dstat 通用的系统资源统计工具
* sar 命令是Linux下系统运行状态统计工具，它将指定的操作系统状态计数器显示到标准输出设备。

* tload 命令以图形化的方式输出当前系统的平均负载到指定的终端。
* iotop 用来监视磁盘I/O使用状况的工具
* slabtop 命令以实时的方式显示内核“slab”缓冲区的细节信息。
* top 命令可以实时动态地查看系统的整体运行情况，是一个综合了多方信息监测系统性能和运行信息的实用工具。

* grub 命令是多重引导程序grub的命令行shell工具。

* free 命令可以显示当前系统未使用的和已使用的内存数目，还可以显示被内核使用的内存缓冲区。

* ntsysv 命令提供了一个基于文本界面的菜单操作方式，集中管理系统不同的运行等级下的系统服务启动状态。
* clockdiff 程序正是使用时间戳来测算目的主机和本地主机的系统时间差。
* ntpdate 命令是用来设置本地日期和时间。

* startx
* xhost
* xlsatoms
* xlsfonts
* xauth
* xinit
* xset
* xlsclients

* /etc/hosts
* /etc/host.conf
* /etc/resolv.conf
* /etc/services
* /etc/xinetd.d

## 实用工具

* screen 是一款由GNU计划开发的用于命令行终端切换的自由软件。
* speedtest-cli 是一个使用python编写的命令行脚本，通过调用speedtest.net测试上下行的接口来完成速度测试，最后我会测试运维生存时间所在服务器的外网速度。

## Shell

* sh 命令是shell命令语言解释器，执行命令从标准输入读取或从一个文件中读取。

* help 命令用于显示shell内部命令的帮助信息。

* type 命令用来显示指定命令的类型，判断给出的指令是内部指令还是外部指令。

* enable 命令用于临时关闭或者激活指定的shell内部命令。
* disable
* builtin 命令用于执行指定的shell内部命令，并返回内部命令的返回值。 man builtin

* shopt 命令用于显示和设置shell中的行为选项，通过这些选项以增强shell易用性。

* alias 命令用来设置指令的别名。
* unalias 命令用来取消命令别名。

* readonly 命令用于定义只读shell变量和shell函数。
* declare 命令用于声明和显示已存在的shell变量。
* export 命令用于将shell变量输出为环境变量，或者将shell函数输出为环境变量。
* set 显示或设置shell特性及shell变量。
* unset 命令用于删除已定义的shell变量（包括环境变量）和shell函数。

* env 命令用于显示系统中已存在的环境变量，以及在定义的环境中执行指令。

* command 命令调用指定的指令并执行，命令执行时不查询shell函数。command命令只能够执行shell内部的命令。
* exec 命令用于调用并执行指令的命令。exec命令通常用在shell脚本程序中，可以调用其他的命令。如果在当前终端中使用命令，则当指定的命令执行完毕后会立即退出终端。
* exit 命令同于退出shell，并返回给定值。

* bg 命令用于将作业放到后台运行，使前台可以执行其他任务。
* fg 命令用于将后台作业（在后台运行的或者在后台挂起的作业）放到前台终端运行。

* strace 跟踪系统调用和信号。
* ltrace 用来跟踪进程调用库函数的情况。

* ulimit 命令用来限制系统用户对shell资源的访问。

* let 简单的计算器。
* trap 指定在接收到信号后将要采取的动作。
* seq 以指定增量从首数开始打印数字到尾数。
* read 命令从键盘读取变量的值，通常用在shell脚本中与用户进行交互的场合。
* write 命令用于向指定登录用户终端上发送信息。
* wait 命令用来等待指令的指令，直到其执行完毕后返回终端。

* tput 命令将通过 terminfo 数据库对您的终端会话进行初始化和操作。
* apropos 命令在一些特定的包含系统命令的简短描述的数据库文件里查找关键字，然后把结果送到标准输出。

* history 命令用于显示指定数目的指令命令，读取历史命令文件中的目录到历史命令缓冲区和将历史命令缓冲区中的目录写入命令文件。

* time 命令用于统计给定命令所花费的总时间。

* echo 命令用于在shell中打印shell变量的值，或者直接输出指定的字符串。
* printf 格式化输出
* pr 将文本文件转换成适合打印的格式
* tee 把数据重定向到给定文件和屏幕上
* cut 连接文件并打印到标准输出设备上
* fold 控制文件内容输出时所占用的屏幕宽度
* fmt

* which 查找并显示给定命令的绝对路径

* mktemp 命令被用来创建临时文件供shell脚本使用。
* expr 命令是一款表达式计算工具，使用它完成表达式的求值操作。

* test 命令是shell环境中测试条件表达式的实用工具。

* tempfile 命令

* rsync 命令是一个远程数据同步工具，可通过LAN/WAN快速同步多台主机间的文件。
* ngrep 命令是grep命令的网络版，他力求更多的grep特征，用于搜寻指定的数据包。
* xargs 命令是给其他命令传递参数的一个过滤器，也是组合多个命令的一个工具。
* awk 是一种编程语言，用于在linux/unix下对文本和数据进行处理。

* yes 命令在命令行中输出指定的字符串，直到yes进程被杀死。
* date 命令是显示或设置系统时间与日期。
* consoletype 命令用于打印已连接的终端类型到标准输出，并能够检查已连接的终端是当前终端还是虚拟终端。
* hostid 命令用于打印当前主机的十六进制数字标识。
* info 命令是Linux下info格式的帮助指令。
* clear 命令用于清除当前屏幕终端上的任何信息。
* sleep 命令暂停指定的时间。
* md5sum 命令采用MD5报文摘要算法（128位）计算和检查文件的校验和。
* sum 命令用于计算并显示指定文件的校验和与文件所占用的磁盘块数。
* bc 命令是一种支持任意精度的交互执行的计算器语言。
* wall 命令用于向系统当前所有打开的终端上输出信息。
* mesg 命令用于设置当前终端的写权限，即是否让其他用户向本终端发信息。
* talk 命令是talk服务器的客户端工具，通过talk命令可以让用户和其他用户聊天。
* dircolors 命令设置ls命令在显示目录或文件时所用的色彩。
* cksum 命令是检查文件的CRC是否正确，确保文件从一个系统传输到另一个系统的过程中不被损坏。
* cal 命令用于显示当前日历，或者指定日期的日历。
* whatis 命令是用于查询一个命令执行什么功能，并将查询结果打印到终端上。
* stty 命令修改终端命令行的相关设置。

## 编程开发

* ld 命令是GNU的连接器，将目标文件连接为可执行程序。
* ldconfig 命令的用途主要是在默认搜寻目录/lib和/usr/lib以及动态库配置文件/etc/ld.so.conf内所列的目录下，搜索出可共享的动态链接库（格式如lib*.so*）,进而创建出动态装入程序(ld.so)所需的连接和缓存文件。
* ldd 命令用于打印程序或者库文件所依赖的共享库列表。
* nm 命令被用于显示二进制目标文件的符号表。
* gcov 命令是一款测试程序的代码覆盖率的工具。
* gcc 命令使用GNU推出的基于C/C++的编译器，是开放源代码领域应用最广泛的编译器，具有功能强大，编译代码支持性能优化等特点。
* gdb 命令包含在GNU的gcc开发套件中，是功能强大的程序调试器。
* readelf 命令用来显示一个或者多个elf格式的目标文件的信息，可以通过它的选项来控制显示哪些信息。
* objdump 命令是用查看目标文件或者可执行的目标文件的构成的gcc工具。
* make 命令是GNU的工程化编译工具，用于编译众多相互关联的源代码问价，以实现工程化的管理，提高开发效率。
* as 命令GNU组织推出的一款汇编语言编译器，它支持多种不同类型的处理器。
* pstack 命令可显示每个进程的栈跟踪。
* indent 命令可辨识C的原始代码文件，并加以格式化，以方便程序员阅读、修改等操作。
* protoize 命令属于gcc套件，用于为C语言源代码文件添加函数原型，将GNU-C代码转换为ANSI-C代码。
* unprotoize 命令属于gcc套件，用于删除C语言源代码文件中的函数原型。
* patch 命令被用于为开放源代码软件安装补丁程序。
