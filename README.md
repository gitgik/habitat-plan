# habitat-plan
A plan for defining a habitat package

## Installation
Clone the repo

```
$ git clone https://github.com/gitgik/habitat-plan.git
```

Change directories to the root directory for this project.

```
$ cd habitat-plan
```

Make sure Docker is running and then enter into the studio environment.

```
$  hab studio enter
```

The package download and installation process should only take a few moments. If successful, you should see another bash prompt like this:
```
[1][default:/src:0]#
```

Inside the prompt, Run the `build` command to build your package:
```
[1]default:/src:0]# build
```

Now the package is built and stored in the relative `results` directory

For example,
`/src/results/myorigin-myapp-0.2.0-20160826191852-x86_64-linux.hart`
It persists even after you exit the habitat studio

Right now, your package builds, but will not do anything at runtime. The next step is to add hooks to your plan. These will link to the correct files during initialization and start the npm binary.

## Adding hooks to your plan
Hooks are simply scripts that respond to specific events during the life cycle of our running service.

We need to copy the files in the build location into the correct `runtime location` and start the `node` binary.

Inside the studio, change directory to `/src/habitat` and make a new sub-directory called hooks.
```
[3][default:/src:0]# cd /src/habitat
[4][default:/src/habitat:0]# mkdir -p hooks
```

Change to the hooks directory and create two new files, init and run.
```
[5][default:/src/habitat:0]# cd hooks
[6][default:/src/habitat/hooks:0]# touch init run
```

In the init file, symlink the files from the location where the package is installed to the directory used when the service starts.
```
#!/bin/sh
#
ln -sf {{pkg.path}}/package.json {{pkg.svc_var_path}}
ln -sf {{pkg.path}}/server.js {{pkg.svc_var_path}}
ln -sf {{pkg.path}}/node_modules {{pkg.svc_var_path}}
```
Save the init file

Open the run file, and add the command to start the node binary
```
#!/bin/sh
#
cd {{pkg.svc_var_path}}

# `exec` makes it so the process that the Habitat supervisor uses is
# `node server.js`, rather than the run hook itself. `2>&1` makes it so both
# standard output and standard error go to the standard output stream,
# so all the logs from the application go to the same place.
exec node server.js 2>&1
```
Save it.


## Adding the configurations to the plan
Our app uses config.json as the configuration file.

All we have to do is copy this file in a newly created config directory inside `/src/habitat`
```
[7][default:/src/habitat/hooks:0]# cd /src/habitat
[8][default:/src/habitat:0]# mkdir -p config
[9][default:/src/habitat:0]# touch config/config.json
```

Copy the contents of config.json
```
{
    "message": "This is your first habitat service!",
    "port": "8080"
}
```
Now we replace the values of port and message by using a reference from the TOML file
```
// habitat/config/config.json
{
  "message": "{{cfg.message}}",
  "port": "{{cfg.listening_port}}"
}
```

TOML file is associated with your configuration file and specifies the default values for your service at start up.
If you have a templatized configuration file, then you must include a `default.toml` file in your plan folder.

Ok. Open the `default.toml` file and define the message and port values
```
# Message of the Day
message = "This is your first habitat service!"

# The port number that is listening for requests.
listening_port = 8080
```
Save the file.

We use the same values as the ones specified in the original config.json file to keep the initial start up experience the same.

## Run it!
