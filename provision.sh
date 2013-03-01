#!/bin/bash

# Abort provision whenever a command fails
set -e

package='chef-server_11.0.6-1.ubuntu.12.04_amd64.deb'
package_md5='f26932ce97e6bb49fcc223a2dae8b205'

package_not_installed () {
  [ ! `dpkg -s $1 > /dev/null; echo $?` -eq 0 ]
}

install_curl () {
  if package_not_installed curl; then
    echo "Installing curl"
    aptitude install -y curl
  fi
}

cd /vagrant

if package_not_installed chef-server; then
  if [ ! -f "$package" ] || [ ! "`md5sum $package | cut -d' ' -f1`" = "$package_md5" ]; then
    install_curl
    curl -sO "https://opscode-omnitruck-release.s3.amazonaws.com/ubuntu/12.04/x86_64/$package"
  fi

  dpkg -i $package
  chef-server-ctl reconfigure
else
  echo "Chef Server already installed."
fi

chef-server-ctl test
echo "Done! Chef web UI and API endpoint available at https://localhost"
