require 'chefspec'
require_relative 'spec_helper'

describe 'aide::default' do
  before { stub_resources }

  let(:chef_run) { ChefSpec::SoloRunner.new(step_into: ['cron']).converge(described_recipe) }

  it 'installs package' do
    expect(chef_run).to install_package('aide')
  end

  it 'writes config file' do
    chef_run.node.default['aide']['paths'] = { '/data' => '!' }
    expect(chef_run).to create_template('/etc/aide/aide.conf').with_content { |content|
      expect(content).to include('/data')
    }
  end

  it 'notifies generate_database' do
    expect(chef_run.template('/etc/aide/aide.conf')).to notify('bash[generate_database]').to(:run)
  end

  it 'creates cron' do
    expect(chef_run).to create_cron_d('aide')
  end

  it 'creates second cron' do
    expect(chef_run).to create_cron_d('aide-detailed')
  end

  it 'generates database' do
    expect(chef_run).to_not run_bash('generate_database')
  end
end
