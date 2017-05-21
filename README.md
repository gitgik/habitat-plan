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
