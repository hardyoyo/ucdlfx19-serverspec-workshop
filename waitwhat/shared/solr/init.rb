shared_examples 'solr::init' do

  # port 8983 is open
  %w{8983}.each do |ports|
    describe port(ports) do
      it { should be_listening }
    end
  end

  # Verify services
  %w{solr}.each do |svc|
    describe service(svc) do
      it { should be_running }
    end
  end

  # TODO: define required packages
  # not an exhaustive list, just a few key ones without which we'd be doomed, like Ruby, Imagemagick, etc.
  # Define packages
  # packages = {
  #   'ruby' => {
  #     version: '2.5.1'
  #   },
  #   'ImageMagick' => {
  #     version: '6.7.8.9'
  #   },
  #   'httpd' => {
  #     version: '2.4.6'
  #   }
  # }
#
  # # Verify packages
  # packages.each do |name, details|
  #   describe package(name) do
  #     it { should be_installed.with_version(details[:version]) }
  #   end
  # end

  # TODO verify command outputs



end
