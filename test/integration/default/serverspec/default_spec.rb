require 'spec_helper'

describe file('/opt/jolokia') do
  it { should be_directory }
  it { should be_owned_by 'root' }
end

describe file('/opt/jolokia/jolokia-jvm-1.2.3-agent.jar') do
  it { should be_file }
  it { should be_owned_by 'root' }
end

describe file('/opt/jolokia/jolokia-jvm-agent.jar') do
  it { should be_symlink }
  it { should be_owned_by 'root' }
end
