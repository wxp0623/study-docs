# Git 常用cmd

## 本地初始化仓库

### 1.远程创建仓库

### 2.初始化一个仓库	

​	`git init`在当前文件夹下初始化一个本地仓库

### 3.关联远程仓库

​	`git add remote origin "https://github.com/wxp0623/study-docs"`

### 4.第一次提交

​	 `git add .`添加文件到暂存区


### 5.添加提交信息（提交的目的或者变更的信息）

​	  `git commit -m "first commit"` 提交信息


### 6.推送到远程仓库

​		`git push -u origin`第一次提交需要关联远程仓库的分支，后续只需要git push

​		`-u` 选项是 `--set-upstream` 的简写，作用是**将当前本地分支与远程分支建立关联**，方便后续 `git pull` 和 `git push` 操作。



## 开发中方便操作

### git stash

#### 1.`git stash` 的作用

当你在一个分支上进行开发，但突然需要切换到另一个分支，而当前代码**未提交**，Git 不允许你切换。这时，`git stash` 可以**临时保存**你的修改，等你需要时再恢复。

```bash
git status
# 有未提交的修改，但需要切换分支
git stash         # 暂存当前修改
git checkout main # 切换到 main 分支
git checkout feature-branch  # 切回原分支
# 取回变更
git stash list # 查看所有stash记录
	...stash@{0}
	...stash@{1}
git stash pop  # 取回最新的stash记录的变更文件, 取回后会删除取回的stash
	git stash pop "stash@{0}" #取回指定的stash记录的变更文件，取回后会删除该取回的stash记录
git stash apply #  取回最新的stash记录的变更文件，取回后不删除取回的stash记录
	git stash apply "stash@{0}" #取回指定的stash记录的变更文件，不删除该stash记录

```

#### 2.`git stash` 使用流程

#### 📌 1. 暂存当前修改

```bash
git status  # 查看未提交的修改
git stash   # 暂存当前修改
```

- 这样，你的工作目录就会变干净，你可以切换分支了。

------

#### 📌 2. 切换分支

```bash
git checkout main          # 切换到 main 分支
git checkout feature-branch # 切回原来的 feature-branch 分支
```

------

#### 📌 3. 查看 stash 记录

```bash
git stash list  # 查看所有 stash 记录
```

示例输出：

```bash
stash@{0}: WIP on feature-branch: 修复某个 bug
stash@{1}: WIP on main: 添加新功能
```

------

#### 📌 4. 取回暂存的变更

##### **✅ 取回最新的 stash 并删除**

```bash
git stash pop  # 取回最新 stash 并删除
```

##### **✅ 取回指定的 stash 并删除**

```bash
git stash pop "stash@{0}"  # 取回 stash@{0} 并删除
```

##### **✅ 取回最新的 stash 但不删除**

```bash
git stash apply  # 取回 stash，但 stash 记录仍然保留
```

##### **✅ 取回指定的 stash 但不删除**

```bash
git stash apply "stash@{0}"  # 取回 stash@{0}，但 stash 记录仍然保留
```

------

#### 📌 5. 删除 stash 

##### **✅ 删除指定 stash**

```bash
git stash drop "stash@{0}"  # 删除 stash@{0}
```

##### **✅ 清空所有 stash**

```bash
git stash clear
```

#### 🔥 6. 进阶用法

##### **✅ `stash` 并包含未跟踪的文件**

```bash
git stash -u  # 暂存修改 + 未跟踪文件
git stash -a  # 暂存修改 + 所有未跟踪/忽略的文件
```

##### **✅ 创建带描述的 stash**

```bash
git stash save "修复用户登录问题"
```

然后：

```bash
git stash list
```

你会看到：

```bash
stash@{0}: On feature-branch: 修复用户登录问题
```

##### **✅ 在新分支中恢复 s tash**

如果你 stash 了代码，并想把它恢复到一个新分支：

```bash
git stash branch new-feature-branch
```

等价于：

```bash
git checkout -b new-feature-branch
git stash pop
```

#### 🎯 总结

| 命令                        | 作用                    |
| --------------------------- | ----------------------- |
| git stash                   | 暂存修改                |
| git stash -u                | 暂存修改 + 未跟踪文件   |
| git stash list              | 查看 stash 记录         |
| git stash pop               | 取回最新 stash 并删除   |
| git stash pop stash@{n}     | 取回指定 stash 并删除   |
| git stash apply             | 取回最新 stash 但不删除 |
| git stash apply stash@{n}   | 取回指定 stash 但不删除 |
| git stash drop stash@{n}    | 删除指定 stash          |
| git stash clear             | 删除所有 stash          |
| git stash branch new-branch | 创建新分支并恢复 stash  |

