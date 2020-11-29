resource "aws_vpc" "bladi_todo_vpc" {
  cidr_block = "10.0.0.0/16"

  tags = {
    Name = "bladi-todo-vpc"
  }
}

resource "aws_subnet" "bladi_todo_pub_subnet" {
  cidr_block = "10.0.0.0/24"
  vpc_id = aws_vpc.bladi_todo_vpc.id
  availability_zone = "ap-northeast-2a"

  tags = {
    Name = "bladi-todo-pub-subnet"
  }
}

resource "aws_subnet" "bladi_todo_pri_subnet" {
  cidr_block = "10.0.10.0/24"
  vpc_id = aws_vpc.bladi_todo_vpc.id
  availability_zone = "ap-northeast-2c"

  tags = {
    Name = "bladi-todo-pri-subnet"
  }
}

resource "aws_internet_gateway" "bladi_todo_igw" {
  vpc_id = aws_vpc.bladi_todo_vpc.id

  tags = {
    Name = "bladi-todo-igw"
  }
}

resource "aws_route_table" "bladi_todo_public_rt" {
  vpc_id = aws_vpc.bladi_todo_vpc.id

  tags = {
    Name = "bladi-todo-rt-public"
  }
}

resource "aws_route_table" "bladi_todo_private_rt" {
  vpc_id = aws_vpc.bladi_todo_vpc.id

  tags = {
    Name = "bladi-todo-rt-private"
  }
}

resource "aws_route_table_association" "route_table_association_public" {
  subnet_id = aws_subnet.bladi_todo_pub_subnet.id
  route_table_id = aws_route_table.bladi_todo_public_rt.id
}

resource "aws_route_table_association" "route_table_association_private" {
  subnet_id = aws_subnet.bladi_todo_pri_subnet.id
  route_table_id = aws_route_table.bladi_todo_private_rt.id
}

resource "aws_route" "public_igw_rule" {
  route_table_id = aws_route_table.bladi_todo_public_rt.id
  destination_cidr_block = "0.0.0.0/0"
  gateway_id = aws_internet_gateway.bladi_todo_igw.id
}
