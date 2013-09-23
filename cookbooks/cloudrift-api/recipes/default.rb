#
# Cookbook Name:: cloudrift-api
# Recipe:: default

directory "/opt/cloudrift" do
	recursive true
	action :create
end

git "/opt/cloudrift" do
	repository "https://github.com/CloudRift/Rift.git"
	reference "master"
	action :sync
end

execute "pip-install-deps" do
	command "pip install -r /opt/cloudrift/tools/pip-requires"
end

execute "start-api-service" do
	command "uwsgi --ini /opt/cloudrift/etc/rift/cloudrift-api.ini &"
end