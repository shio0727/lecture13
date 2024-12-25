require 'spec_helper'

listen_port = 80

describe package('nginx') do
  it { should be_installed }
end

describe command('yarn --version') do
  let(:disable_sudo) { true }
  its(:stdout) { should match /^1\.22\.19/ }
end

describe command('node --version') do
  let(:disable_sudo) { true }
  its(:stdout) { should match /^v17\.9\.1$/ }
end

describe command('/home/ec2-user/.rbenv/shims/ruby -v') do
  its(:stdout) { should include "ruby 3.2.3" }
end
describe service('nginx') do
  it { should be_running }
end
describe package('nginx') do
  it { should be_installed.with_version('1.22.1') }
end
describe port(3306) do
    it { should be_listening }
end
describe service('mysqld') do
  it { should be_enabled   }
  it { should be_running   }
end
describe port(listen_port) do
  it { should be_listening }
end

describe command('curl http://127.0.0.1:#{listen_port}/_plugin/head/ -o /dev/null -w "%{http_code}\n" -s') do
  its(:stdout) { should match /^200$/ }
end