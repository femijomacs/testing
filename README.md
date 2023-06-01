# Expressjs API Application

## Project Structure

This structure diagram show all directories and specific files of interest. It captures ALL files present in the architecture of this project except for 'docs directory', where the name of each file explains its purpose.

    .
    ├── .github                                      # Contains GitHub Actions Related sources
    |   ├── helpers                                  # Re-usable shell scripts used in deployment pipelines
    |   |   ├── deploy.sh                            # Re-usable shell script to process api deployment config templates and deploy it to a given namespace
    |   |   ├── app-health.sh                        # Re-usable shell script to watch deployment of deployment config in a given namespace to ensure it is live and healthy
    |   ├── workflows                                # Contains Github Actions for CI/CD tasks
    |   |   ├── auto-assign.yaml                     # Github Action run on pull request to review the assignment (It was given with the Assignment)
    |   |   ├── expressjs-api.yaml                   # Github Action run on merge to main that builds, tags, pushes and deploys the API image to the DEV openshift namespace
    |   ├── CODEOWNERS                               # It was given with the Assignment
    |   ├── auto-action-config.yaml                  # It was given with the Assignment - It shows list of reviewers to be added to pull requests
    ├── docs                                         # Relevant Documentation showing the results of the assignment
    ├── openshift                                    # Openshift Object Repository - Directory containing k8s artifacts
    |   ├── templates                                # Directory containing k8s artifacts related to processing and deploying api containers to dev namespace
    |   |   ├── expressjs-api-dc-template.yaml       # Template for the deploymentconfig creation
    |   |   ├── expressjs-api-route-template.yaml    # Template for the route creation
    |   |   ├── expressjs-api-service-template.yaml  # Template for the service creation
    ├── src                                          # Project Source Code Components
    │   ├── backend                                  # All API related source code
    |   |   ├── README.md                            #
    |   |   ├── index.js                             #
    |   |   ├── package-lock.json                    #
    |   |   ├── package.json                         #
    |   ├── Dockerfile                               # Dockerfile used to build docker image
    |   ├── package-lock.json                        # API dependency locking
    ├── .gitignore                                   # list of files that are omitted from commits to this repository
    ├── README.md                                    # This is the document you are reading right now!
    ├── docker-compose.yaml                          # docker-compose file used specifically for CI/CD purposes


### Docker and Docker Compose Build

To setup project specific docker containers, first make sure you have Docker Desktop installed on your machine. Next, run the following command.

1. Navigate to project root directory where `docker-compose.yaml` is located.

2. Use the command: `docker-compose config` to check for syntax error.

3. Use the command: `docker-compose up -d --build` to start container in detached mode and rebuild the docker image

3. Use the command: `docker-compose up` to start container without rebuilding the docker image

### Services

API -> accessible at [http://localhost:3000/api](http://localhost:3000/api) or on CLI use the command: 'curl http://localhost:3000/api'

API -> accessible at [http://localhost:3000/api/health](http://localhost:3000/api/health) or on CLI use the command: 'curl http://localhost:3000/api/health'

### Teardown Built Docker Resources

1. Navigate to the project root directory.

2. Use the command: `docker-compose down`.

3. The container for the server would be stopped and removed.

### Kubernetes

The manifest has 3 templates - deploymentconfig, route and service

1. Create dev namespace: 'oc create ns dev' 
 
2. To see all resources created in dev namespace: 'oc get all -n dev'.

3. To check liveness and healthy probe: 

    on CLI use the command: 'curl http://expressjs-api-dev.apps.openshift.femmyreuben.com/api/health'
    
    on webpage: 'http://expressjs-api-dev.apps.openshift.femmyreuben.com/api/health'

4. To scale resources created to "3" in dev namespace: 'oc scale deploymentconfig expressjs-api --replicas=3 -n dev'

5. To delete all resources created in dev namespace: 'oc delete all --all -n dev'

### Pipeline

The GitHub Actions pipeline has 3 stages:

   1. Expressjs-API-Build-Tag-Push: it builds the image, tags the image and places docker image into dockerhub repository

   2. Deploys-to-dev: deploys image into Openshift cloud container platform in dev namespace

   3. health-check-in-dev: a stage used to report when API is healthy and ready to be consumed

The pipeline stages(Deploys-to-dev and health-check-in-dev) use scripts to help in deploying to dev in Deploys-to-dev stage and to report health check on the API respectively

### End of Documentation
************************************************************************************************************************************************************

