locals {
  user_data = <<EOF
#cloud-config
network:
  version: 1
  config:
  - type: physical
    name: ens5
    subnets:
      - type: dhcp
      - type: dhcp6
EOF
}

