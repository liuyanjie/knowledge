# Git命令工作机制

Git是当前最广泛使用的版本控制系统，具备非常强大的版本控制能力。Git有非常多的命令，很多人被种类繁多的命令搞的非常头大，也会经常忘记。本文尝试从原理角度来介绍Git常用命令，以便于加深对Git原理的理解。只有理解了原理，才能知道这些命令到底对仓库做了什么，进而才能更好使用命令，也更加不容易忘记。作为一个版本控制系统，理解其原理也是十分必要的，否则，有些命令你根本不敢用，因为搞丢代码的成本是非常大的，谁都不想自己或他人做工作被抹除。知道原理后，即使一不小心操作错了，也可以坦然处之，轻松恢复。

## 仓库基础

Git是一个分布式的版本控制系统，这意味着在Git中版本库有 `本地版本库` 和 `远程版本库` 之分。不同于 **svn** 只有一个中心仓库，必须连接到中心仓库才能提交，Git可以随时提交而不依赖于中心仓库，因为你本地就是一个独立的仓库。

每个**原始仓库**可以存在多个仓库副本，仓库副本通常是 `clone` 创建的，仓库副本和原始仓库是上下游关系，这些副本仓库可能在本地，也可能在某台服务器上。**原始仓库**如果托管在托管服务器上，还可以通过 `Fork`（本质也是`clone`）的方式创建很多位于托管服务上的副本，`Fork` 其实并不是Git提供的，而是托管服务提供的。`Fork` 出来的仓库副本**原始仓库**与之间的关系也由托管服务记录和维护的，这些副本仓库都有一个相同的 `上游仓库`（即原始仓库），同时副本仓库也可以继续被 `Fork` 产生多个 `下游仓库`，这些下游仓库可以通过 `PullRequest` 或 `MergeRequest` 向上游仓库发起跨仓库的 `Merge`。**本地仓库**可能是**原始仓库**或**原始仓库**的副本，相对于本地仓库，这些仓库称之为远程仓库，本地仓库通过 `push`、`fetch` 等命令和远程仓库同步。

如果同时一个本地版本库可以同时对应多个远程版本库，多个远程仓库可以是从一个最原始的版本库 `Fork`产生的。

概念：上游仓库、下游仓库、副本仓库、本地仓库。

仓库之间通过 同步 和 合并 产生关系。

正式有如上描述的这些关系，才有如下介绍的这些命令，这些命令也正是为处理并维护这些关系而设计的。从设计者的角度出发，思考设计者应该提供哪些能力。

## 仓库创建

本地仓库对应的远程仓库记录在 `.git/config` 文件中。本地仓库可以与多个的远程仓库 `pull/push` 代码。

### [Init](https://git-scm.com/docs/git-init)

> 创建一个空的 Git 仓库，或者重新初始化一个已经存在的 Git 仓库。

```sh
git init
  [-q | --quiet]
  [--bare]
  [--template=<template_directory>]
  [--separate-git-dir <git dir>]
  [--shared[=<permissions>]]
  [directory]
```

常规方式创建一个仓库：

```sh
$ git init workspace
Initialized empty Git repository in /Users/liuyanjie/git-learn/workspace/.git/

$ tree -ar
.
└── workspace
    └── .git
        ├── refs
        │   ├── tags
        │   └── heads
        ├── objects
        │   ├── pack
        │   └── info
        ├── info
        │   └── exclude
        ├── hooks
        │   ├── update.sample
        │   ├── prepare-commit-msg.sample
        │   ├── pre-receive.sample
        │   ├── pre-rebase.sample
        │   ├── pre-push.sample
        │   ├── pre-commit.sample
        │   ├── pre-applypatch.sample
        │   ├── post-update.sample
        │   ├── fsmonitor-watchman.sample
        │   ├── commit-msg.sample
        │   └── applypatch-msg.sample
        ├── description
        ├── config
        └── HEAD

10 directories, 15 files
```

以上创建的仓库，仓库文件 存放在 工作区目录 `workspace` 的子目录 `.git` 下。

分离的方式创建一个仓库：

```sh
$ git init --separate-git-dir=.tig workspace
Initialized empty Git repository in /Users/liuyanjie/git-learn/.tig/

$ tree -ar
.
├── workspace
│   └── .git
└── .tig
    ├── refs
    │   ├── tags
    │   └── heads
    ├── objects
    │   ├── pack
    │   └── info
    ├── info
    │   └── exclude
    ├── hooks
    │   ├── update.sample
    │   ├── prepare-commit-msg.sample
    │   ├── pre-receive.sample
    │   ├── pre-rebase.sample
    │   ├── pre-push.sample
    │   ├── pre-commit.sample
    │   ├── pre-applypatch.sample
    │   ├── post-update.sample
    │   ├── fsmonitor-watchman.sample
    │   ├── commit-msg.sample
    │   └── applypatch-msg.sample
    ├── description
    ├── config
    └── HEAD

10 directories, 16 files

$ cat workspace/.git
gitdir: /Users/liuyanjie/git-learn/.tig
```

相比常规方式创建仓库，可以看到

1. 分离方式创建仓库 可以将 `仓库(.git)` 和 `工作区目录(workspace)` 分离，常规方式创建的仓库，`仓库(.git)` 就在 `工作区目录(workspace)` 下。
2. 分离方式创建的仓库，在 `工作区目录(workspace)` 下 `.git` 文件不再是仓库目录，而是包含指向仓库路径的一个文件。利用这一特性，可以创建多个工作区共享同一仓库。
3. 仓库文件的目录可以是除了 `.git` 之外的其他的合法的目录名称。

参考在创建的过程中，拷贝了一些的模版文件到 `仓库(.git)` 下，可以在运行的时候通过 `--template=` 或 `GIT_TEMPLATE_DIR` 环境变量 指定模版路径位置，模版示例如下：

```sh
$ tree /usr/local/Cellar/git/2.18.0/share/git-core/templates
/usr/local/Cellar/git/2.18.0/share/git-core/templates
├── description
├── hooks
│   ├── applypatch-msg.sample
│   ├── commit-msg.sample
│   ├── fsmonitor-watchman.sample
│   ├── post-update.sample
│   ├── pre-applypatch.sample
│   ├── pre-commit.sample
│   ├── pre-push.sample
│   ├── pre-rebase.sample
│   ├── pre-receive.sample
│   ├── prepare-commit-msg.sample
│   └── update.sample
└── info
    └── exclude

2 directories, 13 files
```

基于这一点，我们可以已一个参考作为模版，创建另一个仓库，Git 会把模板路径下的文件的复制到新的仓库下。

运行命令时，也可通过以下设置以下环境变量：

* `GIT_DIR=.git` GIT仓库路径
* `GIT_OBJECT_DIRECTORY=$GIT_DIR/objects` GIT对象存储路径
* `GIT_TEMPLATE_DIR=path/to/git-core/templates` 模版路径，命令行参数：`--template`，配置：`init.templateDir`

在一个已经存在的仓库目录中运行 `init` 命令是安全的，它不会覆盖原来已经存在的东西。重新运行 `init` 的主要原因是挑选新添加的模版，或者移动仓库到其他的地方，如果 `--separate-git-dir` 指定的话。

初始化仓库是Git工作流中的第一步，一般情况下，需要两个仓库，一个本地仓库，一个远程仓库。

Init后的 Git 配置：

```ini
[core]
	repositoryformatversion = 0
	filemode = true
	bare = false
	logallrefupdates = true
	ignorecase = true
	precomposeunicode = true
```

只有 `core` 相关的几个配置项

### [Clone](https://git-scm.com/docs/git-clone)

> 克隆仓库到一个新的目录，为每一个被克隆仓库中的分支创建对应的远程追踪分支。然后从克隆仓库的当前活动分支创建并检出初始分支到工作区目录。

