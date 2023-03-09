# Sonic Robo Blast 2 Kart Docker

This is a docker container for [SRB2Kart](https://mb.srb2.org/addons/srb2kart.2435/) for ease of setting up a server. It automatically downloads and builds the source code from the public [SRB2Kart releases](https://github.com/STJr/Kart-Public/releases).

## Docker Tags

The tags for this container will be in varying granularities. As a basis you have the following tags:

- `latest`: Always the latest major and minor version.
- `<major_version>`: E.g. `alicianibbles/srb2kart:1`. This is the latest docker image in that major version. This might update minor versions on the go as well as dependencies being updated.
- `<major_version>.<minor_version>`: E.g. `alicianibbles/srb2kart:1.6`. This is the latest docker image with the respective major and minor version. This might still update dependencies on the fly while keeping a constant major and minor version.
- `<major_version>.<minor_version>.<build_number>`: This one is a specific major and minor version pinned to a specific build. This one won't have any parts updated and will be a completely stable image.

## Environment Variables

- `ROOM_ID`: If specified it will advertise the server on the [master server](https://wiki.srb2.org/wiki/Master_Server). It specifies in which room ID it should be advertised.
- `PASSWORD`: Sets the password to [log in](https://wiki.srb2.org/wiki/Console/Commands#login) as an administrator on the server within the game.
- `BANDWIDTH`: Sets the bandwidth in bytes per second. Default is 30000 bytes per second, minimum allowed value is 1000 bytes per second.
- `EXTRATIC`: Specifies up to how many extra previous tics to send to the client per server tic.
- `IPV6`: Listens to incoming IPv6 connections. Warning, this is untested.
- `PACKETSIZE`: Changes the size of UDP packets sent.
- `SERVERPORT`: Specifies the UDP port to use. Default is 5029.
- `USEUPNP`: Turns on Universal Plug and Play support. This feature is untested.

For more information see the official documentation on [Command-line parameters](https://wiki.srb2.org/wiki/Command_line_parameters) since the environment variables for the docker container mirror those. You can also pass them as command-line arguments, but environment variables are recommended.

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
