# 内存耗用：VSS/RSS/PSS/USS

术语：

* VSS- Virtual Set Size 虚拟耗用内存（包含共享库占用的内存）
* RSS- Resident Set Size 实际使用物理内存（包含共享库占用的内存）
* PSS- Proportional Set Size 实际使用的物理内存（比例分配共享库占用的内存）
* USS- Unique Set Size 进程独自占用的物理内存（不包含共享库占用的内存）

一般来说内存占用大小有如下规律：VSS >= RSS >= PSS >= USS

```txt
Overview
The aim of this post is to provide information that will assist in interpreting memory reports from various tools so the true memory usage for Linux processes and the system can be determined.

Android has a tool called procrank (/system/xbin/procrank), which lists out the memory usage of Linux processes in order from highest to lowest usage. The sizes reported per process are VSS, RSS, PSS, and USS.

For the sake of simplicity in this description, memory will be expressed in terms of pages, rather than bytes. Linux systems like ours manage memory in 4096 byte pages at the lowest level.

VSS (reported as VSZ from ps) is the total accessible address space of a process.This size also includes memory that may not be resident in RAM like mallocs that have been allocated but not written to. VSS is of very little use for determing real memory usage of a process.

RSS is the total memory actually held in RAM for a process.RSS can be misleading, because it reports the total all of the shared libraries that the process uses, even though a shared library is only loaded into memory once regardless of how many processes use it. RSS is not an accurate representation of the memory usage for a single process.

PSS differs from RSS in that it reports the proportional size of its shared libraries, i.e. if three processes all use a shared library that has 30 pages, that library will only contribute 10 pages to the PSS that is reported for each of the three processes. PSS is a very useful number because when the PSS for all processes in the system are summed together, that is a good representation for the total memory usage in the system. When a process is killed, the shared libraries that contributed to its PSS will be proportionally distributed to the PSS totals for the remaining processes still using that library. In this way PSS can be slightly misleading, because when a process is killed, PSS does not accurately represent the memory returned to the overall system.

USS is the total private memory for a process, i.e. that memory that is completely unique to that process.USS is an extremely useful number because it indicates the true incremental cost of running a particular process. When a process is killed, the USS is the total memory that is actually returned to the system. USS is the best number to watch when initially suspicious of memory leaksin a process.

For systems that have Python available, there is also a nice tool calledsmem that will report memory statistics including all of these categories.
```
