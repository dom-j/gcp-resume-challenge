
# Upload the html file to the bucket
resource "google_storage_bucket_object" "resume_file" {
    name = "resume.html"
    bucket = "website-by-dom-j"
    source = "C:/dom-j/gcp-resume-challenge/resume/resume_index.html"
}

# Make new object resume_file public
resource "google_storage_object_access_control" "public_role" {
    bucket = "website-by-dom-j"
    object = google_storage_bucket_object.resume_file.name 
    role = "READER"
    entity = "allUsers"
}

#Reserve a static external IP address
resource "google_compute_global_address" "static_ip" {
    name = "resume-static-ip"
}


#Get the managed DNS Zone 
data "google_dns_managed_zone" "dns_zone" {
    project = "static-website-413510"
    name = "website-gcp"
}



# Add the IP to the DNS
resource "google_dns_record_set" "gcp" {
    name = "resume.${data.google_dns_managed_zone.dns_zone.dns_name}"
    type="A"
    ttl=300
    managed_zone = data.google_dns_managed_zone.dns_zone.name
    rrdatas = [google_compute_global_address.static_ip.address]
    project = "static-website-413510"
}


#Add the bucket as a CDN backup
resource "google_compute_backend_bucket" "resume-backend" {
    project = "static-website-413510"
    name = "resume-backend-bucket"
    bucket_name = "website-by-dom-j"
    enable_cdn = true
    description = "Contains files needed for the website"
}

#Create HTTPS certificate
resource "google_compute_managed_ssl_certificate" "resume" {
  provider = google
  project = "static-website-413510"
  name = "resume-challenge-cert"
  managed {
    domains = [google_dns_record_set.gcp.name]
  }
}


#GCP HTTPS Proxy
resource "google_compute_target_https_proxy" "resume" {
  project = "static-website-413510"
  name = "resume-target-proxy-uk"
  url_map = "https://www.googleapis.com/compute/v1/projects/static-website-413510/global/urlMaps/website-url-map"
  ssl_certificates = [google_compute_managed_ssl_certificate.resume.self_link]
}

#GCP forwarding rule
resource "google_compute_global_forwarding_rule" "default" {
  provider = google
  project = "static-website-413510"
  name = "resume-forwarding-rule"
  load_balancing_scheme = "EXTERNAL"
  ip_address = google_compute_global_address.static_ip.address
  ip_protocol = "TCP"
  port_range = "443"
  target = google_compute_target_https_proxy.resume.self_link
}
