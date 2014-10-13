# -*- mode: ruby -*-
# vi: set ft=ruby :

$script = <<SCRIPT
puppet --force module install puppetlabs-concat --version 1.1.1
puppet --force module install puppetlabs-stdlib --version 4.3.2
/etc/init.d/iptables stop
SCRIPT

Vagrant.configure("2") do |config|
  config.vm.provider :virtualbox do |vb|
    vb.gui = true
    vb.customize [
      "modifyvm", :id,
      "--memory", "512",
      "--cpus", "2",
      "--natdnspassdomain1", "off",
      ]
  end

  config.vm.define :webnode do |webnode|
    webnode.vm.box = "puppet-centos-65-x64"
    webnode.vm.box_url = "http://puppet-vagrant-boxes.puppetlabs.com/centos-65-x64-virtualbox-puppet.box"
    webnode.vm.network :private_network, ip: "10.0.0.20"
    webnode.vm.network :forwarded_port, guest: 8080, host: 8080 # tomcat
    webnode.vm.hostname = "webnode"
    webnode.vm.synced_folder "./", "/etc/puppet/modules/rsyslog", create: true
    webnode.vm.provider :virtualbox do |v|
      v.customize ["modifyvm", :id, "--memory", "1024" ]
    end
    webnode.vm.provision :shell,
      :inline => $script
    webnode.vm.provision :puppet,
      :options => ["--verbose", "--debug", "--summarize"],
      :facter => {
        "fqdn"   => "webnode.sandbox.internal",
      } do |puppet|
        puppet.manifests_path = "./"
        puppet.manifest_file = "vagrant.pp"
        puppet.module_path = "../"
    end
  end
end
