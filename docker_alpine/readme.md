## Dependencies on windows

Install docker and git with Chocolatey:

```
Set-ExecutionPolicy -ExecutionPolicy RemoteSigned -Force                     
iwr https://chocolatey.org/install.ps1 -UseBasicParsing | iex
choco install git.install -y
choco install docker-desktop
```

Execute the following powershell command to enable Hyper -v

```
Enable-WindowsOptionalFeature -Online -FeatureName Microsoft-Hyper-V -All
```

A system restart is required to make the docker work wth Hyper-v

## Running the Docker

To build this image from the directory it is in use

```
docker build -t docker_ansible .
```

To start the image without 'ENTRYPOINT' in the Dockerfile

```
docker run --rm -it --name "ansible" -v ${PWD}:/ansible/playbooks docker_ansible
```

Without the Entrypoint
From the CLI of the container run the playbook

```
ansible-playbook playbook.yml
```

Usage with the 'ENTRYPOINT' in the Dockerfile

```
docker run --rm -it --name "ansible" -v ${PWD}:/ansible/playbooks docker_ansible playbook.yml
```
