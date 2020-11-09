# Greenbone Vulnerability Management in Docker

![Dashboard](https://github.com/asilha/gvm-docker/raw/master/images/Dashboard.png)

## How to use this repository

### Clone it from GitHub

```console
git clone https://github.com/asilha/gvm-docker.git
```

### [Optional] Build your own Docker images

My prebuilt Docker images are available at [Docker Hub](https://hub.docker.com/u/asilha). If you want to be extra careful, you can build your own. Of course, this may take a long time, depending on your platform ([see my build log](https://gist.github.com/asilha/6ea282d190b23322c3136af0dff7befd)).

```console
cd gvm-docker/dockerfile
./build-stable.sh
cd ../..
```

### Run your containers

**Note:** By default, GSA listens on ports `tcp/80` and `tcp/443`. Make sure nothing else is using these ports or change them in `docker-compose.yml`.

There are two options to run GVM:

#### 1. Running with Docker Compose

```console
cd gvm-docker/docker-compose/stable
docker-compose -p gvm -f docker-compose.yml up -d
```

#### 2. Running Docker Compose from Ansible

```console
cd ansible-gvm
ansible-playbook start_gvm.yml
```

### Access GVM

Get the 'admin' password:

```console
docker logs gvm_gvm-gvmd_1 2> /dev/null | grep 'password:'
```

![ShowPassword](https://github.com/asilha/gvm-docker/raw/master/images/ShowPassword.png)

[Optional] Reset the 'admin' password:

```console
docker exec -ti gvm_gvm-gvmd_1 gvmd --user=admin --new-password=gvmpass
```

![ChangePassword](https://github.com/asilha/gvm-docker/raw/master/images/ChangePassword.png)

Open the Greenbone Security Assistant console. 

By default, it will be available at <https://localhost>.

You can find the documentation for GSA [here](https://docs.greenbone.net/).

## License

This repository and its Docker images are licensed under the BSD 3-Clause License, see [LICENSE](LICENSE.md).

## Acknowledgment

Thanks to user @dgiorgio for the original GH repository.