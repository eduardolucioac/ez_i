#!/bin/bash

# Note: Get script folder path! By Questor
SCRIPTDIR_V="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"

# > --------------------------------------------------------------------------
# UTILITÁRIOS!
# --------------------------------------

GET_USR_INPUT_R=""
f_get_usr_input() {
    QUESTION_P=$1
    ALLOW_EMPTY_P=$2
    if [ -z "$ALLOW_EMPTY_P" ] ; then
        ALLOW_EMPTY_P=0
    fi
    GET_USR_INPUT_R=""
    read -e -r -p "$QUESTION_P (use enter to confirm): " RESP_V
    if [ -n "$RESP_V" ] ; then
        GET_USR_INPUT_R="$RESP_V"
    elif [ ${ALLOW_EMPTY_P} -eq 0 ] ; then
        f_get_usr_input "$QUESTION_P" 0
    fi
}

f_ez_sed() {
    TARGET=$1
    REPLACE=$2
    FILE=$3
    ALL_OCCUR=$4
    if [ -z "$ALL_OCCUR" ] ; then
        ALL_OCCUR=0
    fi
    if [ ${ALL_OCCUR} -eq 0 ] ; then
        SED_RPL="'0,/$TARGET/s//$REPLACE/g'"
    else
        SED_RPL="'s/$TARGET/$REPLACE/g'"
    fi
    eval "sed -i $SED_RPL $FILE"
}

# < --------------------------------------------------------------------------

# > --------------------------------------------------------------------------
# GRAFICO!
# --------------------------------------

f_indent() {
    LEVEL_P=$1
    if [ ${LEVEL_P} -eq 2 ] ; then
        sed 's/^/  /';
    fi
    if [ ${LEVEL_P} -eq 4 ] ; then
        sed 's/^/    /';
    fi
    if [ ${LEVEL_P} -eq 8 ] ; then
        sed 's/^/        /';
    fi
}

# Note: ! By Questor
f_open_section() {
    TITLE_P=$1
    echo "> ------------------------------------------------"
    if [ -n "$TITLE_P" ] ; then
        echo "$TITLE_P"
        f_div_section
        echo 
    fi
}

# Note: ! By Questor
f_close_section() {
    echo "< ------------------------------------------------"
    echo 
}

# Note: ! By Questor
f_div_section() {
    echo "----------------------------------"
}

# Note: ! By Questor
f_sub_section() {
    TITLE_P=$1
    TEXT_P=$2
    echo "> $TITLE_P" | f_indent 2
    echo 
    echo "$TEXT_P" | f_indent 4
    echo 
}

# Note: ! By Questor
f_enter_to_cont() {
    read -p "Press enter to continue..." nothing
}

# < --------------------------------------------------------------------------

# > --------------------------------------------------------------------------
# APRESENTAÇÃO!
# --------------------------------------

# Note: ! By Questor
f_present() {
    TITLE_P=$1
    VERSION_P=$2
    ABOUT_P=$3
    WARNINGS_P=$4
    COMPANY_P=$5
    f_open_section "$TITLE_P ($VERSION_P)"
    f_sub_section "ABOUT:" "$ABOUT_P"
    f_sub_section "WARNINGS:" "$WARNINGS_P"
    f_div_section
    echo "$COMPANY_P"
    f_close_section
    f_enter_to_cont
    clear
}

# Note: ! By Questor
f_terms_licen() {
    TERMS_LICEN_P=$1
    f_open_section "LICENSE/TERMS:"
    echo "$TERMS_LICEN_P" | f_indent 2
    f_close_section
    f_enter_to_cont
    clear
}

# Note: ! By Questor
f_instruct() {
    INSTRUCT_P=$1
    f_open_section "INSTRUCTIONS:"
    echo "$INSTRUCT_P" | f_indent 2
    f_close_section
    f_enter_to_cont
    clear
}

# < --------------------------------------------------------------------------

# > --------------------------------------------------------------------------
# ESQUEMAS CONDICIONAIS!
# --------------------------------------

YES_NO_R=0
f_yes_no() {
    QUESTION_P=$1
    YES_NO_R=0
    read -r -p "$QUESTION_P (y/n) " RESP_V
    if [[ $RESP_V =~ ^([sS]|[yY])$ ]] ; then
        YES_NO_R=1
    elif [[ $RESP_V =~ ^([nN])$ ]] ; then
        echo "Aborted!"
        YES_NO_R=0
    else
        f_yes_no "$QUESTION_P"
    fi
}

# < --------------------------------------------------------------------------