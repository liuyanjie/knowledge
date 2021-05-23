# Git reversions

用于指定修订版本和版本区间

许多 Git 命令将修订参数作为参数。根据不同的命令，它们表示特定的提交，用于遍历版本图，所有可从指定提交到达的其他所有提交。对于遍历修订图的命令，还可以明确指定一系列修订。

特别的，一些 Git 命令还可以采用表示除提交之外的其他对象的修订参数。

修订参数 `<rev>` 通常（但不一定）用于命名提交对象（`commit object`），他使用一种被称为 `extended SHA-1` 的语法。下面是拼写对象名的多种方法。

* <sha1>, e.g. dae86e1950b1277e545cee180551750029cfe735, dae86e
* <describeOutput>, e.g. v1.7.4.2-679-g3bee7fb
* <refname>, e.g. master, heads/master, refs/heads/master
* @
* [<refname>]@{<date>}, e.g. master@{yesterday}, HEAD@{5 minutes ago}
* <refname>@{<n>}, e.g. master@{1}


A suffix ~    to a revision parameter means the first parent of that commit object.
A suffix ~<n> to a revision parameter means the commit object that is the <n>th generation ancestor of the named commit object, following only the first parents.
