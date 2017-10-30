# api-gw-example


This is a sample project to demonstrate API Gateway principles with Kong.

## Target architecture

```
                                                   +------------+
                                                   |            |
                                                   |  ImagesApi |
                                             +---> |            |
                                             |     |            |
                                             |     +------------+
+----------+    /images   +-----------       |
|          |              |          |       |
|          |              |          |       |
|   LB     +------------> |   Kong   +-------+
|          |              |          |       |
|          |              |          |       |     +------------+
+----------+    /products +----------+       |     |            |
                                             |     |   Products |
                                             +---> |   API      |
                                                   |            |
                                                   +------------+

```


## Pre-requisites

You need to have a running Kontena platform. We'll go and deploy everything into Kontena.


## Kong

In this sample setup, we're using Kong as the API Gateway component. Kong needs to be up-and-running before deploying the sample APIs.

### Deploy Kong

```
kontena stack install kontena/kong
```

Just follow the stack installation wizard


# Demo APIs

In this repo I've hard-coded the images to use my personal repo `jnummelin` in Docker Hub.

If you wish to fine-tune the app, fork this repo and give your own image name in `kontena.yml`.

The sample API deployments handle registering the APIs to Kong using the admin API and Kontena `post_start` deployment hooks.

## Deploy Images API

Deployment as usually for Kontena stacks:

```
$ cd images-api
$ kontena stack install
```

## Deploy Products API

Deployment as usually for Kontena stacks:

```
$ cd products-api
$ kontena stack install
```