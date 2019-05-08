shared_examples 'proxy::init' do

  # ports 80, 443 are open
  %w{80 443}.each do |ports|
    describe port(ports) do
      it { should be_listening }
    end
  end

  # Verify services
  %w{httpd}.each do |svc|
    describe service(svc) do
      it { should be_running }
    end
  end

  # # verify paths (not exclusive, just a few very important folders)
  # %w{/opt/californica /opt/derivatives /opt/californica/releases /opt/californica/shared}.each do |paths|
  #   describe file(paths) do
  #     it { should be_directory }
  #     it { should be_owned_by 'deploy' }
  #     it { should be_grouped_into 'deploy' }
  #     it { should be_mode 755 }
  #   end
  # end

  # define required packages
  # not an exhaustive list, just a few key ones without which we'd be doomed, like Ruby, Imagemagick, etc.
  # Define packages
  packages = {
    'httpd' => {
      version: '2.4.6'
    },
    'httpd-devel' => {
      version: '2.4.6'
    },
    'httpd-tools' => {
      version: '2.4.6'
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
