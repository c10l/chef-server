#!/bin/bash

# Abort provision whenever a command fails
set -e

package='chef-server_11.0.6-1.ubuntu.12.04_amd64.deb'
package_md5='f26932ce97e6bb49fcc223a2dae8b205'

package_not_installed () {
  [ ! `dpkg -s $1 &> /dev/null; echo $?` -eq 0 ]
}

install_curl () {
  if package_not_installed curl; then
    echo "Installing curl"
    aptitude install -y curl
  fi
}

create_swap_file () {
  if [ ! -f /swapfile1 ]; then
    echo "Creating swap file. This could take a while..."
    dd if=/dev/zero of=/swapfile1 bs=1024 count=524288
    mkswap /swapfile1
    chmod 0600 /swapfile1
    swapon /swapfile1
    echo "/swapfile1 swap swap defaults 0 0" >> /etc/fstab
  fi
}

cd /vagrant

if package_not_installed chef-server; then
  create_swap_file
  if [ ! -f "$package" ] || [ ! "`md5sum $package | cut -d' ' -f1`" = "$package_md5" ]; then
    install_curl
    curl -sO "https://opscode-omnitruck-release.s3.amazonaws.com/ubuntu/12.04/x86_64/$package"
  fi

  dpkg -i $package
  chef-server-ctl reconfigure
  chef-server-ctl test
else
  echo "Chef Server already installed."
fi

echo "Done! Chef web UI and API endpoint available at https://chef-server.vm"
