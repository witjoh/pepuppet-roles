require 'spec_helper'

describe 'roles' do
  context 'supported operating systems' do
    ['Debian', 'RedHat'].each do |osfamily|
      describe "roles class without any parameters on #{osfamily}" do
        let(:params) {{ }}
        let(:facts) {{
          :osfamily => osfamily,
        }}

        it { should compile.with_all_deps }

        it { should contain_class('roles::params') }
        it { should contain_class('roles::install').that_comes_before('roles::config') }
        it { should contain_class('roles::config') }
        it { should contain_class('roles::service').that_subscribes_to('roles::config') }

        it { should contain_service('roles') }
        it { should contain_package('roles').with_ensure('present') }
      end
    end
  end

  context 'unsupported operating system' do
    describe 'roles class without any parameters on Solaris/Nexenta' do
      let(:facts) {{
        :osfamily        => 'Solaris',
        :operatingsystem => 'Nexenta',
      }}

      it { expect { should contain_package('roles') }.to raise_error(Puppet::Error, /Nexenta not supported/) }
    end
  end
end
