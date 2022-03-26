setup() {
  set -eu -o pipefail
  export DIR="$( cd "$( dirname "$BATS_TEST_FILENAME" )" >/dev/null 2>&1 && pwd )/.."
  export TESTDIR=~/tmp/test-pdfreactor
  mkdir -p $TESTDIR
  export PROJNAME=test-pdfreactor
  export DDEV_NON_INTERACTIVE=true
  ddev delete -Oy ${PROJNAME} || true
  cd "${TESTDIR}"
  ddev config --project-name=${PROJNAME} --project-type=php --docroot=public --webserver-type=apache-fpm --create-docroot --php-version=8.0 --database=mariadb:10.5
  echo "# Setting up Pimcore project via composer ${PROJNAME} in ${TESTDIR} ($(pwd))" >&3
  ddev composer create -y -n pimcore/demo
  ddev exec php vendor/pimcore/pimcore/bin/pimcore-install --admin-username admin --admin-password demo --mysql-host-socket db --mysql-username db --mysql-password db --mysql-database db --no-interaction
  cp ${DIR}/tests/testdata/web2print.php var/config/web2print.php
  cp ${DIR}/tests/testdata/PdfReactorCommand.php src/Command/PdfReactorCommand.php
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
  ddev php bin/console app:pdf-reactor
}

@test "install from release" {
  set -eu -o pipefail
  cd ${TESTDIR} || ( printf "unable to cd to ${TESTDIR}\n" && exit 1 )
  echo "# ddev get blankse/pdfreactor with project ${PROJNAME} in ${TESTDIR} ($(pwd))" >&3
  ddev get blankse/pdfreactor
  ddev restart
  ddev php bin/console app:pdf-reactor
}
