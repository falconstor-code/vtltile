terraform {
  required_providers {
    ibm = {
      source = "IBM-Cloud/ibm"
    }
  }
}


provider "ibm" {
  #aalias = "tile"  
  region = local.region
  zone   = local.location
}
