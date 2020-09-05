data "template_file" "hosts" {
  template = file("${path.module}/templates/hosts.yml")
  vars = {
    k8s_1 = module.ec2.public_ip[0]
    k8s_2 = module.ec2.public_ip[1]
    k8s_3 = module.ec2.public_ip[2]
  }
}

resource "local_file" "hosts" {
    content         = data.template_file.hosts.rendered
    file_permission = "0644"
    filename        = "${path.module}/ansible/hosts.yml"
}

