locals {
    # set local value for rg and tags
    rg_name = "${var.resoure_group_name}"
    service_name = "Demo Services"
    owner = "Saranya"
    common_tags = {
        Service = local.service_name
        Owner   = local.owner
    }
}