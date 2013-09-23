# -*- mode: ruby -*-
# vi: set ft=ruby :

VAGRANTFILE_API_VERSION = "2"

Vagrant.configure(VAGRANTFILE_API_VERSION) do |config|
  config.vm.box = "precise64"
  config.vm.box_url = "http://files.vagrantup.com/precise64.box"

  config.vm.define :cloudrift_api do |cloudrift_api|
    cloudrift_api.vm.hostname = "cloudrift-api"

    cloudrift_api.vm.provision :chef_solo do |chef|
      chef.cookbooks_path = "cookbooks"
      chef.roles_path = "roles"
      chef.run_list = [
        "role[base]",
        "role[api]"
      ]
    end
  end
end
