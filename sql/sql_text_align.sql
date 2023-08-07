-- TEXT ALIGN

INSERT INTO `slo_style` (`PL`,`ENG`,`GROUP`,`NUMBER`) VALUE ('Lewo','LEFT',1,1);
INSERT INTO `slo_style` (`PL`,`ENG`,`GROUP`,`NUMBER`) VALUE ('Prawo','RIGHT',1,2);
INSERT INTO `slo_style` (`PL`,`ENG`,`GROUP`,`NUMBER`) VALUE ('Wyśrodkuj','CENTRE',1,3);
INSERT INTO `slo_style` (`PL`,`ENG`,`GROUP`,`NUMBER`) VALUE ('Wyjustuj','JUSTIFY',1,4);

-- MEASUREMENT

INSERT INTO `slo_style` (`PL`,`ENG`,`GROUP`,`NUMBER`) VALUE ('px','px',2,1);
INSERT INTO `slo_style` (`PL`,`ENG`,`GROUP`,`NUMBER`) VALUE ('pt','pt',2,2);
INSERT INTO `slo_style` (`PL`,`ENG`,`GROUP`,`NUMBER`) VALUE ('cm','cm',2,3);
INSERT INTO `slo_style` (`PL`,`ENG`,`GROUP`,`NUMBER`) VALUE ('mm','mm',2,4);
INSERT INTO `slo_style` (`PL`,`ENG`,`GROUP`,`NUMBER`) VALUE ('pkt','pkt',2,5);

-- line spacing

INSERT INTO `slo_list` (`NAME`,`VALUE`,`TYPE`) VALUE ('co najmniej','atLeast','l');
INSERT INTO `slo_list` (`NAME`,`VALUE`,`TYPE`) VALUE ('pojedynczy','single','l');
INSERT INTO `slo_list` (`NAME`,`VALUE`,`TYPE`) VALUE ('jeden i pół','oneAndHalf','l');
INSERT INTO `slo_list` (`NAME`,`VALUE`,`TYPE`) VALUE ('dokładnie','exactly','l');
INSERT INTO `slo_list` (`NAME`,`VALUE`,`TYPE`) VALUE ('wiele','multiple','l');

-- leading sign

INSERT INTO `slo_list` (`NAME`,`VALUE`,`TYPE`) VALUE ('kropka','dot','ls');
INSERT INTO `slo_list` (`NAME`,`VALUE`,`TYPE`) VALUE ('myślnik','dash','ls');
INSERT INTO `slo_list` (`NAME`,`VALUE`,`TYPE`) VALUE ('podkreślnik','underline','ls');
INSERT INTO `slo_list` (`NAME`,`VALUE`,`TYPE`) VALUE ('brak','none','ls');

-- list type

INSERT INTO `slo_list_type`(`NAME`, `VALUE`) VALUES ('&#8226;','bullet');
INSERT INTO `slo_list_type`(`NAME`, `VALUE`) VALUES ('0 1 2 3 4 ...','decimal');
INSERT INTO `slo_list_type`(`NAME`, `VALUE`) VALUES ('0. 1. 2. 3. 4. ...','decimal-dot');
INSERT INTO `slo_list_type`(`NAME`, `VALUE`) VALUES ('00 01 02 03 04 ...','decimal-round-right-bracket');

INSERT INTO `slo_list_type`(`NAME`, `VALUE`) VALUES ('0) 1) 2) 3) 4) ...','decimal-leading-zero');
INSERT INTO `slo_list_type`(`NAME`, `VALUE`) VALUES ('a b c d ...','upper-alpha');
INSERT INTO `slo_list_type`(`NAME`, `VALUE`) VALUES ('a. b. c. d. ...','upper-alpha-dot');
INSERT INTO `slo_list_type`(`NAME`, `VALUE`) VALUES ('a) b) c) d) ...','upper-alpha-round-right-bracket');

INSERT INTO `slo_list_type`(`NAME`, `VALUE`) VALUES ('i ii iii iv ...','lower-alpha');
INSERT INTO `slo_list_type`(`NAME`, `VALUE`) VALUES ('i. ii. iii. iv. ...','lower-alpha-dot');
INSERT INTO `slo_list_type`(`NAME`, `VALUE`) VALUES ('i) ii) iii) iv) ...','lower-alpha-round-right-bracket');
INSERT INTO `slo_list_type`(`NAME`, `VALUE`) VALUES ('A B C D ....','lower-roman');

INSERT INTO `slo_list_type`(`NAME`, `VALUE`) VALUES ('A. B. C. D. ....','lower-roman-dot');
INSERT INTO `slo_list_type`(`NAME`, `VALUE`) VALUES ('A) B) C) D) ....','lower-roman-round-right-bracket');
INSERT INTO `slo_list_type`(`NAME`, `VALUE`) VALUES ('I II III IV ....','upper-roman');
INSERT INTO `slo_list_type`(`NAME`, `VALUE`) VALUES ('I. II. III. IV. ....','upper-roman-dot');

INSERT INTO `slo_list_type`(`NAME`, `VALUE`) VALUES ('I) II) III) IV) ....','upper-roman-round-right-bracket');
