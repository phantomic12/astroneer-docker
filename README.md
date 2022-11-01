# Astroneer Linux

This image is meant to be deployed to a remote server (eg kubernetes) but you can also use it locally.

## Requirements

Docker

## Getting started

Run the latest docker image

```
docker run -ti -e OWNER_NAME=yoursteamname -e OWNER_GUID=yoursteamguid -p 30877:30877/udp  registry.gitlab.com/altercode/astroneer-linux:latest
```

Replace _yoursteamname_ and _yoursteamguid_ with your values

**Astroneer-Linux** will boot up ubuntu based container image with wine and proton running an astroneer server installed via steamcmd. The public ip is automagically detected via curl ifconfig.co.

We are also using [crudini](https://github.com/pixelb/crudini) to set some stuff on astroneer ini files

## Notes
This image is under active development

## File a issue
Feel free to contribuite adding an issue here: https://gitlab.com/altercode/astroneer-linux/-/issues/new

## FAQ
#### How do i find my external ip? 
https://ifconfig.co/

#### How to find my steam guid? 
https://www.youtube.com/watch?v=gQuelApsq7k

#### How can i test if my server is working?

Use [servercheck.spycibot.com](https://servercheck.spycibot.com/ ), you should see everything green

#### I can't connect to my server
There might be vary reasons for this:

##### Router ports are blocked
To fix this you need to open `30877` port

##### Encryption issue
Add this configuration to your _Engine.ini_ file 
```ini
[SystemSettings]
net.AllowEncryption=False
```

In windows _Engine.ini_ file is located at %homedrive%%homepath%\AppData\Local\Astro\Saved\Config\WindowsNoEditor

