package 'aide' do
  action :install
end

template node['aide']['config'] do
  notifies :run, 'script[generate_database]', :delayed
end

template '/etc/cron.d/aide' do
  action :create
  notifies :restart, "service[#{node['aide']['cron_service']}]"
end

service node['aide']['cron_service'] do
  action :nothing
end

bash 'generate_database' do
  action :nothing
  not_if { node['aide']['testmode'] == 'true' }
  code "#{node['aide']['binary']} #{node['aide']['extra_parameters']} --init"
end
