## 로컬 DB 환경 설정

### Docker Host에 설치하고 실행하기

```shell
docker run --name bladi-todo -p 3306:3306 -e MYSQL_ROOT_PASSWORD="password" -d mysql:5.7.29 --character-set-server=utf8mb4 --collation-server=utf8mb4_unicode_ci
docker exec -it bladi-todo env TERM=xterm-256color script -q -c "/bin/bash" /dev/null
```

### Container 세팅

#### apt와 vim 설치

```shell
apt-get install apt
apt update
apt install vim -y
```

#### bash shell 컬러링

```shell
vi ~/.bashrc
```

```shell
if [ -x /usr/bin/dircolors ]; then
test -r ~/.dircolors && eval "$(dircolors -b ~/.dircolors)" || eval "$(dircolors -b)"
alias ls='ls --color=auto'
alias grep='grep --color=auto'
alias fgrep='fgrep --color=auto'
alias egrep='egrep --color=auto'
fi
```

#### 시간대 설정

```shell
rm /etc/localtime
ln -s /usr/share/zoneinfo/Asia/Seoul /etc/localtime
date
```

KST가 나오면 됩니다!

#### mysql 설정

```shell
vi /etc/mysql/mysql.conf.d/mysqld.cnf
```

```
[client]
default-character-set = utf8mb4

[mysqld]
init-connect = 'SET collation_connection = utf8mb4_unicode_ci'
init-connect = 'SET NAMES utf8mb4'
character-set-server = utf8mb4
collation-server = utf8mb4_unicode_ci
default_time_zone='+09:00'

[mysql]
default-character-set = utf8mb4

[mysqldump]
default-character-set = utf8mb4
```

```shell
service mysql restart
```

### 도커 재실행 후 도커 컨테이너에 접속

```shell
docker restart bladi-todo
docker exec -it bladi-todo env TERM=xterm-256color script -q -c "/bin/bash" /dev/null
```

```shell
mysql -uroot -p
password 입력
```

```mysql
SHOW VARIABLES LIKE 'char%';
```

```
+--------------------------+----------------------------+
| Variable_name            | Value                      |
+--------------------------+----------------------------+
| character_set_client     | utf8mb4                    |
| character_set_connection | utf8mb4                    |
| character_set_database   | utf8mb4                    |
| character_set_filesystem | binary                     |
| character_set_results    | utf8mb4                    |
| character_set_server     | utf8mb4                    |
| character_set_system     | utf8                       |
| character_sets_dir       | /usr/share/mysql/charsets/ |
+--------------------------+----------------------------+
```

```mysql
SHOW VARIABLES LIKE '%collation%';
```

```
+----------------------+--------------------+
| Variable_name        | Value              |
+----------------------+--------------------+
| collation_connection | utf8mb4_general_ci |
| collation_database   | utf8mb4_unicode_ci |
| collation_server     | utf8mb4_unicode_ci |
+----------------------+--------------------+
```

```mysql
SHOW VARIABLES WHERE Variable_name LIKE '%time_zone%';
```

```
+------------------+--------+
| Variable_name    | Value  |
+------------------+--------+
| system_time_zone | KST    |
| time_zone        | +09:00 |
+------------------+--------+
```

### DB 설정

유저는 권한을 최소화하는 것이 좋습니다.

```mysql
CREATE DATABASE todo;
CREATE USER 'user'@'%' IDENTIFIED BY 'password';
GRANT ALL PRIVILEGES ON todo.* TO 'user'@'%';
FLUSH PRIVILEGES;
```

`ctrl + p, q` 로 나오면 됩니다.
