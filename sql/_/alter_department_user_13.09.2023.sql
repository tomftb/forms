-- ADD KEYS

ALTER TABLE `department_user`
  ADD KEY `FK_DepartmentUserDepartment` (`id_department`),
  ADD KEY `FK_DepartmentUserUser` (`id_user`);
COMMIT;

-- ADD CONSTRAINTS

ALTER TABLE `department_user`
  ADD CONSTRAINT `FK_DepartmentUserDepartment` FOREIGN KEY (`id_department`) REFERENCES `department` (`id`),
  ADD CONSTRAINT `FK_DepartmentUserUser` FOREIGN KEY (`id_user`) REFERENCES `uzytkownik` (`id`);
COMMIT;

-- ADD UNIQUE

ALTER TABLE `department_user`
ADD CONSTRAINT `UNIQUE_DepartmentUser` UNIQUE KEY(`id_department`,`id_user`);
COMMIT;