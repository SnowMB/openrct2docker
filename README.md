# openrct2docker
This is a docker container, that is capable of running a [OpenRCT2](http://openrct2.org/) server in a headless mode (dedicated Server).

# Usage
To run this container you have to own the files of the orginal game. Information of how to get the game files on linux can be found [here](https://github.com/OpenRCT2/OpenRCT2/wiki/Installation-on-Linux#installing-the-game). The needed files are listed [here](https://github.com/OpenRCT2/OpenRCT2/wiki/Required-RCT2-files).

## Edit config file
You will need a `config.ini` file mounted to the host to run the game properly. You can find an example file [here](https://github.com/SnowMB/openrct2docker/tree/master/config).

Make sure that `game_path` is set to this value: 

```
...
game_path = "/openrct2/original_files"
...
```

You'll want to configure your server info:

```
...
[network]
player_name = "server" 
default_password = "password"
advertise = true
maxplayers = 16
server_name = "headless-server"
server_description = ""
server_greeting = ""
master_server_url = ""
provider_name = ""
provider_email = ""
provider_website = ""
known_keys_only = false
log_chat = true
...
```

## Run the container
To run the container you need to mount the config file, the original game files and the save game / scenario you want to run.  The paths inside the container are:

- `/openrct2/original_files/`: the directory on the orginal game files
- `/root/.config/OpenRCT2/`: folder that contains the config.ini file. Will also be the directory for auto-saves, chatlogs, group and user settings.
- `/openrct2/game.sc6`: the savegame the server is running

The container runs the OpenRCT2 server and exposes the port `11753`. You have to map it to any port on the host.

```shell
docker run -p <PORT>:11753 -v <GAME_FOLDER>:/openrct2/original_files/ -v <CONFIG_FOLDER>:/root/.config/OpenRCT2/ -v <SAVEGAME>:/openrct2/game.sc6 snowmb/openrct2docker:latest
```

## Using `docker-compose`
You can also use a simple docker-compose file. An example is provided in the [Github Repository](https://github.com/SnowMB/openrct2docker/blob/master/docker-compose.yml). It uses environment variables in an `.env` file to specify the paths and port on the host.

```shell
cp .env-example .env
nano .env
```

- `PORT`: specifies the port on the host that is used for the server
- `GAME_FOLDER`: the directory on the orginal game files
- `CONFIG_FOLDER`: folder that contains the config file (e.g. ./config)
- `SAVEGAME`: the savegame the server is running

You can than run the container with 
``` shell
docker-compose up -d
```

## Set privileges
The provided `groups.json` file specifies `admin` as default privilege. You should change that after connecting to the server.


# Working with the GitHub Repository
Instead of pulling the image from [Docker Hub](https://hub.docker.com/r/snowmb/openrct2docker/), you can build it from the [Github Repository](https://github.com/SnowMB/openrct2docker). The base image is from the OpenRCT2 Projekt and can be found [here](https://hub.docker.com/r/openrct2/openrct2/) ([Dockerfile](https://github.com/OpenRCT2/OpenRCT2/tree/develop/dockerfiles))

## Build the game
When building the container, the latest commit from the [OpenRCT2 repository](https://github.com/OpenRCT2/OpenRCT2) is pulled and compiled.
``` shell
docker build .
```
To force a new compilation, run this command with the `--no-chache` flag.