```sh
git clone
  [-q] [--quiet]
  [-v] [--verbose]
  [--progress]
  
  [-l] [-s] [--no-hardlinks]
  [-n] [--no-checkout]
  
  [--template=<template_directory>]
  [--separate-git-dir <git-dir>]
  [--bare]
  [--mirror]

  [-c <key>=<value>] [--config <key>=<value>]

  [-o <origin-name>] [--origin <origin-name>]
  [-b <branch-name>] [--branch <branch-name>]
  [--no-tags]
  [-u <upload-pack>]

  [--depth <depth>]
  [--shallow-since=<date>]
  [--shallow-exclude=<revision>]

  [--[no-]single-branch]

  [--reference <repository>]
  [--dissociate]
  
  [--recurse-submodules[=<pathspec>]]
  [--[no-]shallow-submodules]
  [-j <n>] [--jobs <n>]
  [--] <repository> [<directory>]
```

克隆一个远程仓库需要存在一个远程仓库，并且有一个可以访问的远程仓库的地址，对应 `<repository>` 参数，Git支持多种访问协议，最常见的如 `git://`。详见：[GIT-URLS](https://git-scm.com/docs/git-clone#_git_urls_a_id_urls_a)

```sh
$ git clone git@github.com:liuyanjie/spec.git
Cloning into 'spec'...
remote: Counting objects: 49, done.
remote: Total 49 (delta 0), reused 0 (delta 0), pack-reused 49
Receiving objects: 100% (49/49), 49.83 KiB | 25.00 KiB/s, done.
Resolving deltas: 100% (15/15), done.

$ cat spec/.git/config
[remote "origin"]
	url = git@github.com:liuyanjie/spec.git
	fetch = +refs/heads/*:refs/remotes/origin/*
[branch "master"]
	remote = origin
	merge = refs/heads/master
```

相比 `git init`，`git clone` 之后的仓库配置文件中，增加了以上内容，配置 `本地分支` 和 `远程分支` 间的追踪关系，该配置为 Git 默认配置，一般不需要修改。

`git clone` 工作流程（猜测）：

`INIT` -> `REMOTE-TRACKING` -> `FETCH` -> `CHECKOUT HEAD`

`git init` -> `git remote set-url origin git://...` -> `git fetch` -> [`git merge`] -> `git checkout HEAD`

Clone过程可以进行哪些控制：

1. `--bare`：同 `Init` 相同，可以 `Clone` 一个 `Bare` 仓库到本地。
2. `--mirror`：可以进行镜像 `Clone`，制作镜像仓库。
3. `--template=`：同 `Init` 相同，可以指定模版。
4. `--separate-git-dir=<git dir>`：分离仓库和工作区目录。
5. `--reference[-if-able] <repository>`：可以通过该参数指定一个已存在的仓库进行加速，通常用在频繁的完整的 `Clone` 上。
6. `--depth`：可以指定克隆的 Commit 数量。

克隆本地仓库

```sh
git clone path/to/local/git/repository
```

克隆远程仓库

```sh
$ git clone git@github.com:liuyanjie/knowledge.git --depth=1
Cloning into 'knowledge'...
remote: Counting objects: 300, done.
remote: Compressing objects: 100% (247/247), done.

$ git clone git@github.com:liuyanjie/knowledge.git
Cloning into 'knowledge'...
remote: Counting objects: 495, done.
remote: Compressing objects: 100% (141/141), done.

$ git clone \
  --depth=1 \
  --reference-if-able=/Volumes/Data/Data/ws/knowledge \
  git@github.com:liuyanjie/knowledge.git
Cloning into 'knowledge'...
remote: Total 0 (delta 0), reused 0 (delta 0), pack-reused 0
```

在 `Clone` 的过程中，通过一些参数可以有效的减少 `Clone` 的等待时间，如在 CI 的构建流程中，可以提高构建时间。

## 仓库维护

仓库维护包括维护 `本地仓库` 和 `远程仓库`，在 Git 中，很多时候，同一个 `远程仓库` 可以同时存在多个 `本地仓库`，偶尔，同一个 `本地仓库` 可以同时对应多个 `远程仓库`。

一旦 建立了 `本地仓库` 和 `远程仓库` 的对应关系，就需要频繁进行 `远程仓库` 和 `本地仓库` 之间的分支、标签等数据同步，对应操作有 `push、fetch、pull` 等。

同步的内容主要有：

* 分支同步：分支的 `创建、修改、删除`，本地向远程同步，远程向本地同步
* 标签同步：标签的 `创建、修改、删除`，本地向远程同步，远程向本地同步
* 数据同步

同步数据的基础在于 `本地仓库` 和 `远程仓库` 间存在的对应关系，这一关系 使用 `RefSpec` 进行描述。

### [RefSpec](https://git-scm.com/book/zh/v1/Git-内部原理-The-Refspec)

[Git 内部原理 - The Refspec](https://git-scm.com/book/zh/v1/Git-内部原理-The-Refspec)

下面示例中 `+refs/heads/*:refs/remotes/origin/*` 即为 `RefSpec`。

```sh
$ cat .git/config
[core]
        ...
[remote "origin"]
        url = git@github.com:liuyanjie/knowledge.git
        fetch = +refs/heads/*:refs/remotes/origin/*
```

RefSpec 示例：

```txt
+refs/heads/*:refs/remotes/origin/*
+refs/heads/master:master
+master:refs/remotes/origin/master
master:master
:master
master:
```

`RefSpec` 主要用来表示 `本地版本库` 和 `远程版本库` 之间的 `分支`、`标签` 等数据的对应关系。

指定获取哪些 `remote-refs` 更新 `local-refs`，当没有在命令行显示指明 `RefSpec`，会按照下面的默认策略执行。

`RefSpec` 的格式是一个可选的 `+` 号，接着是 `<src>:<dst>` 的格式，这里 `<src>` 是远端上的引用格式，`<dst>` 是将要记录在本地的引用格式。可选的 `+` 号告诉 Git 在即使不能快速演进的情况下，也去强制更新它。

所以上面示例中的 `RefSpec`，远程仓库中所有分支 `refs/heads/*`，对应到本地仓库下所有分支 `refs/remotes/origin/*`，分支名称不变。如果需要改变分支名称，则需要配置特定的 `RefSpec`。

从远程获取指定数据到本地，如：

```txt
branch master <==> +refs/heads/master:+refs/remotes/origin/master
branch    A:a <==> +refs/heads/A:+refs/remotes/origin/a
tag     <tag> <==> +refs/tags/<tag>:refs/tags/<tag>
```

示例：

```sh
$ cat .git/config
[core]
        ...
[remote "origin"]
        url = git@github.com:liuyanjie/knowledge.git
        fetch = +refs/heads/*:refs/remotes/origin/*

$ tree .git/refs
.git/refs
├── heads
│   ├── feature
│   │   └── travis-ci
│   └── master
├── remotes
│   └── origin
│       ├── feature
│       │   └── travis-ci
│       └── master
└── tags
    └── v0.0.0
```

以上对应关系：

  head@local                     |  remote@local                             | remote@remote
---------------------------------|-------------------------------------------|---------------------------------
`master`                         | `origin/master`                           | `master`
`feature/travis-ci`              | `origin/feature/travis-ci`                | `feature/travis-ci`
`refs/heads/feature/travis-ci`   | `refs/remotes/origin/feature/travis-ci`   | `refs/heads/feature/travis-ci`

注意：`RefSpec` 描述了 `remote@local` 和 `remote@remote` 之间的对应关系，但是不包含 `head@local` 和 `remote@local` 之间的关系，它们之间的存在的追踪关系在其他配置项中描述。

`head@local` 下的 分支，是在本地存在的分支，可能从远程某个分支 `checkout`，也可能是本地新建的。

`RefSpec` 一般不会出现在命令行中，而是由命令自动写在配置文件中，但是可以在命令行中直接使用。

例如：`git remote add remote-name`，Git 会获取远端上 `refs/heads/` 下面的所有引用，并将它写入到本地的 `refs/remotes/remote-name`。

```sh
git remote add liuyanjie git@github.com:liuyanjie/knowledge.git

$ cat .git/config
[remote "origin"]
        url = git@github.com:liuyanjie/knowledge.git
        fetch = +refs/heads/*:refs/remotes/origin/*

[remote "liuyanjie"]
        url = git@github.com:liuyanjie/knowledge.git
        fetch = +refs/heads/*:refs/remotes/liuyanjie/*
```

以下几种方式是等价的：

```sh
git log master
git log heads/master
git log refs/heads/master

git log origin/master
git log remotes/origin/master
git log refs/remotes/origin/master
```

通常都是使用省略 `refs/heads/` 和 `refs/remotes/` 的形式。

以上示例中 `RefSpec` 中包含 `*` 会使 Git 拉取所有远程分支到本地，如果想让Git只拉取固定的分支，可以将 `*` 修改为指定的分支名。

也可以在命令行上指定多个 `RefSpec`，如：

```sh
git fetch origin master:refs/remotes/origin/master topic:refs/remotes/origin/topic
```

同样，也可以将以上命令行中的 `RefSpec` 写入配置中：

```ini
[remote "origin"]
       url = git@github.com:liuyanjie/knowledge.git
       fetch = +refs/heads/master:refs/remotes/origin/master
       fetch = +refs/heads/develop:refs/remotes/origin/develop
       fetch = +refs/heads/feature/*:refs/remotes/origin/feature/*
```

以上，`feature` 可以看做是命名空间，划分不同的分支类型。

上面描述都是拉取时 `RefSpec` 的作用，同样推送是也需要 `RefSpec`

```sh
git push origin master:refs/heads/qa/master
```

推送一个空分支可以删除远程分支

```sh
git push origin :refs/heads/qa/master
```

`RefSpec` 描述了本地仓库分支和远程仓库分支的对应关系。很多时候可以省略，因为 Git 包含了很多默认行为。

远程仓库 `refs/heads/*` 中 的分支大都是 其他 `本地仓库` 同步到远程的。

远程仓库 `refs/heads/*` 中 `创建` 的新分支，在同步数据的时候默认会被拉到本地，`删除` 的分支默认不会在本地进行同步删除，`修改` 的分支会被更新，并与本地追踪的开发分支进行合并。


以上，通过 `RefSpec` 描述的 本地仓库 和 远程仓库 中 分支 是如何对应的，了解了 本地仓库 和 远程仓库 之间的对应关系。


### [git remote](https://git-scm.com/docs/git-remote)

> 管理本地仓库对应的一组远程仓库，包括 查看、更新、添加、删除、重命名、设置 等一系列操作

```sh
git remote [-v | --verbose]
git remote [-v | --verbose] show [-n] <name>…​
git remote [-v | --verbose] update [-p | --prune] [(<group> | <remote>)…​]

git remote add [-t <branch>] [-m <master>] [-f] [--[no-]tags] [--mirror=<fetch|push>] <name> <url>
git remote remove   <name>
git remote rename <old> <new>

git remote set-head <name> (-a | --auto | -d | --delete | <branch>)
git remote set-branches  [--add] <name> <branch>…​

git remote get-url       [--push] [--all] <name>
git remote set-url       [--push] <name> <new-url> [<old-url>]
git remote set-url --add [--push] <name> <new-url>
git remote set-url --delete [--push] <name> <url>

git remote [-v | --verbose] show [-n] <name>…​

git remote prune [-n | --dry-run] <name>…​

git remote [-v | --verbose] update [-p | --prune] [(<group> | <remote>)…​]
```

```sh
git remote                                                  # 列出已经存在的远程分支
git remote -v                                               # 查看远程主机的地址
git remote show   remote_name                               # 查看该远程主机的详细信息
git remote add    remote_name remote_url                    # 添加远程主机
git remote remove remote_name                               # 删除远程主机
git remote rename remote_name new_remote_name               # 重命名远程主机

git remote set-head remote_name branch_name --auto          # 查询远程获得默认分支
git remote set-head remote_name branch_name --delete        # 删除默认分支

git remote set-branches [--add] remote_name branch_name     # 设置 RefSpec， [remote "remote_name"].fetch

git remote get-url remote_name                              # 查看远程主机地址 [remote "remote_name"].url
git remote set-url remote_name git://new.url.here           # 设置远程主机地址
git remote set-url remote_name --push   git://new.url.here  # 修改远程主机地址
git remote set-url remote_name --add    git://new.url.here  # 修改远程主机地址
git remote set-url remote_name --delete git://new.url.here  # 删除远程主机地址

git remote prune [-n | --dry-run] <remote_name>…​            # 删除某个远程名下过期（即不存在）的分支

# see http://stackoverflow.com/questions/1856499/differences-between-git-remote-update-and-fetch
git remote [-v | --verbose] update [-p | --prune] [(<group> | <remote>)…​]
```

```sh
$ git remote show origin
* remote origin
  Fetch URL: git@github.com:liuyanjie/knowledge.git
  Push  URL: git@github.com:liuyanjie/knowledge.git
  HEAD branch: master
  Remote branches:
    feature/travis-ci tracked
    master            tracked
  Local branches configured for 'git pull':
    feature/travis-ci merges with remote feature/travis-ci
    master            merges with remote master
  Local refs configured for 'git push':
    feature/travis-ci pushes to feature/travis-ci (up to date)
    master            pushes to master            (up to date)
```

### [git fetch](https://git-scm.com/docs/git-fetch)

> 下载 Refs 从另外一个仓库，以及完成他们的变更历史所需要的 Objects。追踪的远程分支将会被更新。

`git fetch` 的主要工作就是和远程同步 `Refs`，而 `Refs` 可以 被 `创建、修改、删除`，所以 `fetch` 操作必然应该能够同步这些变化。

* [REMOTES](https://git-scm.com/docs/git-fetch#_remotes_a_id_remotes_a)
* [CONFIGURED REMOTE-TRACKING BRANCHES](https://git-scm.com/docs/git-fetch#_configured_remote_tracking_branches_a_id_crtb_a)

```sh
git fetch [<options>] [<repository> [<refspec>…​]]
git fetch [<options>] <group>
git fetch --multiple [<options>] [(<repository> | <group>)…​]
git fetch --all [<options>]
```

`.git/FETCH_HEAD`：是一个版本链接，记录在本地的一个文件中，指向着目前已经从远程仓库取下来的分支的末端版本。

执行过 `fetch` 操作的项目都会存在一个 `FETCH_HEAD` 列表，其中每一行对应于远程服务器的一个分支。

当前分支指向的 `FETCH_HEAD`，就是这个文件第一行对应的那个分支。

从本质上来说，唯一能从服务器下拉取数据的只有 `fetch`，其他命令的下拉数据的操作都是基于 `fetch` 的，所以 `fetch` 必然需要能够尽可能处理所有下拉数据时可能出现的情况。

Options:

* [shallow] 限制下拉指定的提交数：

  * `--depth=<depth>`
  * `--deepen=<depth>`

* [shallow]限制下拉指定的提交时间：

  * `--shallow-since=<date>`
  * `--shallow-exclude=<revision>`

* [deep]

  * `--unshallow`，`deep clone`
  * `--update-shallow`

* [prune] 剪枝操作

  远程仓库可能对已有的分支标签进行删除，而本地仓库并未删除，需要同步删除操作

  * `-p` `--prune`
  * `-p` `--prune-tags`

* [tags] 默认情况下，`git fetch` 会下拉 `tag`

  * `-t` `--tags` 【默认】下拉标签
  * `-n` `--no-tags` 不下拉标签

* 子模块

  * `--recurse-submodules-default=[yes|on-demand]`
  * `--recurse-submodules[=yes|on-demand|no]`
  * `--no-recurse-submodules`
  * `--submodule-prefix=<path>`


再看对应关系：

  head@local                     |  remote@local                             | remote@remote
---------------------------------|-------------------------------------------|---------------------------------
`master`                         | `origin/master`                           | `master`
`feature/travis-ci`              | `origin/feature/travis-ci`                | `feature/travis-ci`
`refs/heads/feature/travis-ci`   | `refs/remotes/origin/feature/travis-ci`   | `refs/heads/feature/travis-ci`

`git fetch` 将 `remote@remote` fetch `remote@local`，而 `RefSpec（+refs/heads/*:refs/remotes/origin/*）` 前面的 `+` 使 Git 在不能快速前进的情况下也强制更新，所以不会出现 `remote@remote --merge--> remote@local` 的情况，实际上合并是不合理的行为，因为本地的 `refs/remotes/origin/*` 就是与远程保持同步的，如果合并了，就不同步了，更重要的是，远程分支可能修改了分支历史，如果合并，修改前的内容又合并进版本库了，有可能还需要解决冲突，而之后的 `remote@local --merge--> head@local` 又会有可能合并。

```sh
git fetch                                         # 获取 所有远程仓库 上的所有分支，将其记录到 .git/FETCH_HEAD 文件中
git fetch -all                                    # 获取 所有远程仓库 上的所有分支
git fetch remote                                  # 获取 remote 上的所有分支
git fetch remote branch-name                      # 获取 remote 上的分支：branch-name
git fetch remote branch-name:local-branch-name    # 获取 remote 上的分支：branch-name，并在本地创建对应分支
git fetch remote branch-name:local-branch-name -f # 获取 remote 上的分支：branch-name，并在本地创建对应分支，[强制]
git fetch -f | --force                            # 当使用 refspec(<branch>:<branch>) 时，跳过亲子关系检查，强制更新本地分支
git fetch -p | --prune                            # 获取所有远程分支并清除服务器上已删掉的分支
git fetch -t | --tags                             # 从远程获取数据时获取tags
git fetch -n | --no-tags                          # 从远程获取数据时去除tags
git fetch --progress --verbose                    # 显示进度及冗长日志
git fetch --dry-run                               # 显示做了什么，但是并不实际修改
```

```sh
git fetch --depth=3 --no-tags --progress origin +refs/heads/master:refs/remotes/origin/master  +refs/heads/release/*:refs/remotes/origin/release/*
git fetch --depth=3 --no-tags --progress git@github.com:liuyanjie/knowledge.git +refs/heads/master:refs/remotes/origin/master  +refs/heads/release/*:refs/remotes/origin/release/*
```

示例：

```sh
$ git fetch --prune --progress --verbose --dry-run
From github.com:remote-name/branch-name
 - [deleted]             (none)     -> origin/feature/abcd
 - [deleted]             (none)     -> origin/feature/efg
remote: Counting objects: 34, done.
remote: Compressing objects: 100% (18/18), done.
remote: Total 34 (delta 18), reused 24 (delta 16), pack-reused 0
Unpacking objects: 100% (34/34), done.
   f4e75b13a..6a338066c  master              -> origin/master
 + c29324269...641076244 develop             -> origin/develop  (forced update)
 = [up to date]          release/1.0.0       -> origin/release/1.0.0
 * [new branch]          release/1.1.0       -> origin/release/1.1.0
 * [new tag]             v1.1.0              -> v1.1.0
```

`--prune` 只能清理 `.git/refs/remotes/remote-name` 目录下的远程追踪分支，而不会删除 `.git/refs/heads` 下的本地分支，即使这些分支已经合并，这些分支的清理需要特定的命令：

```sh
git branch --merged | egrep -v "(^\*|master|develop|release)" # 查看确认
git branch --merged | egrep -v "(^\*|master|develop|release)" | xargs git branch -d
```

```sh
$ git branch --merged | egrep -v "(^\*|master|develop|release)" | xargs git branch -d
Deleted branch feature/auto-tag-ci (was 98147f0e3).
Deleted branch feature/build-optimize (was d359f4179).
Deleted branch feature/contract (was c0c4bdaa8).
Deleted branch feature/cross-domain (was 2e9b25c82).
Deleted branch feature/deploy (was 3650db271).
Deleted branch feature/nvmrc (was 1d174fcd8).
Deleted branch feature/winston-logstash (was f13700c66).
```

同样远程仓库也有一些已经合并了，但是未删除的分支需要删除：

```sh
git branch -r --merged | egrep -v "(^\*|master|develop|release)" | sed 's/origin\//:/' # 查看确认
git branch -r --merged | egrep -v "(^\*|master|develop|release)" | sed 's/origin\//:/' | xargs -n 1 git push origin
```

```sh
$ git branch -r --merged | egrep -v "(^\*|master|develop|release)" | sed 's/origin\//:/' | xargs -n 1 git push origin
To github.com:liuyanjie/knowledge.git
 - [deleted]             feature/xxxx
```

```sh
$ git fetch origin master:refs/remotes/origin/master topic:refs/remotes/origin/topic
From git@github.com:schacon/simple
 ! [rejected]        master     -> origin/master  (non fast forward)
 * [new branch]      topic      -> origin/topic
```

在上面这个例子中， `master` 分支因为不是一个可以 `快速演进` 的引用而拉取操作被拒绝。你可以在 `RefSpec` 之前使用一个 `+` 号来重载这种行为。

输出格式：

```txt
<flag> <summary> <from> -> <to> [<reason>]
```

输出格式详细介绍见：[OUTPUT](https://git-scm.com/docs/git-fetch#_output)

`fetch` 负责将 远程仓库 更新到 远程仓库在本地的对应部分，其他工作又其他 命令 负责。

在实际使用中，大多数时候都是使用 `pull` 间接的使用 `fetch`。


### [git pull](https://git-scm.com/docs/git-pull)

> 将来自远程存储库的更改合并到当前分支中

```sh
git pull [options] [<repository> [<refspec>…​]]
```

```sh
git pull origin master  # 获取远程分支 master 并 merge 到当前分支
```

默认模式下，`git pull` 等价于以下两步:

```sh
git fetch
git merge FETCH_HEAD
```

特例：

```sh
git fetch
git checkout master
git merge origin/master
```

更确切的说，`git pull` 已指定的参数运行 `git fetch`，然后 调用 `git merge` 合并 检索到的分支头到当前分支，通过 `--rebase` 参数，`git merge` 也可以被替换成 `git rebase`。

假定有如下的历史，并且当前分支是 `master`：

```txt
              master on origin
              ↓
      A---B---C
     /
D---E---F---G ← master
    ↑
    origin/master in your repository
```

调用 `git pull` 时，首先需要 `fetch` 变更从远处分支，下拉之后的仓库状态：

```txt
              master on origin
              ↓
      A---B---C ← origin/master in your repository
     /
D---E---F---G ← master
```

因为 远程分支 master (C) 已经和 本地分支 master (G) 已经处于分离状态，此时，`git merge` 合并 `origin/master` 到 `master`。

```txt
              master on origin
              ↓
      A---B---C ← origin/master
     /         \
D---E---F---G---H ← master
```

以上过程发生了一次 `远程` 合并到 `本地` 的情形，git 会自动生成类似下面的 `commit message`：

```txt
Merge branch 'master' of github.com:liuyanjie/knowledge into master
```

出现 `远程` 合并到 `本地` 的情形 在 Git 中是一种不良好的实践，应该极力避免甚至是禁止出现，这种情形在多个人同时在同一个分支上开发的时候非常容易出现。

记住一点：一般来书，`分支`是要合并到远程服务器上的分支，而不是远程服务分支合并到本地分支的。

在实际开发过程中，所有的合并操作都应该发生在远程服务器上，保持所有的分支有清晰的历史。同样，也应该避免不必要的合并，甚至是禁止合并。

> 一般情况下，创建了分支必然需要通过合并来将分支上的内容整合到分支的基上，但是也有不合并的其他方法

合并产生的 `Commit` 并未给版本库带来新的改变，但是却使版本历史不够清晰了。

合并使分支历史从单向链表变成了有向图，一堆线杂乱无章交错，分支历史难以理解。

合并产生的 `Commit` 有两个或多个父 `Commit`， `Reset` 难以进行。

如何避免 本地合并？

1. 在 `commit` 之前先 `pull`，避免分叉。
2. 在 `commit` 之后立即 `push`，使其他人的本地仓库能及时获取到最新的 `commit`。

知道一定会 发生本地 合并时如何处理？

1. `git pull --ff-only` or `git fetch`
2. `git rebase origin/master`

已经出现 本地合并 如何解决？

1. `git reset C` 重置当前分支到 `C`，`F` `G` 会重新回到暂存区。
2. `git commit -am "commit message"` 重新提交。
3. `git push`

解决之后的分支图：

```txt
              master on origin
              ↓
              origin/master
              ↓
      A---B---C---F---G ← master
     /
D---E
```

假设版本库当前的状态如下：

```txt
              master on origin
              ↓
      A---B---C
     /
D---E ← master
    ↑
    origin/master in your repository
```

以上版本库库满足快速前进的条件，可以进行快速前进 `--ff`：

```txt
              master on origin
              ↓
      A---B---C ← master
     /        ↑
D---E         origin/master in your repository
```

以上版本库满足快速前进的条件，可以进行快速前进 `--ff`：

```txt
              master on origin
              ↓
      A---B---C
     /
D---E ← master
    ↑
    origin/master in your repository
```

快速前进不产生新的 `Commit`，效果上只移动分支头即可，默认情况下进行就是快速前进

在能够进行快速前进的情况下，也可以强制进行合并，如下：

```txt
              master on origin
              ↓
      A---B---C ← origin/master
     /         \
D---E-----------H ← master
```

所以 `git pull` 的参数主要由 `git fetch` 和 `git merge` 的参数组成。

`git pull` 的运行过程：

1. 首先，基于本地的 `FETCH_HEAD` 记录，比对本地的 `FETCH_HEAD` 记录与远程仓库的版本号
2. 然后通过 `git fetch` 获得当前指向的远程分支的后续版本的数据
3. 最后通过 `git merge` 将其与本地的当前分支合并

若有多个 remote，git pull remote_name 所做的事情是：

* 获取 `[remote_name]` 下的所有分支
* 寻找本地分支有没有 `tracking` 这些分支的，若有则 `merge` 这些分支，若没有则 `merge` 当前分支

另外，若只有一个 remote，假设叫 origin，那么 git pull 等价于 git pull origin；平时养成好习惯，没谱的时候都把【来源】带上。

怎么知道 `tracking` 了没有？

* 如果你曾经这么推过：`git push -u origin master`，那么你执行这条命令时所在的分支就已经 `tracking to origin/master` 了
* 如果你记不清了：`cat .git/config`，由此可见，`tracking` 的本质就是指明 `pull` 的 `merge` 动作来源

总结:

* `git pull = git fetch + git merge`
* `git fetch` 拿到了远程所有分支的更新，`cat .git/FETCH_HEAD` 可以看到其状态，若是 `not-for-merge` 则不会有接下来的 `merge` 动作
* `merge` 动作的默认目标是当前分支，若要切换目标，可以直接切换分支
* `merge` 动作的来源则取决于你是否有 `tracking`，若有则读取配置自动完成，若无则请指明【来源】

`pull` 时还可能存在远程分支不存在的情况

```sh
$ git checkout -b test
$ git pull
There is no tracking information for the current branch.
Please specify which branch you want to merge with.
See git-pull(1) for details.

    git pull <remote> <branch>

If you wish to set tracking information for this branch you can do so with:

    git branch --set-upstream-to=origin/<branch> test

$ git branch --set-upstream-to=origin/test test
error: the requested upstream branch 'origin/test' does not exist
hint:
hint: If you are planning on basing your work on an upstream
hint: branch that already exists at the remote, you may need to
hint: run "git fetch" to retrieve it.
hint:
hint: If you are planning to push out a new local branch that
hint: will track its remote counterpart, you may want to use
hint: "git push -u" to set the upstream config as you push.
```

```sh
$ git pull
remote: Counting objects: 81, done.
remote: Compressing objects: 100% (29/29), done.
remote: Total 81 (delta 42), reused 81 (delta 42), pack-reused 0
Unpacking objects: 100% (81/81), done.
From github.com:liuyanjie/knowledge
   2f977e2..be00fff  feature/x -> origin/feature/x
Your configuration specifies to merge with the ref 'refs/heads/feature/abc'
from the remote, but no such ref was fetched.
```

需要提及的一点是：

`pull` 操作，不应该涉及 `合并` 或 `变基` 操作，即 `pull` 应该总是 快速前进 的。

再看对应关系：

  head@local                     |  remote@local                             | remote@remote
---------------------------------|-------------------------------------------|---------------------------------
`master`                         | `origin/master`                           | `master`
`feature/travis-ci`              | `origin/feature/travis-ci`                | `feature/travis-ci`
`refs/heads/feature/travis-ci`   | `refs/remotes/origin/feature/travis-ci`   | `refs/heads/feature/travis-ci`

`git pull` 在 `git fetch` 的基础之上增加了 `git merge`，将 `远程分支对应的本地分支` 合并到 `追踪的本地开发分支`


### [git push](https://git-scm.com/docs/git-push)

> 使用本地引用更新远程引用，同时发送完成给定引用所必需的对象。

`git push` 是与 `git pull` 相对应的推送操作，同样需要能够推送本地的多种情形的变更到远程仓库。git 向远程仓库推送的操作只有 `push`。

```sh
git push
     [--all | --mirror | --tags]
     [--follow-tags]
     [--atomic]
     [-n | --dry-run]
     [--receive-pack=<git-receive-pack>]
     [--repo=<repository>]
     [-f | --force]
     [-d | --delete]
     [--prune]
     [-v | --verbose]
     [-u | --set-upstream]
     [--push-option=<string>]
     [--[no-]signed|--sign=(true|false|if-asked)]
     [--force-with-lease[=<ref-name>[:<expect>]]]
     [--no-verify]
     [<repository> [<refspec>…​]]
```

```sh
git push                                 # 如果当前分支只有一个追踪分支，那么主机名都可以省略
git push origin HEAD                     # 将 当前 分支 推送 到远程 master 分支
git push origin master                   # 将 master 分支 推送 到远程 master 分支
git push origin master -u                # 将 master 分支 推送 到远程 master 分支，并建立追踪关系
git push origin master --set-upstream    # 同上
git push origin --all                    # 将所有本地分支都推送到origin主机
git push origin --force                  # 强制推送更新远程分支

git push origin :hotfix/xxxx             # 删除远程仓库的 hotfix/xxxx 分支
git push origin :master                  # 删除远程仓库的 master 分支
git push origin --delete master          # 删除远程仓库的 master 分支

git push origin --prune                  # 删除在本地没有对应分支的远程分支

git push --tags                          # 把所有tag推送到远程仓库
```

推送模式：

* simple  模式: 不带任何参数的git push，默认只推送当前分支。2.0以上版本，默认此方式。
* matching模式: 会推送所有有对应的远程分支的本地分支。


```sh
git config --global push.default matching
git config --global push.default simple
```

```sh
$ git push
Enumerating objects: 9, done.
Counting objects: 100% (9/9), done.
Delta compression using up to 8 threads.
Compressing objects: 100% (6/6), done.
Writing objects: 100% (6/6), 1.25 KiB | 1.25 MiB/s, done.
Total 6 (delta 2), reused 0 (delta 0)
remote: Resolving deltas: 100% (2/2), completed with 2 local objects.
To github.com:liuyanjie/knowledge.git
   d26f671..e081fb3  master -> master
```

```sh
git push --delete ref...
```

推送代码到服务器与拉取代码到本地其实是相同的，所以服务代码推送到服务全之后，同样有可能出现需要合并的情况，如推送者本地仓库在没有 `pull` 后进行 `commit` 后 `push`，导致本地代码和远程服务器代码分叉，此时服务端也要面临合并问题，合并就有可能产生冲突，但是服务端没有解决冲突的能力，所以实质上服务端是禁止发生合并的，只能进行快速前进。当不能快速前进，服务端会返回错误给客户端，错误会提示先 `pull` 再 `push`。此时，`pull` 操作是一定会进行 `merge` 的，可能需要处理 `merge`，此时就需要处理前面提到的处理本地合并的问题了。



### [git submodule](https://git-scm.com/docs/git-submodule)

> 初始化、更新或检查子模块

[gitsubmodules](https://git-scm.com/docs/gitsubmodules)  - mounting one repository inside another

```sh
git submodule [--quiet] add [-b <branch>] [-f|--force] [--name <name>]
        [--reference <repository>] [--depth <depth>] [--] <repository> [<path>]
git submodule [--quiet] status [--cached] [--recursive] [--] [<path>…​]
git submodule [--quiet] init [--] [<path>…​]
git submodule [--quiet] deinit [-f|--force] (--all|[--] <path>…​)
git submodule [--quiet] update [--init] [--remote] [-N|--no-fetch]
        [--[no-]recommend-shallow] [-f|--force] [--rebase|--merge]
        [--reference <repository>] [--depth <depth>] [--recursive]
        [--jobs <n>] [--] [<path>…​]
git submodule [--quiet] summary [--cached|--files] [(-n|--summary-limit) <n>]
        [commit] [--] [<path>…​]
git submodule [--quiet] foreach [--recursive] <command>
git submodule [--quiet] sync [--recursive] [--] [<path>…​]
```

添加

```sh
git submodule add -b master --name knowledge --reference=/Volumes/Data/Data/ws/knowledge -- git@github.com:liuyanjie/knowledge.git ./third_parts/knowledge
```

```sh
$ git status
On branch master
Your branch is ahead of 'origin/master' by 1 commit.
  (use "git push" to publish your local commits)

Changes to be committed:
  (use "git reset HEAD <file>..." to unstage)

	new file:   .gitmodules
	new file:   third_parts
```

```sh
$ git commit -m "..."
[master 83506db] ...
 2 files changed, 5 insertions(+)
 create mode 100644 .gitmodules
 create mode 160000 third_parts
```

```sh
$ git push
Enumerating objects: 7, done.
Counting objects: 100% (7/7), done.
Delta compression using up to 8 threads.
Compressing objects: 100% (6/6), done.
Writing objects: 100% (6/6), 5.31 KiB | 5.31 MiB/s, done.
Total 6 (delta 1), reused 0 (delta 0)
remote: Resolving deltas: 100% (1/1), done.
To github.com:liuyanjie/about.git
   53abb09..83506db  master -> master
```


## 分支管理

Git 是一个分布式的结构，有本地版本库和远程版本库，便有了本地分支和远程分支的区别了。

本地分支和远程分支在 `git push` 的时候可以随意指定，交错对应，只要不出现版本从图即可。

### [git-branch](https://git-scm.com/docs/git-branch)

> 创建、修改、删除、查看、重命名、复制分支

```sh
# 创建分支
git branch (-t | --[no-]track) (-l | --[no-]create-reflog) [-f | --force] <branch-name> [<start-point>]

# 设置/修改上游分支
git branch [-u | --set-upstream-to=] <upstream> [<branch-name>]

# 查看分支
git branch -a --all
git branch -r
git branch --list <pattern>...
git branch --list --[no-]contains [<commit>]
git branch --list --[no-]merged

# 重置分支
git branch (-f --force) <branch-name> <start-point>

# 重命名分支
git branch (-m --move | -M) [<old-branch>] <new-branch>
git branch (-m --move) --force [<old-branch>] <new-branch>
git branch -M [<old-branch>] <new-branch>

# 复制分支
git branch (-c --copy) [<old-branch>] <new-branch>
git branch (-c --copy) --force [<old-branch>] <new-branch>
git branch -C [<old-branch>] <new-branch>

# 删除分支
# -r 可以同时删除远程追踪分支，但是只有在远程分支删除的情况下才有意义，否则会fetch回来
git branch (-d --delete) [-r] <branchname>…​
git branch (-d --delete)  --force [-r] <branchname>…​
git branch -D [-r] <branchname>…​

# 编辑分支描述
git branch --edit-description [<branchname>]
```

`git branch` 只能操作本地仓库，无法直接操作远程仓库，操作远程仓库必须通过 `git push`。

`remotes/origin/*` 下的分支删除：

```sh
git push --delete <branch-name>
git push :<branch-name>
```

以上命令在删除远程仓库的分支的同时，同步删除 `remotes/origin/*` 下的分支

```sh
git branch -d <remote-name>/<branch-name>
```

以上命令删除 `remotes/origin/*` 下的分支，但是远程分支并未删除，在 `git fetch` 后还会拉下来，所以这种删除无意义。

分支类型：

* 远程分支（remote-branch），远程服务器上的分支，`refs/heads/*`@remote，是`远程追踪分支`的`上游分支`。
* 远程追踪分支（remote-tracking branch），远程服务器对应在本地的分支，与`远程分支`存在`追踪`关系，可能是`本地分支`的`上游分支`。
* 本地分支（local branch），`refs/heads/*`@local，可能与`远程追踪分支`存在`追踪`关系。

分支关系：

* 追踪分支（tracking branch），能够主动追踪其他分支，自动跟随其他分支变化更新的分支。
* 上游分支（upstream branch），被追踪的分支。

> Checking out a `local branch` from a `remote-tracking branch` automatically creates what is called a `“tracking branch”` (and the branch it tracks is called an `“upstream branch”`).

只有把概念定义清楚，才能够进行准确的描述，要不然都可能带来理解上的偏差。

### [git-tag](https://git-scm.com/docs/git-tag)

> 创建、删除、查看、校验标签

```sh
git tag [-a | -s | -u <keyid>] [-f] [-m <msg> | -F <file>] [-e] <tagname> [<commit> | <object>]
git tag -d <tagname>…​
git tag [-n[<num>]] -l [--contains <commit>] [--no-contains <commit>]
  [--points-at <object>] [--column[=<options>] | --no-column]
  [--create-reflog] [--sort=<key>] [--format=<format>]
  [--[no-]merged [<commit>]] [<pattern>…​]
git tag -v [--format=<format>] <tagname>…​
```

```sh
# 查看分支
git tag
git tag -l --list "v*"

# 创建分支
git tag -a v1.0.0 -m "tagging version 1.0.0"
git tag -a --force v1.0.0 -m "tagging version 1.0.0"
git tag -a v1.0.0 --file=<file>
git tag -a v1.0.0 <commit-id>

# 删除分支
git tag -d v1.0.0
```

与分支不同，`git push` 默认不推送标签到远程，所以需要主动推送标签：

```sh
git push --tags
```

同样，`git tag` 只能操作本地仓库，无法直接操作远程仓库，操作远程仓库必须通过 `git push`，通常也不会直接操作远程仓库。

```sh
git push --delete <tag-name>
git push --delete v1.0.0
```

清理 远程不能存在本地存在 的标签：

```sh
git tag -l | xargs git tag -d ; git fetch --tags
```

标签并不像分支那样，存在远程标签/本地标签等区分，所以也不存在本地标签与远程标签之间的对应关系，自然也就不需要维护对应关系。


### [git-checkout](https://git-scm.com/docs/git-checkout)

* 切换分支并检出内容到工作区，也可创建分支

检出已存在的分支

```sh
git checkout    <branch>
git checkout -b <branch> --track <remote>/<branch>
```

创建并检出分支

```sh
git checkout -b|-B <new_branch> [<start-point>]
```

检出`tree-ish`

```sh
git checkout [<tree-ish>] [--] <pathspec>…​
```

检出内容到本地的时候会发生什么？

1. 本地是干净的，无任何修改
2. 本地存在新增加的文件
3. 本地存在修改后未提交的文件

Ref：[DETACHED HEAD](https://git-scm.com/docs/git-checkout#_detached_head)

HEAD 通常指向某一个分支，这一分支即是当前工作的分支。当 HEAD 不再指向分支的时候，仓库即处于 `DETACHED HEAD` 状态。

```sh
$ git checkout ccdd28a
Note: checking out 'ccdd28a'.

You are in 'detached HEAD' state. You can look around, make experimental
changes and commit them, and you can discard any commits you make in this
state without impacting any branches by performing another checkout.

If you want to create a new branch to retain commits you create, you may
do so (now or later) by using -b with the checkout command again. Example:

  git checkout -b <new-branch-name>

HEAD is now at ccdd28a git update

$ git status
HEAD detached at ccdd28a
nothing to commit, working tree clean
```

处于这种状态下的仓库，如果进行修改并且提交，就会很危险，因为没有任何分支指向新的提交，当 `HEAD` 切换到其他位置的时候，当前的修改就不容易找不到了。

如果需要基于此节点进行修改，需要先基于此节点创建分支。

### [git-merge](https://git-scm.com/docs/git-merge)

> 将两个或多个分支历史合并在一起

```sh
git merge
  [-q --quiet]
  [-v --verbose]
  [--[no-]progress]
  [--commit] [--no-commit]
  [-e | --edit] [--no-edit]
  [-ff] [--no-ff] [--ff-only]
  [--log[=<n>]] [--no-log]
  [-n] [--stat] [--no-stat]
  [--[no-]squash]
  [--[no-]signoff]
  [-s <strategy>] [--strategy=<strategy>]
  [-X <strategy-option>] [--strategy-option=<option>]
  [-S[<keyid>]] --gpg-sign[=<keyid>]
  [--[no-]verify-signatures]
  [--[no-]summary]
  [--[no-]allow-unrelated-histories]
  [--[no-]rerere-autoupdate]
  [-m <msg>]
  [<commit>…​]

https://stackoverflow.com/questions/11646107/you-have-not-concluded-your-merge-merge-head-exists

# git merge --abort is equivalent to git reset --merge when MERGE_HEAD is present.
# 中断 merge，当发生冲突时，可以通过中断合并回到合并前的状态
git merge --abort

# 继续 merge，当发生冲突时，需要解决冲突，解决冲突后，继续执行合并
git merge --continue
```

有如下版本库：

```txt
      A---B---C topic
     /
D---E---F---G master
```

```sh
git merge topic
```

合并后

```txt
      A---B---C topic
     /         \
D---E---F---G---H master
```

squash mode

```sh
git merge --squash topic
git commit -m "message"
```

```txt
      A---B---C topic
     /
D---E---F---G---(ABC) master
```

`--squash` 效果相当于将 topic 分支上的多个 commit A-B-C 合并成一个 ABC，放在当前分支上，原来的 commit 历史则没有拿过来。

判断是否使用 `--squash` 选项最根本的标准是，待合并分支上的历史是否有意义。版本历史记录的应该是代码的发展，而不是开发者在编码时的活动。

只有在开发分支上每个 commit 都有其独自存在的意义，并且能够编译通过的情况下，才应该选择缺省的合并方式来保留 commit 历史。

fast forward mode

```txt
              A---B---C topic
             /
D---E---F---G master
```

```sh
git merge --ff topic
```

```txt
              A---B---C topic master
             /
D---E---F---G
```

合并的前提是：准备合并的两个 `commit` 不在一条直线上，在一条直线上可以进行快速前进，也可以使用 `--no-ff` 强制合并（无意义）。

合并的过程中需要处理可能得冲突，未冲突的文件将会进行自动合并，在新版本的`tree`中产生一个新版本的`blob`，所以Git能够完整检出不需要依赖历史中的`commit`，只需要当前的`commit`。

合并的结果是：产生一个新的 `commit`，实际上，`squash mode` `fast forward mode` 并不是真正意义上的合并。


冲突：

冲突有两种类型，一种是树冲突，修改/删除同一文件，另一种是文件冲突，修改了同一文件中的相同内容。

冲突是如何判断的？

```txt
      A---B---C topic
     /
D---E---F---G master
```

假如有文件 `README.md` 在 `E`，且 `topic` 和 `master` 都有修改此文件，合并 `topic` 到 `master` 时，冲突检查的依据不是对比 `README.md@topic` 和 `README.md@master` 是否相同，而是对比 `README.md@topic` 和 `README.md@master` 相对于 `E` 的变化。即使是 `README.md` 文件在被修改后的内容是相同的，也会产生冲突。而冲突产生的文件，就是将 相对于 `E`，都合并到同一个文件中，并交由用户解决。

```txt
<<<<<<< yours:sample.txt
Git makes conflict resolution easy.
=======
Git makes conflict resolution easy.
>>>>>>> theirs:sample.txt
```

最佳实践：

1. 尽量避免在本地使用 `merge`，也尽量避免在本地发生 `Merge`。
2. `merge` 时，本地不要有未提交的更改，这些修改可能会在中断合并时丢失。

## 基本操作

### git add

> 添加文件到索引中，为下一次提交准备内容。

将工作区的修改添加到暂存区中，此命令使用在工作树中找到的最新内容更新索引，以准备为下次提交暂存内容。

典型的情况下，将整个文件添加到暂存区中，通过特定的选项，也可以将工作区修改的部分内容加到暂存区中。

暂存区保存工作树内容的快照，并将此快照作为下一次提交的内容。因此，在对工作树进行任何更改之后，在运行commit命令之前，必须使用add命令将任何新的或修改的文件添加到索引中。

默认情况下，`git add` 不会添加忽略的文件，`git add -f` 会进行强制添加。

### git rm

> 从工作区和暂存区移除文件

```sh
git rm [-f | --force] [-n] [-r] [--cached] [--ignore-unmatch] [--quiet] [--] <file>…​
```

```sh
git rm *.txt
```

等价于：

```sh
rm *.txt
git add *.txt
```

仅从暂存区删除内容

```sh
git rm --cached *.txt
```

### git mv

> 重命名或移动文件，同步更新暂存区

```sh
git mv <options>…​ <args>…​
git mv [-v] [-f] [-n] [-k] <source> <destination>
git mv [-v] [-f] [-n] [-k] <source> ... <destination directory>
```

```sh
git mv old_name new_name            # 重命名
git mv -f old_name new_name         # 强制重命名，即时目标名称已经存在
git mv -k old_name new_name         # 跳过会导致错误的动作
git mv -v old_name new_name         # 报告被移动文件
git mv --dry-run old_name new_name  # 只显示将会发生什么
```

### git diff

> Show changes between commits, commit and working tree, etc

```sh
git diff [options] [<commit>] [--] [<path>…​]
git diff [options] --cached [<commit>] [--] [<path>…​]
git diff [options] <commit> <commit> [--] [<path>…​]
git diff [options] <blob> <blob>
git diff [options] [--no-index] [--] <path> <path>
```

```sh
git diff                # 查看尚未暂存的文件更新了哪些部分，不加参数直接输入。
git diff --cached       # 查看已经暂存起来的文件(staged)和上次提交时的快照之间(HEAD)的差异
git diff --staged       # 显示的是下一次 commit 时会提交到HEAD的内容(不带-a情况下)
git diff HEAD           # 显示工作版本(Working tree)和HEAD的差别
git diff topic master   # 直接将两个分支上最新的提交做diff
git diff topic...master # 输出自 topic 和 master 分别开发以来，master 分支上的 changed。
git diff --stat         # 查看简单的diff结果，可以加上--stat参数
git diff test           # 查看当前目录和另外一个分支的差别 显示当前目录和另一个叫 test 分支的差别
git diff HEAD -- ./lib  # 显示当前目录下的lib目录和上次提交之间的差别（更准确的说是在当前分支下）
git diff HEAD^ HEAD     # 比较上次提交commit和上上次提交
git diff SHA1 SHA2      # 比较两个历史版本之间的差异
```

[Diff_utility](https://en.wikipedia.org/wiki/Diff_utility)


### git commit

> Record changes to the repository

```sh
git commit                          # 提交的是暂存区里面的内容，也就是 Changes to be committed 中的文件。
git commit -a                       # 除了将暂存区里的文件提交外，还提交 Changes bu not updated 中的文件。
git commit -a -m 'commit info'      # 注释，如果没有 -m，会默认会使用vi编辑注释。
git commit -am "This is a commit"   # 同上，合并提交，将 add 和 commit 合为一步
git commit --amend                  # 对上一次提交进行修改，合并上一次提交（用于反复修改）
git commit --amend -a               # 提交时忘记使用 -a 选项，导致 Changes bu not updated 中的内容没有被提交
git commit --author=<author>        # 设置作者，与提交者分开
git commit --file=<file>            # 注释从文件中读取
```

对于 commit 来说，最重要的是，每一次 commit 都应该是一个完整的提交，而且应该有个规范清晰的注释。

[Commit message 和 Change log 编写指南](http://www.ruanyifeng.com/blog/2016/01/commit_message_change_log.html)


### git status

> 显示工作树状态

```sh
git status [<options>…​] [--] [<pathspec>…​]
```

```sh
git status     # 显示状态
git status -s  # 显示简短信息
git status -b  # 显示分支状态
```

### git reset

> 重置工作区，将当前分支回退到某一节点

```sh
git reset [-q] [<tree-ish>] [--] <paths>…​
git reset (--patch | -p) [<tree-ish>] [--] [<paths>…​]
git reset [--soft | --mixed [-N] | --hard | --merge | --keep] [-q] [<commit>]
```

`git reset` 会修改当前分支头从某一个 `<commit-id>` 移动到另外的一个指定的 `<commit-id>`

如：

```txt
              HEAD
              ↓
              topic
              ↓
      A---B---C
     /
D---E---F---G master
```

当前活跃的分支是 `topic`

```sh
git reset A
```

执行以上操作后：

```txt
      HEAD
      ↓
      topic
      ↓
      A---B---C
     /
D---E---F---G master
```

此时，`HEAD -> topic -> A`，B、C 此时处于悬挂状态，如同普通的对象一样，没有任何引用后，会被 Git GC 回收。

执行此操作后，B、C 两点虽然依然存在于仓库中，但是它们已经逻辑上脱离了Git。

此时，B、C 两点提交的内容怎么办？是不是就丢失了呢？

Git 给了我们多种选择：

* --soft，B、C 提交的内容不会回到工作区和暂存区。因为当前工作区内容是基于 C 修改的，所以实际上并无内容丢失。
* --mixed，B、C 提交的内容回到暂存区，但是工作区内容不变，也就是某些文件处于 `修改未提交状态`。同上，也无内容丢失。
* --hard，B、C 提交的内容不会回到工作区和暂存区，同时暂存区和工作区回到A点状态，B、C 提交的内容以及工作区后续的修改全部丢失。

如果 `reset` 误操作操作怎么办？

1. 如果存在上游分支，可以通过上游分支恢复

    ```sh
    git reset master^2
    git reset origin/master
    ```

2. 可以通过 `reflog` 恢复

    `reflog` 记录 HEAD 的变化，所以可以通过 `reflog` 找到 `reset` 之前的 `HEAD` 的位置，但是前提是后续节点未被垃圾回收。

    ```sh
    git reflog
    58c1d5d (HEAD -> master, origin/master) HEAD@{0}: commit: update git
    ccdd28a (test2, test1, test) HEAD@{1}: checkout: moving from test to master
    ccdd28a (test2, test1, test) HEAD@{2}: checkout: moving from master to test
    ccdd28a (test2, test1, test) HEAD@{3}: commit: git update
    e081fb3 HEAD@{4}: commit: update python
    d26f671 HEAD@{5}: commit: update
    33db13f HEAD@{6}: commit (amend): update and format
    5c41033 HEAD@{7}: commit: update and format
    e56ec4e HEAD@{8}: commit: 移除乱码字符
    6595b95 HEAD@{9}: commit: feat(): add hexo.yaml
    ```

未提交的内容是很难就行恢复的，所有在进行 `reset` 操作时，要将工作区的内容提交。

reset 除了将工作区回退到某个节点之外，常用的应用就是将后续的多个提交合并为一个提交，因为后续提交的内容可以回到暂存区或工作区中。

在某些Git工作流中，要求将多个提交合并成一个之后才能合并到上游分支。

### git revert

```sh
git revert [--[no-]edit] [-n] [-m parent-number] [-s] [-S[<keyid>]] <commit>…​
git revert --continue
git revert --quit
git revert --abort
```

```sh
git revert HEAD~3
git revert -n master~5..master~2
```

`git revert` 用于撤销一个或多个提交，并建立一个新的提交。`commit` 中所做的修改都会被移除掉，相当于 `commit` 反向操作。

`git revert` 通常用户快速回滚。


示例如下：

```sh
            HEAD
            ↓
            master
            ↓
A---B---C---D
```

```sh
git revert C
```

```sh
                HEAD
                ↓
                master
                ↓
A---B---C---D---C'
```

`C'` 是一个全新的 `Commit` 与 `C` 是不同的，但是这种情况下，`C'` 与 `C` 中的 `tree` 是相同的。


### git rebase

> 变基操作，基指的是起始提交，即参数中常见的 <start-point>

```sh
git rebase [-i | --interactive] [<options>] [--exec <cmd>] [--onto <newbase>] [<upstream> [<branch>]]
git rebase [-i | --interactive] [<options>] [--exec <cmd>] [--onto <newbase>] --root [<branch>]
git rebase --continue | --skip | --abort | --quit | --edit-todo | --show-current-patch

# 解决冲突之后继续 rebase
git rebase --continue

# 跳过
git rebase --skip

# 中断 rebase
git rebase --abort
```

示例：

```txt
      A---B---C ← topic
     /
D---E---F---G ← master
```

```sh
git rebase master
```

```txt
              A'--B'--C' ← topic
             /
D---E---F---G ← master
```

以上，通过变基操作，将topic分支的 <start-point> 从 `E` 调整到了 `G`。

变基操作的原理：将 A B C 基于 G 重新提交，提交的过程可能与 F G 存在冲突，需要解决冲突。

变基操作的应用：

1. 保持与上游分支同步，同步上游分支的最新版本
2. 合并时存在冲突，通过变基操作解决冲突


### git cherry-pick
