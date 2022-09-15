terraform {
  required_providers {
    ibm = {
      source = "IBM-Cloud/ibm"
    }
  }
}


provider "ibm" {
  #alias = "tile"  
  region = local.region
  zone   = local.location
}
