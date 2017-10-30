require 'spec_helper'

describe 'timezone', :type => :class do
  on_supported_os.each do |os, facts|

    let(:facts) do
      facts.merge({
        :path => '/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin:/snap/bin:/snap/bin:/opt/puppetlabs/bin',
      })
    end

    context "on #{os}" do
      it { is_expected.to compile }
    end
  end
end
