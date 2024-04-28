partionPath=/code
userName=kevin
groupName=code

if grep -q "^${groupName}:" /etc/group; then
    echo "group exists continue"
else
    groupadd $groupName
    echo "group $groupName created"
fi


usermod -a -G $groupName $userName
chgrp -R $groupName $partionPath
chmod g+s $partionPath
