resource "aws_key_pair" "bladi_todo_web_admin" {
  key_name = "bladi-todo-web-admin"
  public_key = file("~/.ssh/todo_web_admin.pub")
}
