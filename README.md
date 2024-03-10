# GCP-Resume-Challenge

## Architecture

To use this project you will need the following

* Terraform 
* Google Cloud Platform 
* GCP APIs you will need - Cloud DNS, IAM Service Account Credentials API, Certificate Manager API, Cloud Build API

### GCP configuration

* Set up a project in GCP
* Create a service account in GCP
* Create and add an API key to your service account(download JSON)
* Create a Cloud DNS zone

### For the steps below I used Visual Studio code

* Create the provider terraform file where you add the provider with the credentials(service a.) / project and region. - You can use variables here -- GCP provider pulls into this provider.tf file
* Create the variables terraform file where you define the variables e.g. gcp_svc_key
* Create the tfvars file GCP region, project and the JSON file (API key from GCP)
* Create the main.tf file with all the infrastructur as a code
    *create a Bucket for the objects
    *upload the objects and set their avaibility
    *need to reserve a static external IP address for your DNS subdomain and forwarding rule
    *get the managed DNS zone 
    *add the IP to the DNS and it will create an A record for your subdomain
    *create Cloud CDN - backend bucket
    *create a ssl certificate
    *create https proxy and the forwarding rule (these are the components of a load balancer)
  
### Cloud Build to republish the frontend whenever the code changes

* Assign the Cloud Build Editor permissions (roles/cloudbuild.builds.editor) role in your project to create triggers

### Creating view count with Cloud Run and Python
  
  *See the article guide here <https://medium.com/@cooper.white_86633/gcp-cloud-resume-challenge-creating-a-view-count-with-cloud-run-7c1388c99cea>
  *Activate the Firestore API - find more about what is Firestore here
  *Create a Database in Firestore and then add Collection and Document to it which will hold the a numeric field of our view count.
  *Create the Cloud Run endpoint - more about Cloud Run here <https://cloud.google.com/run/docs/quickstarts/build-and-deploy/deploy-python-service>
  *I created the Python service main.py and the requirtements.txt files and deployed them to Cloud Run
   
   *Create the API gateway - for these you enable the services below:
      *API Gateway API
      *Service Management API
      *Service Control API



## TO DO

* Style the Resume better
* Frontend Code/CI/CD
  *Create the API gateway <https://medium.com/@cooper.white_86633/gcp-cloud-resume-challenge-creating-an-api-gateway-and-deal-with-cors-9499becb770f>
  *I need to troubleshoot my Cloud Run service as it is not available - but in the Console it shows healthy


## Questions

1. What are the best practices to authorize permissions for a project?




