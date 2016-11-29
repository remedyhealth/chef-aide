#
# Cookbook Name:: aide
# Attributes:: default
#

# Use test mode to disable rebuilding the aide database every run.
# This is desinged to save you time while working on building
# your cookbook that relays on this one. Return to false when
# rolling out to any non development enviorment.
default['aide']['testmode'] = 'false'

default['aide']['dbdir'] = '/var/lib/aide'
default['aide']['gzip_dbout'] = 'yes'
default['aide']['report_url'] = 'stdout'
default['aide']['verbose'] = '5'
default['aide']['database'] = '/var/lib/aide/aide.db'
default['aide']['database_out'] = '/var/lib/aide/aide.db.new'
default['aide']['mailto'] = 'root'
default['aide']['command'] = 'check'
default['aide']['quiet_reports'] = 'yes'
default['aide']['cron_hook'] = '/usr/local/bin/aide_slack_hook'
default['aide']['slack_webhook_url'] = nil
default['aide']['binary'] = '/usr/bin/aide'
default['aide']['binary_init'] = '/usr/sbin/aideinit'
default['aide']['config'] = '/etc/aide/aide.conf'
default['aide']['extra_parameters'] = "-c #{node['aide']['config']} -y -f"
default['aide']['cron_service'] = 'cron'
default['aide']['hourly'] = true

default['aide']['macros'] = {
  'NORMAL' => 'L+rmd160+sha256',
  'PERMS' => 'p+i+u+g+acl+selinux',
  'LOG' => '>',
  'LSPP' => 'R+sha256',
  'DATAONLY' => 'p+n+u+g+s+acl+selinux+xattrs+md5+sha256+rmd160+tiger'
}

default['aide']['paths'] = {
  '/boot' => 'NORMAL',
  '/bin' => 'NORMAL',
  '/sbin' => 'NORMAL',
  '/lib' => 'NORMAL',
  '/lib64' => 'NORMAL',
  '/opt' => 'NORMAL',
  '/usr' => 'NORMAL',
  '/root' => 'NORMAL',
  '/usr/src' => '!',
  '/usr/tmp' => '!',
  '/tmp' => '!',
  '/run' => '!',
  '/srv' => '!',
  '/mnt' => '!',
  '/etc' => 'PERMS',
  '/etc/mtab$' => '!',
  '/etc/.*~' => '!',
  '/etc/exports$' => 'NORMAL',
  '/etc/fstab$' => 'NORMAL',
  '/etc/passwd$' => 'NORMAL',
  '/etc/group$' => 'NORMAL',
  '/etc/gshadow$' => 'NORMAL',
  '/etc/shadow$' => 'NORMAL',
  '/etc/security/opasswd$' => 'NORMAL',
  '/etc/hosts.allow$' => 'NORMAL',
  '/etc/hosts.deny$' => 'NORMAL',
  '/etc/sudoers$' => 'NORMAL',
  '/etc/skel' => 'NORMAL',
  '/etc/logrotate.d' => 'NORMAL',
  '/etc/resolv.conf$' => 'DATAONLY',
  '/etc/nscd.conf$' => 'NORMAL',
  '/etc/securetty$' => 'NORMAL',
  '/etc/profile$' => 'NORMAL',
  '/etc/bashrc$' => 'NORMAL',
  '/etc/bash_completion.d/' => 'NORMAL',
  '/etc/login.defs$' => 'NORMAL',
  '/etc/zprofile$' => 'NORMAL',
  '/etc/zshrc$' => 'NORMAL',
  '/etc/zlogin$' => 'NORMAL',
  '/etc/zlogout$' => 'NORMAL',
  '/etc/profile.d/' => 'NORMAL',
  '/etc/X11/' => 'NORMAL',
  '/var/log' => '!',
  '/var/spool/postfix' => '!',
  '/var/chef' => '!',
  '/var/lib/gems' => '!',
  '/var/lib/apt' => '!',
  '/var/lib/postfix/' => '!',
  '/var/lib/apt-xapian-index' => '!',
  '/var/lib/ubuntu-release-upgrader/release-upgrade-available' => '!',
  '/var/lib/logrotate' => '!',
  '/usr/local/rvm/log' => '!',
  '/root/.cache/pip' => '!',
  '/var/lib/aide/aide.db' => '!',
  '/environment' => '!',
  '/var/lib/update-notifier' => '!',
  '/var/lib/sudo' => '!',
  '/var/cache' => '!',
  '/.cache' => '!',
  '/home/.*' => '!',
  '/opt/datadog-agent/run' => '!',
  '/var/lib/rkhunter' => '!',
  '/var/run/utmp$' => 'LOG',
  '/etc/audit/' => 'LSPP',
  '/etc/libaudit.conf$' => 'LSPP',
  '/var/spool/at$' => 'LSPP',
  '/etc/at.allow$' => 'LSPP',
  '/etc/at.deny$' => 'LSPP',
  '/etc/cron.allow$' => 'LSPP',
  '/etc/cron.deny$' => 'LSPP',
  '/etc/cron.d/' => 'LSPP',
  '/etc/cron.daily/' => 'LSPP',
  '/etc/cron.hourly/' => 'LSPP',
  '/etc/cron.monthly/' => 'LSPP',
  '/etc/cron.weekly/' => 'LSPP',
  '/etc/crontab$' => 'LSPP',
  '/var/spool/cron/root$' => 'LSPP',
  '/etc/login.defs' => 'LSPP',
  '/etc/securetty' => 'LSPP',
  '/etc/hosts$' => 'LSPP',
  '/etc/sysconfig' => 'LSPP',
  '/etc/inittab$' => 'LSPP',
  '/etc/grub/' => 'LSPP',
  '/etc/rc.d' => 'LSPP',
  '/etc/ld.so.conf$' => 'LSPP',
  '/etc/localtime$' => 'LSPP',
  '/etc/sysctl.conf$' => 'LSPP',
  '/etc/modprobe.conf$' => 'LSPP',
  '/etc/pam.d' => 'LSPP',
  '/etc/security' => 'LSPP',
  '/etc/aliases' => 'LSPP',
  '/etc/postfix' => 'NORMAL',
  '/etc/ssh/sshd_config$' => 'LSPP',
  '/etc/ssh/ssh_config$' => 'LSPP',
  '/etc/issue$' => 'LSPP',
  '/etc/issue.net$' => 'LSPP',
  '/etc/chef/client.rb$' => 'LSPP',
  '/etc/chef/client.pem$' => 'LSPP',
  '/etc/chef/trusted_certs$' => 'LSPP',
  '/etc/rsyslog.conf$' => 'LSPP',
  '/etc/rsyslog.d/' => 'LSPP',
  "/root/\.viminfo$" => '!',
  "/root/\..*" => 'PERMS',
  "=/$" => "NORMAL"
}

default['aide']['extra_paths'] = {}
