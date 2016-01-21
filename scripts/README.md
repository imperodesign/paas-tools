## Scripts
Scripts helpers for PaaS application management.

### Before starting
Copy this folder in your main app repo.
Edit `APP_NAME` variable in `create` and `deploy` bash files.

Finally add the following in your `.bash_profile` dot file:
```sh
export DEIS_USERNAME=<your-username>
export DEIS_PASSWORD=<your-password>
export DEIS_STG_URL=<stg-url>
export DEIS_PRD_URL=<prd-url>
```

> IMPORTANT: If you want different user credentials for staging and production env, you need to make some changes to these files :-)

### Create your application in the cloud
```sh
./create
```

### Deploy your application in the cloud
```sh
./deploy [stg|prd]
```
