package 'aide' do
  action :install
end

template node['aide']['config'] do
  notifies :run, 'bash[generate_database]', :delayed
  variables(
    database: node['aide']['database'],
    database_out: node['aide']['database_out'],
    gzip_dbout: node['aide']['gzip_dbout'],
  )
end

cron_d 'aide' do
  action :create
  minute '30'
  user 'root'
  command "#{node['aide']['binary']} #{node['aide']['extra_parameters']} --check -V3"
end

cron_d 'aide-detailed' do
  action :create
  minute '0'
  hour '5'
  weekday '1'
  user 'root'
  command "#{node['aide']['binary']} #{node['aide']['extra_parameters']} --check -V5"
end

file '/etc/cron.daily/aide' do
  action :delete
end

bash 'generate_database' do
  action :nothing
  not_if { node['aide']['testmode'] == 'true' || File.exists?(node['aide']['database_out']) }
  code "#{node['aide']['binary']} #{node['aide']['extra_parameters']} --init"
end
