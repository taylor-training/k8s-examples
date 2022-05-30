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
# use actual ip address of instance
# Save and close the file

# allow other users to see contents of k3s config file
sudo chmod +r /etc/rancher/k3s/k3s.yaml

# Edit ~/.profile to add KUBECONFIG env to ubuntu user, add line:
# - Do this if planning to use server instance as admin system
export KUBECONFIG=/etc/rancher/k3s/k3s.yaml

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
## Local Admin of K3S Cluster

Assuming kubectl is available on your local system, to use that instead of logging into the k3s-server or instance as the "admin" system, you can copy the kubeconfig from the k3s-server locally.

### Mac (Homebrew) Kubernetes CLI Install

```bash
# install kubernetes tools (kubectl) and Helm
brew install kubernetes-cli helm
# restart local terminal session

# should show path within homebrew dir
which kubectl

# ask for version to confirm
kubectl version --short=true --client=true
```

### Transfer K3S Config Locally

```bash
# Transfer k3s config to local (host) system
# - Can adjust path to place file in preferred directory, adjust other commands accordingly
multipass transfer k3s-server:/etc/rancher/k3s/k3s.yaml ~/k3s-config.yaml

# edit k3s-config.yaml - update "server" field with IP address of k3s-server
# - Use nano or code command depending on if VSCode is installed
code ~/k3s-config.yaml

# update zsh or bash profile to export KUBECONFIG env to k3s config file
# - can use "code" instead of "nano" if VSCode is installed
nano ~/.zshrc  # Mac
# or
nano ~/.bashrc # Windows (GitBash) or Linux
# or
nano ~/.profile # Ubuntu instance

# Contents of profile script (add line):
export KUBECONFIG=~/k3s-config.yaml
# save and close profile file
# restart local terminal session
# - OR, run export command directly in terminal session

# Test local kubectl with k3s:
kubectl get nodes
```