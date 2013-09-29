# -*- mode: ruby -*-
# vi: set ft=ruby :

VAGRANTFILE_API_VERSION = "2"

Vagrant.configure(VAGRANTFILE_API_VERSION) do |config|
  config.vm.box = "precise64"
  config.vm.box_url = "http://files.vagrantup.com/precise64.box"

  ip_db = "192.168.50.10"
  ip_api = "192.168.50.11"
  ip_worker = "192.168.50.12"

  config.vm.define :cloudrift_db do |cloudrift_db|
    cloudrift_db.vm.hostname = "db-01"
    cloudrift_db.vm.network :private_network, ip: "#{ip_db}", :netmask => "255.255.0.0"

    cloudrift_db.vm.provision :chef_solo do |chef|
      chef.cookbooks_path = "cookbooks"
      chef.roles_path = "roles"
      chef.run_list = [
        "role[db]"
      ]
    end
  end

  config.vm.define :cloudrift_api do |cloudrift_api|
    cloudrift_api.vm.hostname = "cloudrift-api"
    cloudrift_api.vm.network :private_network, ip: "#{ip_api}", :netmask => "255.255.0.0"

    cloudrift_api.vm.provision :chef_solo do |chef|
      chef.cookbooks_path = "cookbooks"
      chef.roles_path = "roles"
      chef.run_list = [
        "role[base]",
        "role[api]"
      ]
      chef.json = {
        "cloudrift_api" => {
          "mongodb_host" => "#{ip_db}",
          "rabbitmq_host" => "#{ip_db}",
          "uwsgi_ini" => "/opt/cloudrift/etc/rift/cloudrift-api.ini"
        }
      }
    end
  end
  config.vm.define :cloudrift_worker do |cloudrift_worker|
    cloudrift_worker.vm.hostname = "cloudrift-worker"
    cloudrift_worker.vm.network :private_network, ip: "#{ip_worker}", :netmask => "255.255.0.0"

    cloudrift_worker.vm.provision :chef_solo do |chef|
      chef.cookbooks_path = "cookbooks"
      chef.roles_path = "roles"
      chef.run_list = [
        "role[base]",
        "role[api]"
      ]
      chef.json = {
        "cloudrift_api" => {
          "mongodb_host" => "#{ip_db}",
          "rabbitmq_host" => "#{ip_db}",
          "uwsgi_ini" => "/opt/cloudrift/etc/rift/cloudrift-worker.ini"
        }
      }
    end
  end
end
