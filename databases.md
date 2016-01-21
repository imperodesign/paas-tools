## Databases
IMPERO infrastructure has the following databases available for web apps usage:
- PostgreSQL
- Aurora
- MongoDB

### PostgreSQL
Create a PostgreSQL instance with AWS RDS.

### Aurora
Create a Aurora instance with AWS RDS.

### MongoDB
Use the following Cloud Formation template:
`https://s3.amazonaws.com/quickstart-reference/mongodb/latest/templates/MongoDB-VPC.template`

#### staging ad-hoc configuration
```
Stack Name: mongodb-stg
ClusterReplicaSetCount: 1
KeyName: mongo
VolumeSize: 1
```

#### production ad-hoc configuration
```
Stack Name: mongodb-prd
ClusterReplicaSetCount: 3
KeyName: mongo
VolumeSize: 400
```
