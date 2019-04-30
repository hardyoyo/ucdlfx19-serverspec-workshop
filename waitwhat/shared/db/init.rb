shared_examples 'database::init' do

  # port 3306 is open
  %w{3306}.each do |ports|
    describe port(ports) do
      it { should be_listening }
    end
  end

  # Verify services
  %w{mysqld}.each do |svc|
    describe service(svc) do
      it { should be_running }
    end
  end

  # define required packages
  packages = {
    'mysql-community-common' => {
      version: '5.6.41'
    },
    'mysql-community-client' => {
      version: '5.6.41'
    }
  }

  # Verify packages
  packages.each do |name, details|
    describe package(name) do
      it { should be_installed.with_version(details[:version]) }
    end
  end

  # TODO verify command outputs

end
