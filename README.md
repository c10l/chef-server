chef-server
===========

This repo is for my personal use, but feel free to use it if you'd like.

This is a simple setup that gets a Chef server up and running on a Vagrant VM, accessible via localhost.

Caveats
=======

Add this line to `/etc/hosts`:

    192.168.33.10 chef-server chef-server.vm

and configure knife.rb:

    chef_server_url          'https://chef-server.vm'
