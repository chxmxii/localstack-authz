# LocalStack AuthZ

AuthZ is a lightweight security layer to localstack that prevents unauthorized access. It extracts the **AccessKeyId** from the request allowing only whitelisted keys to proceed.

## Architecture

```mermaid
graph LR
    User["User / AWS CLI / SDK"] --> NGINX["NGINX Proxy"]
    NGINX -->|Subrequest: /_authz| AuthZ["AuthZ Service<br/>AccessKeyId Validator"]
    NGINX -->|Forward Valid Requests| LocalStack["LocalStack (AWS APIs)"]
    
    AuthZ -->|Allow / Deny| NGINX
    LocalStack --> NGINX
```

Feel free to open an issue or a PR if you have any ideas.