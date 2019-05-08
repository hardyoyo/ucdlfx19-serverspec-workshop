shared_examples 'database::init' do

  # port 5432 is open
  %w{5432}.each do |ports|
    describe port(ports) do
      it { should be_listening }
    end
  end

  # Verify services
  %w{postgresql}.each do |svc|
    describe service(svc) do
      it { should be_running }
    end
  end

  # define required packages
  packages = {
    'postgresql-10' => {
      version: '10.7-0ubuntu0.18.04.1]'
    },
    'postgresql-client-10' => {
      version: '10.7-0ubuntu0.18.04.1]'
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
