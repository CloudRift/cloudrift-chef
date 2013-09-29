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

# Configure based on external dependencies.
template "/opt/cloudrift/etc/rift/rift.conf" do
  source "rift.conf.erb"
  variables({
    :log_level => "DEBUG",
    :mongodb_host => node[:cloudrift_api][:mongodb_host],
    :mongodb_port => node[:cloudrift_api][:mongodb_port],
    :mongodb_db => node[:cloudrift_api][:mongodb_db],
    :rabbitmq_user => node[:cloudrift_api][:rabbitmq_user],
    :rabbitmq_host => node[:cloudrift_api][:rabbitmq_host]
  })
end

execute "kill-uwsgi" do
	command "killall -9 uwsgi 2>&1 || true"
end

execute "start-api-service" do
	cwd "/opt/cloudrift"
	environment ({'PYTHONPATH' => '/opt/cloudrift'})
	command "uwsgi --logto /opt/cloudrift/logs --ini #{node[:cloudrift_api][:uwsgi_ini]} &"
end