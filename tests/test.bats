setup() {
  set -eu -o pipefail
  export DIR="$( cd "$( dirname "$BATS_TEST_FILENAME" )" >/dev/null 2>&1 && pwd )/.."
  export TESTDIR=~/tmp/test-pdfreactor
  mkdir -p $TESTDIR
  export PROJNAME=test-pdfreactor
  export DDEV_NON_INTERACTIVE=true
  ddev delete -Oy ${PROJNAME} || true
  cd "${TESTDIR}"
  echo "# Setting up project ${PROJNAME} in ${TESTDIR} ($(pwd))" >&3
  cp -R ${DIR}/tests/testdata/* .
  ddev config --project-name=${PROJNAME} --project-type=php
  ddev start
}

teardown() {
  set -eu -o pipefail
  cd ${TESTDIR} || ( printf "unable to cd to ${TESTDIR}\n" && exit 1 )
  ddev delete -Oy ${PROJNAME}
  [ "${TESTDIR}" != "" ] && rm -rf ${TESTDIR}
}

@test "install from directory" {
  set -eu -o pipefail
  cd ${TESTDIR}
  echo "# ddev get ${DIR} with project ${PROJNAME} in ${TESTDIR} ($(pwd))" >&3
  ddev get ${DIR}
  ddev restart
  ddev php test.php
}

@test "install from release" {
  set -eu -o pipefail
  cd ${TESTDIR} || ( printf "unable to cd to ${TESTDIR}\n" && exit 1 )
  echo "# ddev get drud/ddev-pdfreactor with project ${PROJNAME} in ${TESTDIR} ($(pwd))" >&3
  ddev get drud/ddev-pdfreactor
  ddev restart
  ddev php test.php
}
