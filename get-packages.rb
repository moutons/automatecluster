# Download latest artifacts for Ubuntu and Centos to the ./packages directory
# Don't use this, it's not needed since the installs switched to mixlib
#
require 'mixlib/install'

products = ['automate', 'chef-server', 'chefdk', 'chef', 'inspec', 'push-jobs-client', 'push-jobs-server']

Dir.chdir("packages") do
  products.each do |product|
    Mixlib::Install.new(product_name: product, channel: :stable, platform: "ubuntu", platform_version: "16.04", architecture: "x86_64").download_artifact
    Mixlib::Install.new(product_name: product, channel: :stable, platform: "el", platform_version: "7", architecture: "x86_64").download_artifact
  end
end