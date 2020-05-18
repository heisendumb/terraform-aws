data "aws_ami" "centos7" {
  owners      = ["679593333241"]
  most_recent = true

  filter {
    name   = "name"
    values = ["CentOS Linux 7 x86_64 HVM EBS *"]
  }

  filter {
    name   = "architecture"
    values = ["x86_64"]
  }

  filter {
    name   = "virtualization-type"
    values = ["hvm"]
  }

  filter {
    name   = "root-device-type"
    values = ["ebs"]
  }
}

resource "aws_key_pair" "heisenbuggerr-key" {
  key_name   = "test-aws-key"
  public_key = file(var.public_key)
}

resource "aws_instance" "compute_node" {
  ami                    = data.aws_ami.centos7.id
  instance_type          = "t2.micro"
  monitoring             = true
  vpc_security_group_ids = [var.vpc_sg_ids]
  subnet_id              = var.vpc_subnet_id
  key_name               = aws_key_pair.heisenbuggerr-key.id
}

data "aws_availability_zones" "available" {
  state = "available"
}

resource "aws_ebs_volume" "ebs_compute_node" {
  count             = 1
  size              = var.disk_size
  availability_zone = data.aws_availability_zones.available.names[0]
  type              = "gp2"
}

resource "aws_volume_attachment" "ebs-attachment-to-ec2" {
  count       = 1
  device_name = "/dev/xvdh"
  instance_id = aws_instance.compute_node.*.id[count.index]
  volume_id   = aws_ebs_volume.ebs_compute_node.*.id[count.index]
}
