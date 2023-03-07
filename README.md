# Sonic Robo Blast 2 Kart Docker

This is a docker container for [SRB2Kart](https://mb.srb2.org/addons/srb2kart.2435/) for ease of setting up a server. It automatically downloads and builds the source code from the public [SRB2Kart releases](https://github.com/STJr/Kart-Public/releases).

## Environment Variables

- `ROOM_ID`: If specified it will advertise the server on the [master server](https://wiki.srb2.org/wiki/Master_Server). It specifies in which room ID it should be advertised.
- `PASSWORD`: Sets the password to [log in](https://wiki.srb2.org/wiki/Console/Commands#login) as an administrator on the server within the game.

## Persistent Data

You might want to persist some of the data the SRB2Kart server uses on your host system through volumes.

### Addons

This folder is mapped as a volume at `/addons` and should be used to store addons for the game, which will automatically be loaded into the server. The files in here must not contain any spaces in their filenames.

### Data

This folder is mapped as a volume at `/data` and holds general game data, and configuration files. Some notable files are:

- `config.cfg`: general game configuration and [console variables](https://wiki.srb2.org/wiki/Console/Variables).
- `adedsrv.cfg`: A [console script](https://wiki.srb2.org/wiki/Console_script) file that automatically gets loaded when starting the dedicated server. For example setting a nice [colored servername](https://mb.srb2.org/threads/colored-server-name-tutorial-chat-text-transparency.25474/).

### Logs

This folder is mapped as a volume at `/logs` and contains text files that are automatically created by the server for logging purposes. One notable file is `ban.txt` which stores information on banned players. Deleting this will also cause banned players to be unbanned. See: [Data files#Log files](https://wiki.srb2.org/wiki/Data_files#Log_files)

### Luafiles

This folder is mapped as a volume at `/luafiles` and stores files created by lua scripts. Some addons might assume that this folder will persist for them to write data to.

## Running With Docker

To run the server normally with docker, just execute

```sh
docker run -it --name srb2kart -v /path/on/host/addons:/addons -v /path/on/host/data:/data -v /path/on/host/logs:/logs -v /path/on/host/luafiles:/luafiles -e ROOM_ID=33 -p 5029:5029/udp aliciabytes/srb2kart:latest
```

## Running With Docker Compose

TBD