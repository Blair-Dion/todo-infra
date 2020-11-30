resource "aws_db_instance" "bladi_todo_db" {
  identifier = "bladi-todo-db"
  instance_class = "db.t2.micro"
  allocated_storage = 20
  max_allocated_storage = 0
  # disable autoscaling
  engine = "mysql"
  engine_version = "5.7.30"
  skip_final_snapshot = true
  availability_zone = "ap-northeast-2c"

  db_subnet_group_name = aws_db_subnet_group.bladi_todo_db_subnet_group.name
  vpc_security_group_ids = [
    aws_security_group.bladi_todo_db_sg.id
  ]
  parameter_group_name = aws_db_parameter_group.bladi_todo_db_pg.name

  username = "admin"
  password = "password"
  # 변경필요
  name = "todo"
  # db 이름
}

resource "aws_db_subnet_group" "bladi_todo_db_subnet_group" {
  name = "bladi-todo-db-subnet-group"
  subnet_ids = [
    aws_subnet.bladi_todo_pri_subnet.id,
    aws_subnet.bladi_todo_pub_subnet.id
  ]

  tags = {
    Name = "bladi-todo-db-subnet-group"
  }
}

resource "aws_security_group" "bladi_todo_db_sg" {
  name = "bladi-todo-db-sg"
  description = "Allow MySQL"
  vpc_id = aws_vpc.bladi_todo_vpc.id

  ingress {
    from_port = 3306
    to_port = 3306
    protocol = "tcp"
    security_groups = [
      aws_security_group.bladi_todo_web_server_sg.id
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

  tags = {
    Name = "bladi-todo-db-sg"
  }
}

resource "aws_db_parameter_group" "bladi_todo_db_pg" {
  name = "bladi-todo-db-pg"
  family = "mysql5.7"

  parameter {
    name = "time_zone"
    value = "Asia/Seoul"
  }

  parameter {
    name = "character_set_client"
    value = "utf8mb4"
  }

  parameter {
    name = "character_set_connection"
    value = "utf8mb4"
  }

  parameter {
    name = "character_set_database"
    value = "utf8mb4"
  }

  parameter {
    name = "character_set_filesystem"
    value = "utf8mb4"
  }

  parameter {
    name = "character_set_results"
    value = "utf8mb4"
  }

  parameter {
    name = "character_set_server"
    value = "utf8mb4"
  }

  parameter {
    name = "collation_connection"
    value = "utf8mb4_unicode_ci"
  }

  parameter {
    name = "collation_server"
    value = "utf8mb4_unicode_ci"
  }
}
