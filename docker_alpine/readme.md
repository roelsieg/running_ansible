## Dependencies

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

A system restart is required to make the docker 

### Windows 


To build this image from the directory it is in use

```
docker build -t ansible .
```

To start the image

```
docker run --rm -it --name "ansible" -v ${PWD}:/ansible/playbooks ansible
```


From the CLI of the container run the playbook

```
/root/.local/bin/ansible /ansible/playbooks/playbook.yml
```
TODO TESTING WITH THE ENTRY POINT