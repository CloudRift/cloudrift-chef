#
# Cookbook Name:: cloudrift-base
# Recipe:: default

# Update Apt
execute "apt-get-update" do
	command "apt-get update"
end

package "python-pip" do
	action :install
end

package "python-dev" do
	action :install
end

package "git" do
	action :install
end