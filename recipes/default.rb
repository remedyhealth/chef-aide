package 'aide' do
  action :install
end

template node['aide']['config'] do
  notifies :run, 'bash[update_aideconf]', :delayed
  variables(
    database: node['aide']['database'],
    database_out: node['aide']['database_out'],
    gzip_dbout: node['aide']['gzip_dbout'],
    paths: node['aide']['paths'],
    macros: node['aide']['macros']
  )
end

template '/usr/local/bin/aide_slack_hook' do
  source 'aide_slack_hook.erb'
  mode '0755'
  variables(
    slack_webhook_url: node['aide']['slack_webhook_url']
  )
end

template '/etc/default/aide' do
  source 'aide_default.erb'
  notifies :run, 'bash[update_aideconf]', :delayed
  variables(
    mailto: node['aide']['mailto'],
    command: node['aide']['command'],
    cron_hook: node['aide']['cron_hook'],
    quiet_reports: node['aide']['quiet_reports']
  )
end

bash 'update_aideconf' do
  action :nothing
  not_if { node['aide']['testmode'] == 'true' }
  code '/usr/sbin/update-aide.conf'
  notifies :run, 'bash[generate_database]', :delayed
end

bash 'generate_database' do
  action :nothing
  code "#{node['aide']['binary_init']} #{node['aide']['extra_parameters']}"
end
