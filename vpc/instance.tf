resource "aws_security_group" "bladi_todo_web_server_sg" {
  name = "bladi-todo-web-server-sg"
  description = "Allow SSH, HTTP"
  vpc_id = aws_vpc.bladi_todo_vpc.id

  ingress {
    from_port = 22
    to_port = 22
    protocol = "tcp"
    cidr_blocks = [
      "0.0.0.0/0"
      # 허용할 IP(비권장)
    ]

  }
  ingress {
    from_port = 80
    to_port = 80
    protocol = "tcp"
    cidr_blocks = [
      "0.0.0.0/0"
    ]
  }
  egress {
    from_port = 0
    to_port = 65535
    protocol = "tcp"
    cidr_blocks = [
      "0.0.0.0/0"
    ]
  }
}

data "aws_ami" "ubuntu-18_04" {
  most_recent = true
  owners = [
    var.ubuntu_account_number
  ]

  filter {
    name = "name"
    values = [
      "ubuntu/images/hvm-ssd/ubuntu-bionic-18.04-amd64-server-*"
    ]
  }
}

data "aws_ami" "ubuntu-20_04" {
  most_recent = true
  owners = [
    var.ubuntu_account_number
  ]

  filter {
    name = "name"
    values = [
      "ubuntu/images/hvm-ssd/ubuntu-focal-20.04-amd64-server-*"]
  }
}

resource "aws_instance" "bladi_todo_web" {
  ami = data.aws_ami.ubuntu-18_04.id
  instance_type = "t2.micro"
  key_name = aws_key_pair.bladi_todo_web_admin.key_name
  availability_zone = "ap-northeast-2a"
  network_interface {
    device_index = 0
    network_interface_id = aws_network_interface.bladi_todo_eni_eth0.id
  }

  tags = {
    Name = "bladi-todo-web"
  }
}

resource "aws_network_interface" "bladi_todo_eni_eth0" {
  subnet_id = aws_subnet.bladi_todo_pub_subnet.id
  security_groups = [
    aws_security_group.bladi_todo_web_server_sg.id
  ]
  private_ips = [
    "10.0.0.10"
  ]

  tags = {
    Name = "bladi-todo-eni-eth0"
  }
}

resource "aws_eip_association" "bladi_todo_web_server_eip_assoc" {
  allocation_id = aws_eip.bladi_todo_web_server_ip.id
  instance_id = aws_instance.bladi_todo_web.id
  network_interface_id = aws_network_interface.bladi_todo_eni_eth0.id
  private_ip_address = "10.0.0.10"
}

# Canonical Account Number
variable "ubuntu_account_number" {
  default = "099720109477"
}
