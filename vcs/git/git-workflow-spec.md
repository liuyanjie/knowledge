# Git workflow spec

## 分支命名

* `master` - 主干（默认）

    线上正式服务器的版本，每一次在 `master` 上的提交或合并都应该伴随着版本号的变更。

    master 分支应保证是随时可发布的（可能包含Bug），每个发布的版本应打上 tag，便于回滚。对于有重大 Bug 的版本，应备注，避免回滚到错误的版本。

* `feature/*` - 特性分支

    Example: feature/this-is-a-feature-name，名称中间通过 `-` 分割。

    该分支创建自 `master` 分支，充分测试后，合并到 `master` 分支

    开发人员使用的分支，针对每一个功能点 `issue` 创建一个 `feature`，一般命名规范为 `feature/<issue_number>-<feature_name>`，该 `feature` 下的每次提交格式为 `#<issue_number> <description>`，当 `feature` 开发完毕后 `merge` 到 `develop`，并关闭 `issue`。

    实际开发中，可能有些 `feature` 算不上什么功能上的需求，不太必要有 `issue`，所以命名时可以没有 `<issue_number>`。

    实际开发中，每个新特征功能都应该进行独立的测试，所以可能需要发布到测试环境中供测试人员进行测试。目前开发流程不方便部署 `feature` 分支，所以目前不进行`feature` 的独立测试。

* `release/*` - 预发布版本

    预发布版本，当 `develop` 收集够了做一次版本发布所需的代码，就 `checkout -b` 出一个 `release` 分支，作为上线前的最后测试，除了 `bugfix` 外不接受任何提交。确认发布后分别 `merge` 到 `master` 和 `develop`。

    如果能够明确定义版本，且明确定义 某版本包含哪些功能的情况下，可在 某版本 定义的功能全部开发完毕之后，创建 `release` 分支，进行 `master + release` 灰度部署。

* `hotfix/*`

    紧急修复分支，当 `master` 上出现 `bug` 需要修复时，基于 `master` 创建 `hotfix` 分支，修复完成后分别 `merge` 到 `master` 和 `develop`。

    开发分支中可能存在Bug，直接修改就可以了，无须创建分支修复Bug，所以，`hotfix/*` 只针对发布的版本。

* `develop` - 测试分支

    该分支创建自 `master` 分支，定期与 `master` 分支同步，`featrue` 分支 在本 `merge` 到 `develop` 后 `push` 到 `github` 进行测试。

    测试服运行此分支代码，作为开发环境中的主分支使用，任务是收集各个 `feature` 分支。

    合并到 `develop` 分支的代码必须是已经完成开发并在本地进行过充分测试的 `feature`，即 `能够交给测试人员测试的版本`。

    因该分支上可能包含多个 `feature`，且 多个 `feature` 可能处于不同阶段，所以该分支一般不合并的到 `master`

## 标签命名

* [语义化版本 2.0.0](https://semver.org/lang/zh-CN/)
* [软件版本周期](https://en.wikipedia.org/wiki/Software_release_life_cycle)

版本格式：主版本号.次版本号.修订号，版本号递增规则如下：

* 主版本号：当你做了不兼容的 API 修改，通常是进行了大规模的重新设计，重新定义了 API。
* 次版本号：当你做了向下兼容的功能性新增，通常对应发布了 `feature/*`。
* 修订号：当你做了向下兼容的问题修正。通常对应发布了 `hotfix/*`。

先行版本号及版本编译信息可以加到“主版本号.次版本号.修订号”的后面，作为延伸。

Example：

```txt
1.0.2
1.0.1
1.0.0-beta2
1.0.0-beta1
1.0.0-alpha2
1.0.0-alpha1
```

## Commit

Format

```txt
<type>[(<scope>)]: <subject>
// 空一行
[<body>]
```

> 中括号内是可选的

Format with GitEmoji

```txt
:emoji1: :emoji2: 不超过 50 个字的摘要，首字母大写，使用祈使语气，句末不要加句号

提交信息主体

引用相关 issue 或 PR 编号 <#110>
```


```txt
# Ref https://github.com/thoughtbot/dotfiles/blob/master/gitmessage
#
# 50-character subject line
#
# 72-character wrapped longer description. This should answer:
#
# * Why was this change necessary?
# * How does it address the problem?
# * Are there any side effects?
#
# Include a link to the ticket, if any.
#
# Add co-authors if you worked on this code with others:
#
# Co-authored-by: Full Name <email@example.com>
# Co-authored-by: Full Name <email@example.com>
```

1. type:

    * feat - 新功能
    * fix - 修复bug
    * br - 此项特别针对bug号，用于向测试反馈bug列表的bug修改情况
    * test - 测试
    * docs - 文档（）
    * style - 格式（不影响代码运行的变动）
    * refactor - 重构（即不是新增功能，也不是修改bug的代码变动）
    * chore - 构建过程或辅助工具的变动
    * revert - 执行了 `git-revert`

2. scope

    scope用于说明 commit 影响的范围，比如数据层、控制层、视图层等等，视项目不同而不同。

3. subject

    subject 是 commit 目的的简短描述，不超过50个字符。

    第一个字母小写，结尾不加句号（.），以动词开头，使用第一人称现在时，比如change，而不是 changed 或 changes

    在 subject 可以引用 Issue

4. body

    body 部分是对本次 commit 的详细描述，可以分成多行。

    在 subject 可以引用 Issue

## Develop -> Deploy

1. 创建分支

    `git checkout feature/xxx`

    > 注意：`feature/xxx` 应基于 `master`，所以 此时命令应在 `master` 分支上进行

1. 修改

    `git add`

    `git commit`

1. 推送到远程

    `git push`

1. 同步 `develop` 分支，自动部署 `develop` 分支部署到 `demo` 服务器

    `git branch -f develop feature/xxx`

    `git push -f origin "develop:develop"`

    以上命令在当前分支 `feature/xxx` 下进行，不需要切换分支

1. Pull Request

    请求将 `feature/xxx` 合并到 `master` 上

1. 部署正式服

    1. 将分支 切回 `master`

        `git checkout master`

        此时 `feature/xxx` 已经完成任务，可以删除

    2. ~~· 打 Tag，部署正式服（需手动执行部署）~~~

        * `git tag vx.x.x`
        * `git push origin vx.x.x`

    3. 创建 `release/vx.x.x`，部署正式服（自动执行部署）

        * `git branch release/vx.x.x`
        * `git push origin release/vx.x.x`

## Ref

* [如何写好 Git commit log?](https://www.zhihu.com/question/21209619)
* [5-useful-tips-for-a-better-commit-message](https://robots.thoughtbot.com/5-useful-tips-for-a-better-commit-message)
* https://github.com/thoughtbot/dotfiles/blob/master/gitmessage
* https://github.com/carloscuesta/gitmoji
* https://github.com/liuchengxu/git-commit-emoji-cn
* https://github.com/commitizen/cz-cli
* https://github.com/commitizen/cz-conventional-changelog
* https://github.com/conventional-changelog/standard-version
* https://github.com/marionebl/commitlint
* https://github.com/semantic-release/semantic-release
* https://github.com/conventional-changelog/conventional-changelog
