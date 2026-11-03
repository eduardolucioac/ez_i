#!/bin/bash
#
# test/unattended.bash - what happens with EZ_I_SKIP_ON set
#
# Part of the "ez_i" test suite. Sourced by "test/test.bash", never on its
# own: it relies on the harness.
#
# A script running unattended must get PAST every prompt rather than hang on
# one, and must not be taken to have agreed to anything. These run each
# asking function in a subshell with a closed stdin, so a function that
# forgot to honour the flag shows up as a failure and not as a suite that
# never finishes.
#
# ez_i - Interactive BASH scripts without the boilerplate "inverted (c)" BSD-3-Clause
# Eduardo Lucio Amorim Costa
#

t_group "unattended (EZ_I_SKIP_ON=1)"

# Runs a snippet with the library loaded, the flag set and NO stdin, giving
# up after a few seconds. A prompt that is still waiting cannot pass.
function t_unattended() {
    local test_name="$1"
    local snippet="$2"
    local expected="$3"
    local obtained=""
    obtained=$(timeout 5 bash -c "
        EZ_I_SKIP_ON=1
        source \"$TESTS_ROOT/ez_i.bash\" || exit 1
        $snippet
    " < /dev/null 2>&1)
    local status=$?
    if ((status == 124)) ; then
        t_report 1 "$test_name" "it blocked waiting for input"
        return
    fi
    t_equals "$test_name" "$expected" "$obtained"
}

t_unattended "ez_i.read returns without asking" \
    'declare A="DEFAULT" ; ez_i.read A "Name? " ; echo "$A"' \
    "DEFAULT"

t_unattended "ez_i.ask returns without asking" \
    'declare A="DEFAULT" ; ez_i.ask A "Name?" ; echo "$A"' \
    "DEFAULT"

t_unattended "ez_i.ask_option returns without asking" \
    'declare -a O=("y" "Yes" "n" "No") ; declare A="DEFAULT"
     ez_i.ask_option A "" "Pick?" O ; echo "$A"' \
    "DEFAULT"

# NOTE: NO is the answer, deliberately. A run with nobody watching has not
# agreed to anything, and a library that assumed otherwise would be a way to
# get a destructive step confirmed by an empty terminal.
t_unattended "ez_i.ask_yes_no answers no, through a variable" \
    'declare A=9 ; ez_i.ask_yes_no A "Delete everything?" ; echo "$A"' \
    "0"

t_unattended "ez_i.ask_yes_no answers no, through the exit status" \
    'if ez_i.ask_yes_no "" "Delete everything?" ; then echo "YES" ; else echo "NO" ; fi' \
    "NO"

t_unattended "ez_i.enter_to_continue returns without waiting" \
    'ez_i.enter_to_continue "Something happened." ; echo "PAST IT"' \
    "PAST IT"

t_unattended "ez_i.ask_continue carries on rather than exiting" \
    'ez_i.ask_continue ; echo "PAST IT"' \
    "PAST IT"

t_unattended "ez_i.terms carries on rather than exiting" \
    'ez_i.terms "Some licence." ; echo "PAST IT"' \
    "PAST IT"

t_unattended "ez_i.start draws nothing" \
    'ez_i.start "" "T" "1.0" "A" "W" "C" ; echo "PAST IT"' \
    "PAST IT"

t_unattended "ez_i.end draws nothing" \
    'ez_i.end "T" "I" ; echo "PAST IT"' \
    "PAST IT"

t_unattended "ez_i.instructions draws nothing" \
    'ez_i.instructions "" "Do this." ; echo "PAST IT"' \
    "PAST IT"

t_unattended "ez_i.progress animates nothing" \
    'ez_i.progress "a" "Working..." ; ez_i.progress "o" ; echo "PAST IT"' \
    "PAST IT"

# NOTE: A warning is shown even unattended, because the point of a warning is
# to be seen. What it does not do is WAIT.
t_unattended "a warning is still shown, and does not wait" \
    'ez_i.warning "LOOK OUT!" ; echo "PAST IT"' \
    "
> ------------------------------------------------
W A R N I N G !
----------------------------------

LOOK OUT!

< ------------------------------------------------

PAST IT"

# The functions that compute something still do, flag or no flag.
t_unattended "the computing functions still work" \
    'declare A ; ez_i.trim A "  x  " 2 ; echo "$A"' \
    "x"
