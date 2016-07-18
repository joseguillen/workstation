# -*- mode: ruby -*-
# vi: set ft=ruby :

# All Vagrant configuration is done below. The "2" in Vagrant.configure
# configures the configuration version (we support older styles for
# backwards compatibility). Please don't change it unless you know what
# you're doing.
Vagrant.configure("2") do |config|
  # Every Vagrant development environment requires a box. You can search for
  # boxes at https://atlas.hashicorp.com/search.
  # make sure that 2nd parameter is defined
  if (ENV["CUSTOM_HOST"]=="")
    CUSTOM_HOST="default"
  end
  config.vm.hostname = ENV["CUSTOM_HOST"]
  config.vm.provider :digital_ocean do |provider, override|
      # Make sure the ssh key is added to DO and named Vagrant
      override.ssh.private_key_path = '~/.ssh/filament_rsa'
      override.vm.box = 'digital_ocean'
      override.vm.box_url = "https://github.com/devopsgroup-io/vagrant-digitalocean/raw/master/box/digital_ocean.box"

      provider.token = 'ece14e28fa31b0e25a386170375763956421ca9c2aa45914333ae3218786a956'
      provider.image = 'ubuntu-14-04-x64'
      provider.region = 'TOR1'
      provider.size = '512mb'
      config.vm.synced_folder "./code", "/vagrant/code", create: true, type: "rsync", rsync__auto: true
      config.vm.provision "shell", path: "bootstrap.sh"
    end
end
