module "vpc1" {
  source          = "./modules/vpc"
  vpc_name        = "vpc-network-1"
  subnet_name     = "subnet-1"
  subnet_ip_range = "10.0.1.0/24"
  reserved_subnet_ip_range = "10.0.1.128/25" # Reserved subnet range for internal load balancer
  allow_ports     = ["80", "443"]
  region          = "us-central1"
}

module "vpc2" {
  source          = "./modules/vpc"
  vpc_name        = "vpc-network-2"
  subnet_name     = "subnet-2"
  subnet_ip_range = "10.0.2.0/24"
  reserved_subnet_ip_range = "10.0.2.128/25" # Reserved subnet range for internal load balancer
  allow_ports     = ["80", "443"]
  region          = "us-central1"
}

# MIG for VPC-1
module "mig_vpc1" {
  source              = "./modules/mig"
  instance_group_name = "mig-instance-group-1"
  vpc_name            = module.vpc1.vpc_name
  region              = var.region
  zone                = var.zone
  subnet_name         = module.vpc1.subnet_id 
}

# MIG for VPC-2
module "mig_vpc2" {
  source              = "./modules/mig"
  instance_group_name = "mig-instance-group-2"
  vpc_name            = module.vpc2.vpc_name
  region              = var.region
  zone                = var.zone
  subnet_name         = module.vpc2.subnet_id 
}

# VPC Peering 
module "vpc_peering" {
  source         = "./modules/vpc_peering"
  vpc_1_name     = module.vpc1.vpc_name
  vpc_1_self_link = module.vpc1.vpc_self_link
  vpc_2_name     = module.vpc2.vpc_name
  vpc_2_self_link = module.vpc2.vpc_self_link
}

# HTTP Load Balancer
module "http_lb" {
  source         = "./modules/http_lb"
  region         = var.region
  mig1_self_link = module.mig_vpc1.instance_group_self_link  # First MIG
  mig2_self_link = module.mig_vpc2.instance_group_self_link  # Second MIG
}

# Internal Load Balancer for VPC-1
module "internal_lb_vpc1" {
  source              = "./modules/internal_lb"
  vpc_name            = module.vpc1.vpc_name
  region              = var.region
  instance_group_name = module.mig_vpc1.instance_group_self_link # MIG for VPC-1
  reserved_subnet_ip_range = "10.0.1.128/25" # Reserved subnet range
  depends_on          = [module.http_lb]  # Ensures this module runs after the HTTP load balancer
}

# Internal Load Balancer for VPC-2
module "internal_lb_vpc2" {
  source              = "./modules/internal_lb"
  vpc_name            = module.vpc2.vpc_name
  region              = var.region
  instance_group_name = module.mig_vpc2.instance_group_self_link # MIG for VPC-2
  reserved_subnet_ip_range = "10.0.2.128/25" # Reserved subnet range
  depends_on          = [module.http_lb]  # Ensures this module runs after the HTTP load balancer
}
