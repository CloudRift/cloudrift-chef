#
# Cookbook Name:: cloudrift-api
# Recipe:: default

execute "create-repo-path" do
	command "mkdir -p /opt/cloudrift"
	ignore_failure true
end

execute "clone-api-repo" do
	command "git clone https://github.com/CloudRift/Rift.git /opt/cloudrift"
end

execute "pip-install-deps" do
	command "pip install -r /opt/cloudrift/tools/pip-requires"
end

execute "start-api-service" do
	command "uwsgi --ini /opt/cloudrift/etc/rift/cloudrift-api.ini &"
end