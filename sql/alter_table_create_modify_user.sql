ALTER TABLE `project_document` 
ADD `create_user_id` INT NOT NULL AFTER `delete_status`, 
ADD `create_user_login` VARCHAR(100) NOT NULL AFTER `create_user_id`, 
ADD `create_user_full_name` VARCHAR(200) NOT NULL AFTER `create_user_login`, 
ADD `create_user_email` VARCHAR(300) NOT NULL AFTER `create_user_full_name`, 
ADD `create_date` DATETIME NOT NULL AFTER `create_user_email`, 
ADD `create_host` VARCHAR(100) NOT NULL AFTER `create_date`, 
ADD `mod_user_id` INT NOT NULL AFTER `create_host`,
ADD `mod_user_login` VARCHAR(100) NOT NULL AFTER `mod_user_id`, 
ADD `mod_user_full_name` VARCHAR(200) NOT NULL AFTER `mod_user_login`, 
ADD `mod_user_email` VARCHAR(300) NOT NULL AFTER `mod_user_full_name`, 
ADD `mod_date` DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP AFTER `mod_user_email`, 
ADD `mod_host` VARCHAR(100) NOT NULL AFTER `mod_date`;

ALTER TABLE `project_document`
  ADD CONSTRAINT `FK_ProjectDocumentCreateUser` FOREIGN KEY (`create_user_id`) REFERENCES `uzytkownik` (`id`),
  ADD CONSTRAINT `FK_ProjectDocumentModifyUser` FOREIGN KEY (`mod_user_id`) REFERENCES `uzytkownik` (`id`);
COMMIT;

-- `create_user_id`,`create_user_login`,`create_user_full_name`,`create_user_email`,`create_date`,`create_host`,`mod_user_id`,`mod_user_login`,`mod_user_full_name`,`mod_user_email`,`mod_date`,`mod_host`

-- :mod_user_id,:mod_user_login,:mod_user_full_name,:mod_user_email,:mod_date,:mod_host

-- :create_user_id,:create_user_login,:create_user_full_name,:create_user_email,:create_date,:create_host,:mod_user_id,:mod_user_login,:mod_user_full_name,:mod_user_email,:mod_date,:mod_host