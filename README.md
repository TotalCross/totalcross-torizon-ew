Base scripts and resources to make containers for Torizon with TotalCross. #EmbeddedWorld version!

# Disclaimer

This is a repository for Totalcross insiders for production of Torizon containers. There is some scripts and helpers to make it easely.

# Repository topology

To understand repository workflow you need that:

```bash
totalcross-torizon/
├─ bin/
├─ gen/
│   ├─ src/main/java/com/totalcross/
│   │  ├─ HelloWorld.java
│   │  └─ RunHelloWorldApplication.java
│   ├─ build.sh
│   ├─ chime.mp3
│   └─ pom.xml
├─ build.sh
├─ deploy.sh
├─ docker-compose.yaml
├─ Dockerfile
└─ README.md
```

A brief description:
- `/bin/` contains the application binaries to be executed;
- `/gen/` is used to build TotalCross applications, you need to have `TOTALCROSSKEY=<your-key-number>` and `TOTALCROSSSDK=<path-to-your-valid-sdk>` at your environment variables. See more of TotalCross [here](https://learn.totalcross.com/)!
- `/build.sh` script to build *totalcross/app* docker image;
- `/deploy.sh` execute with IP as argument to transfer `docker-compose.yaml` to Torizon.

# Development workflow

Follow the steps:

1. Make some changes at `Dockerfile`;

2. Build new *totalcross/app* docker image:
```console
$ ./build.sh
```

&nbsp;&nbsp;&nbsp;&nbsp;(Optional) Create a tag with you don't want use *latest* tag:
```console
$ docker tag <newest id> totalcross/app:<tag>
```

3. Push your changes (*latest*):
```console
$ docker push totalcross/app:<tag>
```
&nbsp;&nbsp;&nbsp;&nbsp;**WARNING: be careful with stable tags**

4. Make some changes at `docker-compose.yaml`;

5. scp changes to Torizon:
```console
$ ./deploy.sh <host ip>
```

6. In host (Torizon) pull:
```console
$ docker pull totalcross/app:<tag>
```

7. Run your application:
```console
$ docker-compose up -d
```

8. Show the logs:
```console
$ docker-compose logs
```

9. Shutdown:
```console
$ docker-compose down
```

# Debug 

After `docker-compose up -d` if you got a black screen:

1. Verify your docker process:
```console
$ docker-ps
```

2. Kill your broken application docker image process by id:
```
$ docker kill <docker id>
```

3. Enter in docker image terminal:
```
docker run —rm -it -v /tmp:/tmp -v /var/run/dbus/ -v /dev/dri:/dev/dri -u root totalcross/app:latest
```