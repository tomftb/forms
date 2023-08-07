ALTER TABLE `uzytkownik` ADD CONSTRAINT `FK_UserRole` FOREIGN KEY (`id_rola`) REFERENCES `slo_rola`(`id`);

ALTER TABLE `uzytkownik` ADD CONSTRAINT `FK_UserAccountType` FOREIGN KEY (`typ`) REFERENCES `app_account_type`(`id`);

 
CREATE VIEW `v_slo_rola` AS SELECT `ID`,`NAZWA` FROM `slo_rola` WHERE `WSK_U`='0';

ALTER TABLE `slo_rola` ADD CONSTRAINT `FK_RoleUser` FOREIGN KEY (`create_user_id`) REFERENCES `uzytkownik` (`id`);

ALTER TABLE `slo_rola` ADD CONSTRAINT `FK_RoleUserMod` FOREIGN KEY (`mod_user_id`) REFERENCES `uzytkownik` (`id`);

ALTER TABLE `uzyt_i_upr` ADD CONSTRAINT `UNIQUE_UserPerm` UNIQUE KEY(`id_uzytkownik`,`id_uprawnienie`);


ALTER TABLE `uzyt_i_upr` ADD CONSTRAINT `FK_UserPerm_User` FOREIGN KEY (`id_uzytkownik`) REFERENCES `uzytkownik`(`id`);

ALTER TABLE `uzyt_i_upr` ADD CONSTRAINT `FK_UserPerm_Perm` FOREIGN KEY (`id_uprawnienie`) REFERENCES `uprawnienia`(`ID`);


INSERT INTO `uprawnienia`(`SKROT`) VALUES ("LOG_INTO_APP"),VALUES ("LOG_INTO_PROJ");


INSERT INTO `uprawnienia`(`SKROT`) VALUES ("LOG_INTO_PROJ");

INSERT INTO `uprawnienia`(`SKROT`) VALUES ("LOG_INTO_EMPL");

INSERT INTO `uprawnienia`(`SKROT`) VALUES ("LOG_INTO_USER");

INSERT INTO `uprawnienia`(`SKROT`) VALUES ("LOG_INTO_PERM");

INSERT INTO `uprawnienia`(`SKROT`) VALUES ("LOG_INTO_ROLE");

INSERT INTO `uprawnienia`(`SKROT`) VALUES ("LOG_INTO_PARM");

INSERT INTO `uprawnienia`(`SKROT`) VALUES ("LOG_INTO_STAGE");

INSERT INTO `uprawnienia`(`SKROT`) VALUES ("ADD_STAGE");

INSERT INTO `uprawnienia`(`SKROT`) VALUES ("ADD_USER");

INSERT INTO `uprawnienia`(`SKROT`) VALUES ("SHOW_PERM_USER");

CREATE VIEW `v_uzyt_i_upr_v2` AS SELECT `u`.`SKROT`,`up`.`id_uzytkownik` as `idUzytkownik` FROM `uzyt_i_upr` as `up`, `uprawnienia` as `u` WHERE `u`.`id`=`up`.`id_uprawnienie`;


INSERT INTO `uzyt_i_upr` (`id_uzytkownik`, `id_uprawnienie`) VALUES ('1', '1');
INSERT INTO `uzyt_i_upr` (`id_uzytkownik`, `id_uprawnienie`) VALUES ('1', '2');
INSERT INTO `uzyt_i_upr` (`id_uzytkownik`, `id_uprawnienie`) VALUES ('1', '3');
INSERT INTO `uzyt_i_upr` (`id_uzytkownik`, `id_uprawnienie`) VALUES ('1', '4');
INSERT INTO `uzyt_i_upr` (`id_uzytkownik`, `id_uprawnienie`) VALUES ('1', '5');
INSERT INTO `uzyt_i_upr` (`id_uzytkownik`, `id_uprawnienie`) VALUES ('1', '6');
INSERT INTO `uzyt_i_upr` (`id_uzytkownik`, `id_uprawnienie`) VALUES ('1', '7');
INSERT INTO `uzyt_i_upr` (`id_uzytkownik`, `id_uprawnienie`) VALUES ('1', '8');
INSERT INTO `uzyt_i_upr` (`id_uzytkownik`, `id_uprawnienie`) VALUES ('1', '9');
INSERT INTO `uzyt_i_upr` (`id_uzytkownik`, `id_uprawnienie`) VALUES ('1', '10');
INSERT INTO `uzyt_i_upr` (`id_uzytkownik`, `id_uprawnienie`) VALUES ('1', '11');


CREATE VIEW `v_upr_i_uzyt_v3` AS SELECT 
	`up`.`id_uzytkownik` as 'id'
	,CONCAT(`u`.`Imie`," ",`u`.`Nazwisko`) AS 'ImieNazwisko'
	,`up`.`id_uprawnienie` as `idUprawnienie`

 FROM 
 `uzytkownik` as `u`,
 `uzyt_i_upr` as `up`
 WHERE 
 `u`.`id`=`up`.`id_uzytkownik`;
 
 
-- VIEW `v_all_user`
 
 CREATE VIEW `v_all_user` AS SELECT 
	`u`.`id` as 'ID'
	,`u`.`imie` as 'Imie'
	,`u`.`nazwisko` AS 'Nazwisko'
	,`u`.`login` AS 'Login'
	,`u`.`email` AS 'Email'
	,`u`.`wsk_u` as `wskU`
	,`u`.`id_rola` as `IdRola`
	,`u`.`typ` as `TypKontaValue`
 FROM 
 `uzytkownik` as `u`
	WHERE 1 
	
-- VIEW `v_slo_rola_all`
 
 CREATE VIEW `v_slo_rola_all` AS SELECT 
	`r`.`ID`
	,`r`.`NAZWA` as 'Nazwa'
	,`r`.`WSK_U` AS 'WSK_U'

 FROM 
 `slo_rola` as `r`
	WHERE 1 
	
-- VIEW `v_slo_upr`
 
 CREATE VIEW `v_slo_upr` AS SELECT 
	`u`.`ID`
	,`u`.`NAZWA`

 FROM 
 `uprawnienia` as `u`
	WHERE 1 
	
	
	                ':mod_user_id'=>[$_SESSION["userid"],'INT'],
                ':mod_user_login'=>[$_SESSION["username"],'STR'],
                ':mod_user_full_name'=>[$_SESSION["nazwiskoImie"],'STR'],
                ':mod_user_email'=>[$_SESSION["mail"],'STR'],
                ':mod_host'=>[RA,'STR']
				
				,`mod_user_id`,`mod_user_login`,`mod_user_full_name`,`mod_user_email`,`mod_host`
				,:mod_user_id,:mod_user_login,:mod_user_full_name,:mod_user_email,:mod_host
				
				
				
ALTER TABLE `upr_i_slo_rola` ADD CONSTRAINT `FK_PermRole_Perm` FOREIGN KEY (`id_upr`) REFERENCES `uprawnienia` (`id`);
ALTER TABLE `upr_i_slo_rola` ADD CONSTRAINT `FK_PermRole_Role` FOREIGN KEY (`id_rola`) REFERENCES `slo_rola` (`ID`);