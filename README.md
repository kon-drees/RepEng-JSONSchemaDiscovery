# RepEng: Replication Package of the Project JSONSchemaDiscovery

This site provides the replication package of the project [JSONSchemaDiscovery](https://github.com/feekosta/JSONSchemaDiscovery). 
The project consists of two containers: one for the project itself and another for the MongoDB database.


## What you need installed to run this project:
* [Docker](https://www.docker.com/)

## Building the Docker image:

1. Clone the repository to your local machine;
    > git clone https://github.com/kon-drees/RepEng-JSONSchemaDiscovery.git

2. In the project's folder run the following command to compose and run  the containers:
    > docker-compose up --build



## Performing the smoke test:

1. After the containers are up and running, open a new terminal and run the following command to access the container:
    >  docker exec -it reproduction /bin/bash

    > **Note:** The project container builds a nodejs application. Therefore you need to check if the application is running before performing the smoke test. You can check it if the node applications logs are being printed in the terminal and the Database and the API are ready.


2. In the container's terminal, run the following command to perform the smoke test:
    > ./smoke.sh
   
3. The smoke test was successful if the following message is printed in the terminal:
    > Smoke test was successful

