# automatecluster

vagrant automate cluster or some jawn

This isn't the way _you_ should do it, but it's the way I did it today because I wanted to have an easier time playing with the network traffic between nodes.

## usage

* Download your own packages, put them in the `./packages` directory in this repo
* Download the hostsfile cookbook and extract to `cookbooks/hostsfile`
* If applicable change the filenames in the `./cookbooks/installchef/recipes/*.rb` files
* Drop your delivery.license file in the `./packages` directory
* Run the following command block to load the machines into your hostsfile, modifying as necessary:

```bash
sudo tee -a /etc/hosts <<'EOH'
#
# my automate cluster config
10.1.1.6             automate.top.chef
10.1.1.5             chefserver.top.chef
10.1.1.11            client1.top.chef
10.1.1.12            client2.top.chef
10.1.1.21            runner1.top.chef
#
EOH
```

* Run `make clusterup`
* Get da skrilla

The Chef user is `catcora`, password `knivesout`, key is in `/vagrant/shared/catcora.pem`

Also `delivery` exists, password `knivesout`, key is `/vagrant/shared/delivery.pem`

Automate will be set up using `catcora.pem`, the organization/enterprise is `topchef`

Check the output of the Vagrant provisioning for the automate server for your Automate admin login.

You can see a listing of the nodes in the file [`cookbooks/installchef/recipes/default.rb`](./automatecluster/blob/master/default.rb) as hosts file entries to be placed by Chef when the nodes converge.

I don't recommend you use it, though.

## Not Officially Supported

This is something I hacked out in less than an hour and is not officially supported by Chef Software Inc., or even by me. I'm incredibly surprised by the fact that it works on my machine.
