# openrct2docker
This is a docker container, that is capable of running a [OpenRCT2](http://openrct2.org/) server in a headless mode (dedicated Server).

# Usage
To run this container you have to own the files of the orginal game. Information of how to get the game files on linux can be found [here](https://github.com/OpenRCT2/OpenRCT2/wiki/Installation-on-Linux#installing-the-game). The needed files are listed [here](https://github.com/OpenRCT2/OpenRCT2/wiki/Required-RCT2-files)

## Build the game
When building the container, the latest commit from the [OpenRCT2 repository](https://github.com/OpenRCT2/OpenRCT2) is pulled and compiled.
``` shell
docker-compose build
```
To force a new compilation, run this command with the `--no-chache` flag.

## Define environment variables
To run the container you need to mount 3 volumes and specify the port on the host. They are specified via environment variables. Simply copy the .env-example file and fill in your data.
```shell
cp .env-example .env
nano .env
```

- `PORT`: specifies the port on the host that is used for the server
- `GAME_FOLDER`: the directory on the orginal game files
- `CONFIG_FOLDER`: folder that contains the config file (e.g. ./config)
- `SAVEGAME`: the savegame the server is running

## Run the container
``` shell
docker-compose up -d
```

# Additional info
You can configure your server by manipulating the `config.ini`. All savegames and chat logs are saved on the host in the config folder.

## Set privileges
The provided `groups.json` file specifies `admin` as default privilege. You should change that after connecting to the server.
