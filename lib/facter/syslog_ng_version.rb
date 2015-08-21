Facter.add(:syslog_ng_version) do
  setcode do
    Facter::Util::Resolution.exec("/usr/sbin/syslog-ng --version").lines.find { |l| l =~ /^syslog-ng/}.split(' ')[1]
  end
end

