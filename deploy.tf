resource "null_resource" "ansible" {
  depends_on = [local_file.hosts]

  triggers = {
    template_rendered = data.template_file.hosts.rendered
  }

  provisioner "local-exec" {
    command = "sleep 120 && cd ansible && ansible-playbook playbook.yml"
  }
}
