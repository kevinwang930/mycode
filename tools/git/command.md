# git command 

## git push 
```
git push [-u | --set-upstream ] [remote] [branch]
git push <remote> --delete <branch>     delete remote branch 
```

## git fetch

git fetch download commit from central repo, but does not merge int your repo.

## git reset --hard
reset index and working tree

## git update-index

Modifies the index

```
git update-index --no-assume-unchanged path/to/file
find . -type f -name "*.png" -exec git update-index --assume-unchanged {} +
find . -type f -name "*.png" -exec git update-index --assume-unchanged {} +
find . -type f -name "*.png" -exec git update-index --assume-unchanged {} +
find . -type f -name "*.png" -exec git update-index --assume-unchanged {} +
```

## git checkout

switch branches or restore working tree files.

## git branch
list, create or delete branches
```
git branch -c old_branch new_branch
git branch (--set-upstream-to=<upstream> | -u <upstream>) [<branchname>]
-a list all branches
-d delete branch
-c copy branch
-m rename the current branch
```

## git reset

## git rebase
git rebase -i HEAD~2   



## git config



