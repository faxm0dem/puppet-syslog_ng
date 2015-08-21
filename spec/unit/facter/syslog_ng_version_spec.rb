require "spec_helper"

describe Facter::Util::Fact do
  before {
    Facter.clear
  }

  describe "syslog_ng" do
    context 'returns version' do
      it do
        output = <<-EOS
syslog-ng 3.7.1
Installer-Version: 3.7.1
Revision:
Compile-Date: Aug 17 2015 14:25:00
Available-Modules: afamqp,basicfuncs,linux-kmsg-format,csvparser,system-source,sdjournal,afsmtp,afmongodb,mod-java,riemann,afsocket,cryptofuncs,trigger-source,afstomp,lua,confgen,rust,rss,afuser,affile,afsql,dbparser,tfgetent,geoip-plugin,graphite,pseudofile,mod-perl,kvformat,grok-parser,json-plugin,afprog,basicfuncs-plus,monitor-source,syslogformat,mod-python,date-parser
Enable-Debug: off
Enable-GProf: off
Enable-Memtrace: off
Enable-IPv6: on
Enable-Spoof-Source: off
Enable-TCP-Wrapper: off
Enable-Linux-Caps: off
        EOS
        Facter::Util::Resolution.expects(:exec).with("/usr/sbin/syslog-ng --version").returns(output)
        Facter.value(:syslog_ng_version).should == "3.7.1"
      end
    end
  end
end
