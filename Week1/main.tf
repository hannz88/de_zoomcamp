terraform {
  required_providers {
    google = {
      source = "hashicorp/google"
      version = "6.18.1"
    }
  }
}

provider "google" {
  # Configuration options
  project     = "vibrant-petal-449512-c1"
  region      = "europe-west2"
}

resource "google_storage_bucket" "demo-bucket" {
  name          = "vibrant-petal-449512-c1-terra-bucket"
  location      = "EU"
  force_destroy = true


  lifecycle_rule {
    condition {
      age = 1
    }
    action {
      type = "AbortIncompleteMultipartUpload"
    }
  }
}


resource "google_bigquery_dataset" "demo_dataset" {
  dataset_id = "demo_dataset"
}