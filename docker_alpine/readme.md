## Dependencies

Lookup docker install choco
Hyper -v powershellcd 

### Windows 


To build this image from the directory it is in use

```
docker build -t docker_ans .
```

To start the image

```
docker run -it --name "ansible" docker_ans`
```

To start the image

```
docker run --rm -it --name "ansible" -v ${PWD}:/ansible/playbooks docker_ans
```


TODO TESTING WITH THE ENTRY POINT