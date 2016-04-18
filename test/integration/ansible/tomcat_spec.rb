describe port(8080) do
  it { should be_listening }
end

describe port(22) do
  it { should be_listening }
end

describe package('ansible') do
  it { should be_installed }
end

describe package('java-1.7.0-openjdk') do
  it { should be_installed }
end

describe user('tomcat') do
  it { should exist }
end

describe group('tomcat') do
  it { should exist }
end

describe file('/opt/apache-tomcat-7.0.61') do
  it { should be_directory }
  it { should be_owned_by 'tomcat' }
end

describe file('/usr/share/tomcat/conf/server.xml') do
  it { should be_file }
  it { should be_owned_by 'tomcat' }
end

describe file('/etc/init.d/tomcat') do
  it { should be_file }
  it { should be_owned_by 'root' }
end

describe service('tomcat') do
  it { should be_installed }
  it { should be_enabled }
  it { should be_running }
end
