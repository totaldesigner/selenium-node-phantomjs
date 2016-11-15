# Selenium Grid Node - PhantomJS

Selenium Node configured to run PhantomJS.

## Dockerfile

Images have been created based on Selenium images: https://github.com/SeleniumHQ/docker-selenium

## How to use this image

First, you will need a Selenium Grid Hub that the Node will connect to.

```
$ docker run -d -P --name selenium-hub selenium/hub
```

Once the hub is up and running will want to launch nodes that can run tests. You can run as many nodes as you wish.

```
$ docker run -d --name selenium-node-phantomjs --link totaldesigner/node-phantomjs
```
