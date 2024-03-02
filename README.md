# GCP-Resume-Challenge

## Architecture

To use this project you will need the following

* Terraform 
* Google Cloud Platform 
* GCP APIs you will need - Cloud DNS, IAM Service Account Credentials API, Certificate Manager API

### GCP configuration

* Set up a project in GCP
* Create a service account in GCP
* Create and add an API key to your service account(download JSON)
* Create a Cloud DNS zone

For the steps below I used Visual Studio code

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



## TO DO

* Style the Resume better
* Frontend Code/CI/CD
  * Push my project to my GItHub repo
  * Use Cloud Build to republish frontend whenever the code changes
  * Invalidate Cloud CDN cache on redeploy






