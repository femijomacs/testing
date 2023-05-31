# Expressjs API Application

## Project Structure

This structure diagram show all directories and specific files of interest. It captures ALL files present in the architecture of this project.

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
    |   ├── templates                                # Directory containing k8s artifacts related to processing and deploying api containers to dev environment
    |   |   ├── expressjs-api-dc-template.yaml       #
    |   |   ├── expressjs-api-route-template.yaml    #
    |   |   ├── expressjs-api-service-template.yaml  #
    ├── src                                          # Project Source Code Components
    │   ├── backend                                  # All API related source code
    |   |   ├── README.md                            #
    |   |   ├── index.js                             #
    |   |   ├── package-lock.json                    #
    |   |   ├── package.json                         #
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

API -> accessible at [http://localhost:3000/api](http://localhost:3000/api)

API -> accessible at [http://localhost:3000/api/health](http://localhost:3000/api/health)

### Teardown

1. Navigate to the project root directory.

2. Use the command: `docker-compose down`.

3. The container for the server would be stopped and removed.

### Kubernetes

1. To see all resources created in dev namespace: 'oc get all -n dev'.

2. To check liveness and healthy probe: 

    on CLI 'curl http://expressjs-api-dev.apps.openshift.femmyreuben.com/api/health'
    
    on webpage 'http://expressjs-api-dev.apps.openshift.femmyreuben.com/api/health'

3. To scale resources created to "3" in dev namespace: 'oc scale deploymentconfig expressjs-api --replicas=3 -n dev'

4. To delete all resources created in dev namespace: 'oc delete all --all -n dev'

### Pipeline

The GitHub Actions pipeline has 3 stages:

   1. Expressjs-API-Build-Tag-Push: It builds the image, tags the image and places docker image into dockerhub repository

   2. Deploys-to-dev: deploys image into Openshift cloud container platform in dev namespace

   3. health-check-in-dev: A stage used to report when API is healthy and ready to be consumed

The pipeline stages also uses scripts to help in deploying to dev in Deploys-to-dev stage and to report health check on the API















# citz-data-bc-service-devops-specialist-req99120

## Instructions for IS-27 DevOps Specialist Position

For this technical assignment, we are asking you to provide a **PRIVATE** repository that houses artifacts used to generate a container of a given application, and other artifacts that would be used to deploy said container into a cloud container platform. An example of these artifacts should come in the form of the following:

* A Dockerfile and docker-compose file that demonstrates your knowledge of local containerization
* Kubernetes templates for basic kubernetes objects like deployment configs, stateful sets, pods, services and routes, that will utilize the image produced by your Dockerfile
* Deployment pipelines using technologies such as Github Actions or Tekton pipelines or Jenkins etc.

Be aware that you will be asked to defend your choice of technology if your solution passes marking criteria and proceeds to the next stage of marking that follows this technical assignment.

For the purposes of this technical exercise, please deploy the example Expressjs API to a cloud container platform of your choosing.  Your artifacts will target/utilize the provided Expressjs API included in this repository.  You are not required to keep live the solution in your cloud container platform of choice for the initial assessment.   

Documentation required for this technical assignment should be found in a README.md file found at the root of your repository. This documentation should have at minimum the required commands that utilize your Dockerfile and docker-compose file to generate a docker image of the Expressjs API using your Dockerfile. For the purposes of this exercise, it is safe to assume that the marking panel will have Docker Desktop installed on their local machine in order to evaluate your submission.  You must also include a visual artifact that outlines the process of your pipeline.

Your kubernetes manifest used to deploy your generated Docker image of the Expressjs API should include a readiness and liveness probe that will utilize the `/api/health` endpoint found in the API. The endpoint returns a 200 response code, and your probes should utilize this response to evaluate whether or not your deployment is healthy.

### Important!

If your submission passes marking criteria and is selected to proceed to the next round of evaluations, you will be responsible for demoing your deployment pipeline in a live 15 minute demo to a marking panel via a Microsoft Teams call.  This will require you to have a working solution in a cloud container platform of your choice.

Your demo will be graded on the following:

* ease of deployment
* maintainability of solution provided
* whether or not your solution works without warning or error

It is highly suggested that your deployment pipelines developed for this solution come pre-tested, in order to ensure that an eventual demo goes smoothly.

## What to Submit:

### Github Repository

Create a **PRIVATE** GitHub repository using your GitHub Account. The name of the repository should use the following convention:

[FIRST_NAME]-[LAST_NAME]-IS27-devops-specialist-competition-req99120

Your working solution should be present on the **main** branch of your private repository. Please trim any extraneous branches prior to submission as they
will not be evaluated.

When you are ready to submit your solution, email adam.kroon@gov.bc.ca with the link to your private repository, and invite the following Github ID as a collaborator in order to view and clone your solution for marking purposes:

* akroon3r

Your solution will be cloned at 12:01pm PST on Thursday June 1 2023, after the submission window has closed. Any commits pushed to your repository after this time **will not** be included in the marking of your solution.

Reminder, please include all documentation required for your solution in a README.md file found in the root directory of your repository. Use of diagrams in your documentation is required.

### Dockerfile Component

The Dockerfile created for this assignment should produce a working image of the Express API that accompanies this README. The Dockerfile should be utilized by a docker-compose file found at the root of your submission. The name of the container should be simple and easy to read.

### Kubernetes Component

The Kubernetes template created for this assignment can come in the form of one or many YAML files containing objects such as deployments, deployment configs, stateful sets, pods, services and routes. The yaml files should be organized and easy to read. If parameters are used to demonstrate scalability of your templates to multiple environments, environment variables should be descriptive enough such that a user with little or no knowledge of your deployment pipeline can figure out how to configure a deployment.

### Pipeline Component

An example of steps provided in a pipeline solution should take the form of the following:

* A build, tag and push step that places your docker image into an image repository or image storage object.
* A step that deploys the image into a cloud container environment 
* A stage that utilizes the readiness and liveness probes on your kubernetes manifest to return the pod/container status when they are running post-deployment

## Questions for Completing This Submission

**You are encouraged to use your own discretion when faced with uncertainty in the technical assignment.**

If there is a problem with the assignment which prevents you from submitting it, please send an email to the address that sent this technical assignment to you.

The marking panel does have the right to refuse answering questions, if questions asked are not equitable to all participants of this challenge.

## Assessment Scoring

### Github Repository Component
| Rating                  | Criteria                                                                        |
|-------------------------|---------------------------------------------------------------------------------|
| Pass/Acceptable         | * Organized, easy to read                                                       |
|                         | * Solution is present on main branch of repository                              |
|                         | * Extraneous branches removed/trimmed from repo                                 |
| Fail/Unacceptable       | * Any of the requirements of Pass/Acceptable are not met                        |

### BONUS Github Repository Wiki Documentation
| Rating                  | Criteria                                                                        |
|-------------------------|---------------------------------------------------------------------------------|
| Pass/Acceptable         | * Provide graphical component on a wiki page that outlines your pipeline and    |
|                         |   Environments and how each component of your eco system works                  |
| Fail/Unacceptable       | * Any of the requires of Pass/Acceptable are not met                            |

### Dockerfile and Docker-compose Component
| Rating                  | Criteria                                                                        |
|-------------------------|---------------------------------------------------------------------------------|
| Pass/Acceptable         | * Utilizes single or multi stage build to produce image                         |
|                         | * Readable, commenting when necessary to explain pattern used to produce image  |
|                         | * Solution produces an image on a local workstation without error               |
| Fail/Unacceptable       | * Any of the requirements of Pass/Acceptable are not met                        |

### Kubernetes Component
| Rating                  | Criteria                                                                                |
|-------------------------|-----------------------------------------------------------------------------------------|
| Pass/Acceptable         | * Solution utilizes image repository and image created using Dockerfile/docker-compose  |
|                         | * One or many YAML files                                                                |
|                         | * Readable, well organized                                                              |
| Fail/Unacceptable       | * Any of the requirements of Pass/Acceptable are not met                                |


### Pipeline Component
| Rating                  | Criteria                                                                        |
|-------------------------|---------------------------------------------------------------------------------|
| Pass/Acceptable         | * Build, tag, push step that places docker image into repository                |
|                         | * Deploys image into cloud container platform of your choice                    |
|                         | * A stage used to report when API is healthy and ready to be consumed           |
|                         | * Pipeline is documented or accompanied by documentation to explain pattern used|
|                         | * Screen capture or link to logfiles from successful deployment                 |
| Fail/Unacceptable       | * Any of the requirements of Pass/Acceptable are not met                        |
