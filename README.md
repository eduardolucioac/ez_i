ez_i - Create shell script installers easily!
=============

What is ez_i?
-----

It's a small library - a shell script file used as an "include" - that offering a number of cool features to create intallers using shell script!

How to use!
-----

Include at the beginning of your installation shell script...

```
#!/bin/bash

# > -----------------------------------------
# Run that script with bash even if the user use sh/dash or any sh like 
# interpreter. This way it correctly works with either: 
# "sh ./my_script.sh" or "bash ./my_script.sh" or "./my_script.sh"

if [ -z "$BASH_VERSION" ]
then
    exec bash "$0" "$@"
fi

# < -----------------------------------------

# NOTE: Avoids problems with relative paths! By Questor
SCRIPTDIR_V="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"
. $SCRIPTDIR_V/ez_i.sh
```

Contact
-----

groovimdoc@gmail.com

Brazil-DF

<img border="0" alt="GrooVim Doc" src="http://upload.wikimedia.org/wikipedia/commons/thumb/6/6d/Map_of_Brazil_with_flag.svg/180px-Map_of_Brazil_with_flag.svg.png" height="15%" width="15%">
