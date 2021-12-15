# Dockerized Mailoney Honeypot

This repository deals with the dockerisation of the SMTP honeypot Mailoney. This honeypot simulates a vulnerable SMPT server. The containers were built for the hardware platforms x86 as well as ARM and ARM64 and can therefore also be used on hardware platforms such as Raspberry Pi, Odroid, FriendlyArm, Banana Pi, Apple M1 or BeagleBone.

# Honeypot Mailoney

Mailoney is a low interactive SMTP honeypot. Mailoney was written by phin3has and published on Github. The honeypot can emulate different types of vulnerabilities. These include open\_realy (mimicking a mailserver emulating an open relay), postfix\_creds (which only logs login attempts to the smtp server) or schizo\_open\_realy (mimicking both of the above options).

# Installation

The Docker container uses the user mailoney with the user ID 2000 and the group ID 2000. For the container to be able to write its logs on the host system, a user with UserID 2000 and GroupID 2000 must also exist here or be created beforehand.

```
user:~$ sudo groupadd --gid 2000 armedpot
user:~$ sudo useradd --gid 2000 --uid 2000 --create-home --password '*' --shell /bin/bash armedpot
user:~$ sudo usermod -aG docker armedpot
user:~$ sudo su - armedpot
armedpot:~$ git clone https://github.com/armedpot/mailoney.git
armedpot:~$ mkdir -p ~/data/mailoney/log
armedpot:~$ cd mailoney
```

Once the user and the group have been created, the Github repository has been cloned, the corresponding directories have been created and the mailoney directory has been changed, mailoney can be started via Docker Compose as follows:

```
armedpot:~/mailoney$ docker-compose up -d
```

## .env

In the .env file, the version of the Dockerisation can be determined, as well as the necessary parameters that are required for a transmission via HPFeed.

## Docker

Alternatively, the container can also be started via the following Docker command without docker-compose:

```
armedpot:~$ docker run \
    --detach \
    --name mailoney \
    --publish 25:25 \
    --env-file ~/mailoney/.env \
    --volume ~/data/mailoney/log:/home/mailoney/logs \
    --read-only \
    --rm \
    armedpot/mailoney:latest
```

# Links

- Honeypot [Mailoney](https://github.com/phin3has/mailoney) on Github
- [Armedpot](https://hub.docker.com/u/armedpot) on Dockerhub form x86/arm/arm64 images
- [Awesome Honeypots](https://github.com/paralax/awesome-honeypots) on Github
- [hpfeeds](https://github.com/hpfeeds/hpfeeds) on Github
- Deutsche Telekom Security [Tpot](https://github.com/telekom-security/tpotce)
