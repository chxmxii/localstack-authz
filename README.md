# LocalStack AuthZ

AuthZ is a lightweight security layer to localstack that prevents unauthorized access. It extracts the **AccessKeyId** from the request allowing only whitelisted keys to proceed.

## Architecture

```mermaid
graph LR
    User["User "] --> NGINX["NGINX"]
    NGINX -->|subreq: /_authz| AuthZ["AuthZ"]
    NGINX -->|forward traffic| LocalStack["LocalStack"]
    
    AuthZ -->|Allow / Deny| NGINX
    LocalStack --> NGINX
```

## Usage

```yml
services:
  localstack:
    .
    .
    .
    networks:
      - lsnet

  authz:
    build:
      context: ..
    container_name: authz
    depends_on: [localstack]
    environment:
      - ALLOWED_KEYS=dummyaccesskeys,AKIA2L03056B890WYAAZ,LKIAQAAAAAAAN7PNUWLO #add your allowed access keys here
      - AUTHZ_DEBUG=true #enable debug logging
    networks: [lsnet]

  proxy:
    build:
      context: ../proxy
    container_name: proxy
    ports:
      - "80:80"
    depends_on:
      - localstack
      - authz
    networks: [lsnet]

networks:
  lsnet:
    driver: bridge
    external: false
```

>  but first, ensure that localstack is not reachable to the outside network.

### Contribute
Feel free to open an issue or a PR if you have any ideas.
