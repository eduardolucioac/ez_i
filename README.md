ez_i - Create shell script installers easily!
=============

# What is ez_i?

It's a library (in reality a bash script) that providing a number of cool features to create interactive BASH scripts, including intallers.

# How to use!

Include at the beginning of your bash script...

```
#!/bin/bash

# > -----------------------------------------
# Run that script with bash even if the user use sh/dash or any sh like interpreter.
# This way it correctly works with either: "sh ./my_script.bash" or "bash ./my_script.bash"
# or "./my_script.bash".

if [ -z "$BASH_VERSION" ]
then
    exec bash "$0" "$@"
fi

# < -----------------------------------------

# NOTE: Avoids problems with relative paths. By Questor
SCRIPT_DIR_S="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"

# NOTE: Load ez_i library (in reality a bash script). It provides a number of cool
# features for creating interactive bash scripts, including installers. By Questor
# [Ref(s).: https://github.com/eduardolucioac/ez_i ]
. $SCRIPT_DIR_S/ez_i.bash
```

# About

okd_bare_metal 🄯 CC-BY-SA-4.0 license
Eduardo Lúcio Amorim Costa  
Brazil-DF  
https://www.linkedin.com/in/eduardo-software-livre/

<img border="0" alt="Brazil-DF" src="http://upload.wikimedia.org/wikipedia/commons/thumb/6/6d/Map_of_Brazil_with_flag.svg/180px-Map_of_Brazil_with_flag.svg.png" height="15%" width="15%"/>
