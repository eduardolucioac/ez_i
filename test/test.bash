#!/bin/bash
#
# test/test.bash - Test suite for the "ez_i" BASH library.
#
# Run it directly:
#
#     ./test/test.bash
#
# Exits 0 when every test passed, 1 otherwise, so it can be wired into a
# pre-commit hook or a CI job.
#
# The suite is split into parts under "test/". This file is the entry point
# and the only one to run; the parts use the counters and assertions the
# harness defines, so none of them stands on its own.
#
# The order is fixed and spelled out below rather than looped over: they are
# known, and a list in a variable would only hide which one failed.
#
# WHAT IS NOT COVERED, AND WHY
#
#     ez_i.ask, ez_i.read, ez_i.ask_option, ez_i.ask_yes_no,
#     ez_i.enter_to_continue, ez_i.ask_continue, ez_i.terms
#         .. wait on a real person. Their EZ_I_SKIP_ON path is checked.
#     ez_i.start, ez_i.end, ez_i.instructions, ez_i.warning
#         .. clear the terminal and page, which a suite has no terminal for.
#     ez_i.package_installed, ez_i.check_distro_status
#         .. need a specific distribution and its package manager.
#     ez_i.iptables_rule
#         .. needs root.
#
# ez_i - Interactive BASH scripts without the boilerplate "inverted (c)" BSD-3-Clause
# Eduardo Lucio Amorim Costa
#

TESTS_DIRECTORY="$( cd -- "$( dirname -- "${BASH_SOURCE[0]}" )" && pwd )"
TESTS_ROOT="$( cd -- "$TESTS_DIRECTORY/.." && pwd )"

# NOTE: Sourced with the flag OFF, because the drawing functions are part of
# what is being tested. The parts that would wait on a person are not called.
EZ_I_SKIP_ON=0

# shellcheck source=../ez_i.bash
source "$TESTS_ROOT/ez_i.bash" || exit 1

# shellcheck source=harness.bash
source "$TESTS_DIRECTORY/harness.bash" || exit 1

# NOTE: The library installs an EXIT trap of its own, and "ez_i.trap_add" is
# what keeps this one from replacing it.
ez_i.trap_add "rm -rf \"$TESTS_TMP\"" EXIT

# shellcheck source=strings.bash
source "$TESTS_DIRECTORY/strings.bash" || exit 1

# shellcheck source=numbers.bash
source "$TESTS_DIRECTORY/numbers.bash" || exit 1

# shellcheck source=files.bash
source "$TESTS_DIRECTORY/files.bash" || exit 1

# shellcheck source=system.bash
source "$TESTS_DIRECTORY/system.bash" || exit 1

# shellcheck source=terminal.bash
source "$TESTS_DIRECTORY/terminal.bash" || exit 1

# shellcheck source=unattended.bash
source "$TESTS_DIRECTORY/unattended.bash" || exit 1

# shellcheck source=shadowing.bash
source "$TESTS_DIRECTORY/shadowing.bash" || exit 1

# shellcheck source=sources.bash
source "$TESTS_DIRECTORY/sources.bash" || exit 1

echo
echo "============================================================"
printf ' TOTAL %s | PASSED %s | FAILED %s\n' "$TESTS_TOTAL" "$TESTS_PASSED" "$TESTS_FAILED"
if ((TESTS_FAILED > 0)) ; then
    echo " FAILED TESTS:"
    for FAILED_NAME in "${TESTS_FAILED_NAMES[@]}" ; do
        printf '   . %s\n' "$FAILED_NAME"
    done
fi
echo "============================================================"
echo

((TESTS_FAILED == 0)) && exit 0
exit 1
