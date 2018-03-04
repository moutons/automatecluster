# automatecluster

vagrant automate cluster or some jawn

This isn't the way _you_ should do it, but it's the way I did it today because I wanted to have an easier time playing with the network traffic between nodes.

## usage

* Download your own packages, put them in the `./packages` directory in this repo
* If applicable change the filenames in the `./cookbooks/installchef/recipes/*.rb` files
* Drop your delivery.license file in the `./packages` directory

I don't recommend you use it, though.
