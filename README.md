# vs-code-iox-client

This is a quickstart to the browser based VS Code Environment for IOx development.

Use Example Video provided with the below instructions.

* Use the following command in your terminal window

```
docker run --privileged -it -p 8000:8000 -p 8080:8080 -e PASSWORD='ioxtest' ciscodevnet/vs-code-iox-client:ioxclient_1_9_2_test
```

* Open your browser window to http://127.0.0.1:8080

* you will need to type in a password.  use `ioxtest` as your password

* click the hamburger button on the top left corner and then select terminal window

* use this terminal window to enter terminal commands from here on out

* get a docker engine modified version of iox-docker-python-web app code base. use the following commands

```
git clone https://github.com/CiscoDevNet/iox-docker-python-web.git
```

and then use

```
git checkout iox-1-9-2-test
```

* In the browser based VS Code Open the folder we just created after downloading our git repo

> This will reset the VS Code Window and terminal

* in the terminal window type `ioxclient --version` and follow the prompts to setup your ioxclient.  Use port `22` for ssh, `cisco` for username and password, and everything else can stay as default

* next build your docker container

```
docker build -t ioxdockertest:v0.0 .
```

* next initialize ioxclient to interact with the docker client

```
ioxclient docker init
```

> Leave the settings as default

* install the application

```
ioxclient app install iox_docker_python_web ioxdockertest:v0.0 .
```

* Once install is complete, activate the app.

```
ioxclient app activate --payload activation.json iox_docker_python_web
```
* Start the app

```
ioxclient app start iox_docker_python_web
```

* Now... it might take a minute, but check the web endpoint to make sure it is running by visiting this URL http://10.10.20.51:8000/time

YAY we are done!





