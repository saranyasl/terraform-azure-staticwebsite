ssh_security_rule = {
    name = "SSH"
    priority = 1001
    direction = "Inbound"
    access = "Allow"
    protocol = "Tcp"
    destination_port_range = 22
}
http_security_rule = ["HTTP", 1020, "Inbound", "Allow", "Tcp", 80]
subnet_name = "mysubnet"