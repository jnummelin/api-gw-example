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


### Add rate limit

There's a `rake` task for setting a simple rate limit for the `/products` API. The limit is hard-coded for 5 reqs per minute, just to easily show how rate-limits and other plugins can be easily configured.

```
$ kontena service exec product-api/api rails kong:rate_limit
```

Now when you hit the `/products` API the 6th time within a minute you'll get:
```
$ curl -vv demo-api.kontena.works/products/foobar
> GET /products/ab8f5275-3350 HTTP/1.1
> Host: demo-api.kontena.works
> User-Agent: curl/7.54.0
> Accept: */*
>
< HTTP/1.1 429
< Date: Mon, 30 Oct 2017 13:34:51 GMT
< Content-Type: application/json; charset=utf-8
< Transfer-Encoding: chunked
< X-RateLimit-Limit-minute: 5
< X-RateLimit-Remaining-minute: 0
< Server: kong/0.11.1
<
{"message":"API rate limit exceeded"}

```
