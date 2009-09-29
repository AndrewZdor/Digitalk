CREATE TABLE `admin_groupings` (
  `id` int(11) NOT NULL auto_increment,
  `group_id` int(11) default NULL,
  `user_id` int(11) default NULL,
  `created_at` datetime default NULL,
  `updated_at` datetime default NULL,
  PRIMARY KEY  (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

CREATE TABLE `assignments` (
  `id` int(11) NOT NULL auto_increment,
  `user_id` int(11) default NULL,
  `entity_id` int(11) default NULL,
  `row_id` int(11) default NULL,
  `permission` int(11) default NULL,
  `assigned_by_user_id` int(11) default NULL,
  `created_at` datetime default NULL,
  `updated_at` datetime default NULL,
  PRIMARY KEY  (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

CREATE TABLE `blogs` (
  `id` int(11) NOT NULL auto_increment,
  `project_id` int(11) default NULL,
  `title` varchar(255) default NULL,
  `description` text,
  `published_date` datetime default NULL,
  `is_published` tinyint(1) default NULL,
  `created_at` datetime default NULL,
  `updated_at` datetime default NULL,
  PRIMARY KEY  (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

CREATE TABLE `clients` (
  `id` int(11) NOT NULL auto_increment,
  `mrc_id` int(11) default NULL,
  `name` varchar(255) default NULL,
  `address` varchar(255) default NULL,
  `address2` varchar(255) default NULL,
  `city` varchar(255) default NULL,
  `state` varchar(255) default NULL,
  `zip` varchar(255) default NULL,
  `phone` varchar(255) default NULL,
  `created_at` datetime default NULL,
  `updated_at` datetime default NULL,
  PRIMARY KEY  (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

CREATE TABLE `entities` (
  `id` int(11) NOT NULL auto_increment,
  `name` varchar(255) collate utf8_unicode_ci default NULL,
  `parent_id` int(11) default NULL,
  `created_at` datetime default NULL,
  `updated_at` datetime default NULL,
  PRIMARY KEY  (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

CREATE TABLE `mrcs` (
  `id` int(11) NOT NULL auto_increment,
  `name` varchar(255) default NULL,
  `address` varchar(255) default NULL,
  `address2` varchar(255) default NULL,
  `city` varchar(255) default NULL,
  `state` varchar(255) default NULL,
  `zip` varchar(255) default NULL,
  `phone` varchar(255) default NULL,
  `created_at` datetime default NULL,
  `updated_at` datetime default NULL,
  PRIMARY KEY  (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

CREATE TABLE `ownerships` (
  `id` int(11) NOT NULL auto_increment,
  `user_id` int(11) default NULL,
  `ownable_id` int(11) default NULL,
  `role_id` int(11) default NULL,
  `ownable_type` varchar(255) default NULL,
  `created_at` datetime default NULL,
  `updated_at` datetime default NULL,
  PRIMARY KEY  (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

CREATE TABLE `project_groups` (
  `id` int(11) NOT NULL auto_increment,
  `name` varchar(255) collate utf8_unicode_ci default NULL,
  `description` varchar(255) collate utf8_unicode_ci default NULL,
  `created_at` datetime default NULL,
  `updated_at` datetime default NULL,
  PRIMARY KEY  (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

CREATE TABLE `project_users` (
  `id` int(11) NOT NULL auto_increment,
  `Project_id` int(11) default NULL,
  `User_id` int(11) default NULL,
  `ProjectGroup_id` int(11) default NULL,
  `created_at` datetime default NULL,
  `updated_at` datetime default NULL,
  PRIMARY KEY  (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

CREATE TABLE `projects` (
  `id` int(11) NOT NULL auto_increment,
  `client_id` int(11) default NULL,
  `title` varchar(255) default NULL,
  `description` text,
  `start_date` date default NULL,
  `end_date` date default NULL,
  `display` tinyint(1) default NULL,
  `created_at` datetime default NULL,
  `updated_at` datetime default NULL,
  PRIMARY KEY  (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

CREATE TABLE `roles` (
  `id` int(11) NOT NULL auto_increment,
  `name` varchar(255) default NULL,
  `description` text,
  `created_at` datetime default NULL,
  `updated_at` datetime default NULL,
  PRIMARY KEY  (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

CREATE TABLE `schema_migrations` (
  `version` varchar(255) NOT NULL,
  UNIQUE KEY `unique_schema_migrations` (`version`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

CREATE TABLE `surveys` (
  `id` int(11) NOT NULL auto_increment,
  `project_id` int(11) default NULL,
  `title` varchar(255) default NULL,
  `description` text,
  `published_date` datetime default NULL,
  `is_approved` tinyint(1) default NULL,
  `created_at` datetime default NULL,
  `updated_at` datetime default NULL,
  PRIMARY KEY  (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

CREATE TABLE `users` (
  `id` int(11) NOT NULL auto_increment,
  `login` varchar(40) NOT NULL,
  `first_name` varchar(100) default '',
  `last_name` varchar(100) default '',
  `crypted_password` varchar(40) NOT NULL,
  `salt` varchar(40) default NULL,
  `level` varchar(255) default NULL,
  `phone` varchar(255) default NULL,
  `mobile` varchar(255) default NULL,
  `created_at` datetime default NULL,
  `updated_at` datetime default NULL,
  `remember_token` varchar(40) default NULL,
  `remember_token_expires_at` datetime default NULL,
  `isGroup` tinyint(1) default NULL,
  `isAdmin` tinyint(1) default NULL,
  PRIMARY KEY  (`id`),
  UNIQUE KEY `index_users_on_login` (`login`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

INSERT INTO schema_migrations (version) VALUES ('20090825062256');

INSERT INTO schema_migrations (version) VALUES ('20090825083905');

INSERT INTO schema_migrations (version) VALUES ('20090905111820');

INSERT INTO schema_migrations (version) VALUES ('20090905111854');

INSERT INTO schema_migrations (version) VALUES ('20090905112336');

INSERT INTO schema_migrations (version) VALUES ('20090905112527');

INSERT INTO schema_migrations (version) VALUES ('20090905112614');

INSERT INTO schema_migrations (version) VALUES ('20090905114857');

INSERT INTO schema_migrations (version) VALUES ('20090924173659');

INSERT INTO schema_migrations (version) VALUES ('20090924175248');

INSERT INTO schema_migrations (version) VALUES ('20090925093727');

INSERT INTO schema_migrations (version) VALUES ('20090925101532');

INSERT INTO schema_migrations (version) VALUES ('20090925102138');

INSERT INTO schema_migrations (version) VALUES ('20090925135114');