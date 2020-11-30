alter table card
    drop
        foreign key card_ref_list;

alter table card
    drop
        foreign key card_ref_user;

alter table list
    drop
        foreign key list_ref_board;

alter table log
    drop
        foreign key log_ref_board;

drop table if exists board;

drop table if exists card;

drop table if exists list;

drop table if exists log;

drop table if exists user;

create table board
(
    id               bigint auto_increment primary key,
    created_datetime datetime(6),
    updated_datetime datetime(6),
    created_by       bigint,
    updated_by       bigint,
    name             varchar(255)
) engine = InnoDB;

create table card
(
    id                bigint auto_increment primary key,
    created_datetime  datetime(6),
    updated_datetime  datetime(6),
    created_by        bigint,
    updated_by        bigint,
    archived_datetime datetime(6),
    contents          varchar(255),
    is_archived       bit not null,
    title             varchar(255),
    list_id           bigint,
    user_id           bigint
) engine = InnoDB;

create table list
(
    id                bigint auto_increment primary key,
    created_datetime  datetime(6),
    updated_datetime  datetime(6),
    created_by        bigint,
    updated_by        bigint,
    archived_datetime datetime(6),
    is_archived       bit not null,
    name              varchar(255),
    board_id          bigint
) engine = InnoDB;

create table log
(
    id               bigint auto_increment primary key,
    created_datetime datetime(6),
    updated_datetime datetime(6),
    created_by       bigint,
    updated_by       bigint,
    after_contents   varchar(255),
    before_contents  varchar(255),
    from_list_id     bigint,
    to_list_id       bigint,
    type             varchar(255),
    board_id         bigint
) engine = InnoDB;

create table user
(
    id                bigint auto_increment primary key,
    created_datetime  datetime(6),
    updated_datetime  datetime(6),
    github_token      varchar(255),
    profile_image_url varchar(255),
    user_id           varchar(255),
    user_nickname     varchar(255)
) engine = InnoDB;

alter table card
    add constraint card_ref_list
        foreign key (list_id)
            references list (id);

alter table card
    add constraint card_ref_user
        foreign key (user_id)
            references user (id);

alter table list
    add constraint list_ref_board
        foreign key (board_id)
            references board (id);

alter table log
    add constraint log_ref_board
        foreign key (board_id)
            references board (id);
