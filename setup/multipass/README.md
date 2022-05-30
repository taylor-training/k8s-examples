# K3S

### Requirements

 * System with Multi-pass installed
 * A text editor to take notes
 * Active connection to the Internet

## K3 Server

### Create K3s Server Instance

```bash
# Create K3s Server instance
multipass launch jammy -n k3s-server --cloud-init common.yaml

# make note of IP address of instance (IPv4 field)
multipass info k3s-server

# Login to server instance
multipass shell k3s-server
```

Once logged into the k3s server instance:
* Set the server token (optional) - will be generated if not set
* Run K3s server install script

Within the server instance:

```bash 
# Install K3s (server mode) with specific secret
curl -sfL https://get.k3s.io | sudo K3S_TOKEN=mysecret sh -

# Update hosts file to point "k3s-server" to instance ip address
sudo nano /etc/hosts

# add line to /etc/hosts
192.168.64.16 k3s-server
# use actual ip address of instanceß
# Save and close the file

# Exit Server instance
exit
```

Grab the IP address of K3s Server instance:

```bash
multipass info k3s-server
```

If multiple IP Addresses, normally the top one. Copy and put into note taking app for later reference.

### Create K3s Worker Nodes

For each worker node desire (recommend 3 or more - odd numbers):

 * Create instance
 * Edit /etc/hosts to add k3s-server entry
 * Run k3s script specifying token and k3s server URL
 * Return to k3s server to confirm nodes have joined

## K3 Nodes

It is recommended to setup at least 3 or more odd numbered worker nodes (3,5,7,etc).

```bash
# repeat for each node wanted
multipass launch jammy -n k3s-node1 --cloud-init common.yaml
multipass shell k3s-node1
```

Within the worker node instance:

```bash
# Update hosts file to point "k3s-server" to instance ip address
sudo nano /etc/hosts

# add line to /etc/hosts
192.168.64.16 k3s-server
# Save and close the file

# Install K3s in agent mode
curl -sfL https://get.k3s.io | sudo K3S_TOKEN=mysecret K3S_URL=https://k3s-server:6443 sh -

# exit out of 
exit
```