require 'spec_helper'

describe 'ntp' do

  ['Debian', 'RedHat'].each do |system|
    let(:facts) {{ :osfamily => system }}

    it { should include_class('rsyslog::client::setup') }

    describe 'tell node you are syslog server' do
      let(:params) {{
        :server       => true,
        :syslogserver => '127.0.0.1',
      }}
      it { should include_class('rsyslog::client::setup') }
    end

    describe "rsyslog::install on #{system}" do
      it { should contain_file('/etc/rsyslog.d').with_owner('root') }
      it { should contain_file('/etc/rsyslog.d').with_group('root') }
      it { should contain_file('/etc/rsyslog.d').with_mode('0750') }
    end
  end
end