ALTER TABLE `project`
	ADD KEY `FK_ProjectNadzorId` (`nadzor_id`),
	ADD KEY `FK_ProjectKierGrupyId` (`kier_grupy_id`),
	ADD KEY `FK_ProjectKierOsrId` (`kier_osr_id`),
	ADD KEY `FK_ProjectTechnologId` (`technolog_id`);
COMMIT;
 
ALTER TABLE `project`
	ADD CONSTRAINT `FK_ProjectNadzorId` FOREIGN KEY (`nadzor_id`) REFERENCES `employee` (`id`),
	ADD CONSTRAINT `FK_ProjectKierGrupyId` FOREIGN KEY (`kier_grupy_id`) REFERENCES `employee` (`id`),
	ADD CONSTRAINT `FK_ProjectKierOsrId` FOREIGN KEY (`kier_osr_id`) REFERENCES `employee` (`id`),
	ADD CONSTRAINT `FK_ProjectTechnologId` FOREIGN KEY (`technolog_id`) REFERENCES `employee` (`id`);
COMMIT;