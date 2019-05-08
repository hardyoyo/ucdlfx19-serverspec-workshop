shared_examples 'railsapp::init' do

  # verify paths (not exclusive, just a few very important folders)
  %w{/opt/californica /opt/derivatives /opt/californica/releases /opt/californica/shared}.each do |paths|
    describe file(paths) do
      it { should be_directory }
      it { should be_owned_by 'deploy' }
      it { should be_grouped_into 'deploy' }
      it { should be_mode 755 }
    end
  end

  # define required packages
  # not an exhaustive list, just a few key ones without which we'd be doomed, like Ruby, Imagemagick, etc.
  # Define packages
  packages = {
    'ruby' => {
      version: '2.5.1'
    },
    'ImageMagick' => {
      version: '6.7.8.9'
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
