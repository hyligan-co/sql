create table PUBLIC.ROLES
(
    ID        INTEGER auto_increment,
    ROLE_NAME CHARACTER VARYING(100) not null,
    constraint ROLES_PK
        primary key (ID)
);

create unique index PUBLIC.ROLES_ROLE_NAME_UINDEX
    on PUBLIC.ROLES (ROLE_NAME);

create table PUBLIC.TYPE_CONTACTS
(
    ID        INTEGER auto_increment,
    TYPE_NAME CHARACTER VARYING(100) not null,
    constraint TYPE_CONTACTS_PK
        primary key (ID)
);

create table PUBLIC.USERS
(
    ID          INTEGER auto_increment,
    NICK_NAME   CHARACTER VARYING(50)            not null,
    FIRST_NAME  CHARACTER VARYING(100)           not null,
    LAST_NAME   CHARACTER VARYING(100),
    DELETED     INTEGER   default 0,
    CREATE_DATE TIMESTAMP default LOCALTIMESTAMP not null,
    UPDATE_DATE TIMESTAMP default LOCALTIMESTAMP on update LOCALTIMESTAMP,
    constraint USERS_PK
        primary key (ID)
);

create table PUBLIC.CONTACTS
(
    ID        INTEGER auto_increment,
    CONTACT   CHARACTER VARYING(255) not null,
    USER_ID   INTEGER,
    "TYPE_id" INTEGER,
    constraint CONTACTS_PK
        primary key (ID),
    constraint "CONTACTS_TYPE_CONTACTS_ID_fk"
        foreign key ("TYPE_id") references PUBLIC.TYPE_CONTACTS,
    constraint "contacts_USERS_ID_fk"
        foreign key (USER_ID) references PUBLIC.USERS
            on update cascade on delete cascade
);

create unique index PUBLIC.CONTACTS_CONTACT_UINDEX
    on PUBLIC.CONTACTS (CONTACT);

create unique index PUBLIC.USERS_NICK_NAME_UINDEX
    on PUBLIC.USERS (NICK_NAME);

create table PUBLIC.USER_TO_ROLES
(
    USER_ID INTEGER,
    ROLE_ID INTEGER,
    constraint "USER_TO_ROLES_ROLES_ID_fk"
        foreign key (ROLE_ID) references PUBLIC.ROLES
            on update cascade on delete cascade,
    constraint "USER_TO_ROLES_USERS_ID_fk"
        foreign key (USER_ID) references PUBLIC.USERS
            on update cascade on delete cascade
);

