#
# Cookbook Name:: jolokia-jvm-agent
# Spec:: default
#
require 'spec_helper'

describe 'jolokia-jvm-agent::default' do
  platforms = {
    'centos' => ['6.6', '7.0'],
    'ubuntu' => ['14.04']
  }

  platforms.each do |platform, versions|
    versions.each do |version|
      context "on #{platform.capitalize} #{version}" do
        let(:chef_run) do
          ChefSpec::SoloRunner.new(log_level: :error, platform: platform, version: version) do |node|
            node.set['jolokia-jvm-agent']['version'] = '1.3.2'
            node.set['jolokia-jvm-agent']['dir'] = '/opt/jolokia'
          end.converge(described_recipe)
        end

        it 'should create the default jolokia-jvm-agent installation directory' do
          expect(chef_run).to create_directory('/opt/jolokia').with(owner: 'root')
        end

        it 'creates the jolokia-jvm-agent jar file' do
          expect(chef_run).to create_remote_file('/opt/jolokia/jolokia-jvm-1.3.2-agent.jar').with(owner: 'root')
        end

        it 'creates a link to the jolokia-jvm-agent' do
          expect(chef_run).to create_link('/opt/jolokia/jolokia-jvm-agent.jar').with(
            to: '/opt/jolokia/jolokia-jvm-1.3.2-agent.jar')
        end
      end
    end
  end
end
