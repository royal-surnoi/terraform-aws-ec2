resource "aws_instance" "main" {
  ami                    = var.ami_id
  instance_type          = var.instance_type
  vpc_security_group_ids = local.security_group_ids
  subnet_id              = var.subnet_id

  root_block_device {
    volume_size = var.volume_size
  }

  tags = merge(
    local.common_tags,
    var.ec2_tags,
    {
      Name = "${var.project}-${var.environment}-${var.component}"
    }
  )
}

resource "terraform_data" "main" {
  triggers_replace = [aws_instance.main.id]
  provisioner "file" {
    connection {
      type     = "ssh"
      user     = var.username
      password = var.password
      host     = aws_instance.main.public_ip
      timeout  = "5m"
    }
    source      = var.script_file
    destination = "/tmp/config.sh"
  }
  provisioner "remote-exec" {
    connection {
      type     = "ssh"
      user     = var.username
      password = var.password
      host     = aws_instance.main.public_ip
      timeout  = "5m"
    }
    inline = [
      "chmod +x /tmp/config.sh",
      "/tmp/config.sh"
    ]
  }
}
