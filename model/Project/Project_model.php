<?php

class Project_model extends Database_model {
    public function __construct(){
        parent::__construct();
    }
    public function __call($m,$a){
        Throw New \Exception(__METHOD__.'() Method `'.$m.'` not exists in this class `'.__CLASS__.'`!\nMethod call with arguments:\n'.serialize($a),0);
    }
    public function getProjects(){
        return $this->Main->squery('SELECT 
                        `id` as "i",
                        `numer_umowy` as "n",
                        `klient` as "k",
                        `temat_umowy` as "t",
                        `typ` as "t2",
                        `create_date` as "du",
                        `nadzor` as "l",
                        `kier_grupy` as "m",
                        `term_realizacji` as "ds",
                        `koniec_proj` as "dk",     
                        (case when (`status` = "n") then "Nowy" when (`status` = "c") then "Zamknięty" when (`status` = "d") then "Usunięty" when (`status` = "m") then "W trakcie" else "Błąd" end) as "s"
                 FROM `project` WHERE `delete_status`=\'0\' ORDER BY `create_date` DESC'
                );
    }
    public function getProjectRodzajUmowy(int $id=0):array{
        foreach($this->Main->squery('SELECT `rodzaj_umowy_id` as "ID",`rodzaj_umowy` as "Nazwa",`rodzaj_umowy_alt` as "NazwaAlt" FROM `project` WHERE `delete_status`=\'0\' AND `id`=:id',[':id'=>[$id,'INT']]) as $project){
           return $project;
        }
        Throw New Exception ('Projekt o id '.$id.' został usunięty.',0);
    }
    public function getProjectNadzor(int $id=0):array{
        foreach($this->Main->squery('SELECT `nadzor_id` as "id",`nadzor` as "ImieNazwisko" FROM `project` WHERE `delete_status`=\'0\' AND `id`=:id',[':id'=>[$id,'INT']]) as $project){
           return $project;
        }
        Throw New Exception ('Projekt o id '.$id.' został usunięty.',0);
    }
    public function getProjectKierownikGrupy(int $id=0):array{
        foreach($this->Main->squery('SELECT `kier_grupy_id` as "id",`kier_grupy` as "ImieNazwisko" FROM `project` WHERE `delete_status`=\'0\' AND `id`=:id',[':id'=>[$id,'INT']]) as $project){
           return $project;
        }
        Throw New Exception ('Projekt o id '.$id.' został usunięty.',0);
    }
    public function getProjectTechnolog(int $id=0):array{
        foreach($this->Main->squery('SELECT `technolog_id` as "id",`technolog` as "ImieNazwisko" FROM `project` WHERE `delete_status`=\'0\' AND `id`=:id',[':id'=>[$id,'INT']]) as $project){
           return $project;
        }
        Throw New Exception ('Projekt o id '.$id.' został usunięty.',0);
    }
    public function getProjectKierownikOsrodka(int $id=0):array{
        foreach($this->Main->squery('SELECT `kier_osr_id` as "id",`kier_osr` as "ImieNazwisko" FROM `project` WHERE `delete_status`=\'0\' AND `id`=:id',[':id'=>[$id,'INT']]) as $project){
           return $project;
        }
        Throw New Exception ('Projekt o id '.$id.' został usunięty.',0);
    }
    public function getProjectTyp(int $id=0):array{
        foreach($this->Main->squery('SELECT `typ_id` as "ID",`typ` as "Nazwa" FROM `project` WHERE `delete_status`=\'0\' AND `id`=:id',[':id'=>[$id,'INT']]) as $project){
           return $project;
        }
        Throw New Exception ('Projekt o id '.$id.' został usunięty.',0);
    }
    public function getProjectSystem(int $id=0):array{
        foreach($this->Main->squery('SELECT `system_id` as "ID",`system` as "Nazwa" FROM `project` WHERE `delete_status`=\'0\' AND `id`=:id',[':id'=>[$id,'INT']],'FETCH_DEFAULT','fetchAll') as $project){
           return $project;
        }
        Throw New Exception ('Projekt o id '.$id.' został usunięty.',0);
    }
    public function getProjectUnit(int $id=0):array{
        foreach($this->Main->squery('SELECT `j_dane` FROM `project` WHERE `delete_status`=\'0\' AND `id`=:id',[':id'=>[$id,'INT']]) as $project){
           return $project['j_dane'];
        }
        Throw New Exception ('Projekt o id '.$id.' został usunięty.',0);
    }
    public function get_v_all_proj_v10(int $id=0):array{
        foreach($this->Main->squery('SELECT `id`,`numer_umowy`,`klient`,`temat_umowy`,`term_realizacji`,`harm_data`,`koniec_proj`,`quota`,`r_dane`,`j_dane`,`nadzor`,`nadzor_id`,`kier_grupy`,`kier_grupy_id`,`kier_osr`,`kier_osr_id`,`technolog`,`technolog_id` FROM `project` WHERE `delete_status`=\'0\' AND `id`=:id',[':id'=>[$id,'INT']]) as $project){
           return $project;
        }
        Throw New Exception ('Projekt o id '.$id.' został usunięty.',0);
    }
    public function exists(string $column='numer_umowy', string $value='', string $msg=''):void{
        foreach ($this->Main->squery('SELECT * FROM `project` WHERE `delete_status`=\'0\' AND  `'.$column.'`=:'.$column,[':'.$column=>[$value,'STR']]) as $project){
            Throw New \Exception ($msg,0); 
        }
    }
    public function getProjectData(string|int $id=0):array{
        foreach($this->Main->squery("SELECT `id` as `i`, `temat_umowy` as `t`,`create_user_login` as `cu`,`create_user_full_name` as `cum`,`create_date` as `cd` FROM `project` WHERE `id`=:id",[':id'=>[$id,'INT']]) as $project){
            return $project;
        }
        Throw New Exception ('Nie istnieje projekt o id '.$id.'. Został usunięt?',0);
    }
    public function getShortProjectData(string|int $id=0):array{
        foreach($this->Main->squery("SELECT `numer_umowy`,`klient`,`temat_umowy`,`typ` FROM `project` WHERE id=:id",[':id'=>[$id,'INT']]) as $project){
             return $project;
        }
        Throw New Exception ('Nie istnieje projekt o id '.$id.'. Został usunięt?',0);
    }
    public function getProjectsLike(string $s='', string $filter='', string $delete_status='0'){
        /*
         * s ?? 
         */
        return $this->Main->squery('SELECT 
                        `id` as "i",
                        `numer_umowy` as "n",
                        `klient` as "k",
                        `temat_umowy` as "t",
                        `typ` as "t2",
                        `create_date` as "du",
                        `nadzor` as "l",
                        `kier_grupy` as "m",
                        `term_realizacji` as "ds",
                        `koniec_proj` as "dk",     
                        (case when (`status` = "n") then "Nowy" when (`status` = "c") then "Zamknięty" when (`status` = "d") then "Usunięty" when (`status` = "m") then "W trakcie" else "Błąd" end) as "s"
                 FROM `project` WHERE `delete_status`=:delete_status AND (`id` LIKE (:f) OR `numer_umowy` LIKE (:f) OR `temat_umowy` LIKE (:f) OR `kier_grupy` LIKE (:f) OR `nadzor` LIKE (:f) OR `term_realizacji` LIKE (:f) OR `typ` LIKE (:f) OR `koniec_proj` LIKE (:f) OR `status` LIKE (:f) OR `klient` LIKE (:f)) ORDER BY `id` desc'
                ,[':f'=>[$filter,'STR'],':delete_status'=>[$delete_status,'STR']]);
    }
    public function getProjectById(string|int $id=0):array{
        foreach($this->Main->squery('SELECT 
                        `id` as "i",
                        `numer_umowy` as "n",
                        `klient` as "k",
                        `temat_umowy` as "t",
                        `typ` as "t2",
                        `create_date` as "du",
                        `nadzor` as "l",
                        `kier_grupy` as "m",
                        `term_realizacji` as "ds",
                        `koniec_proj` as "dk",     
                        (case when (`status` = "n") then "Nowy" when (`status` = "c") then "Zamknięty" when (`status` = "d") then "Usunięty" when (`status` = "m") then "W trakcie" else "Błąd" end) as "s"
                 FROM `project` WHERE `delete_status`=\'0\' AND `id`=:id LIMIT 0,1'
                ,[':id'=>[$id,'INT']]) as $project){
            return $project;
        }
        Throw New Exception ('Nie istnieje projekt o id '.$id.'. Został usunięt?',0);
    }  
    public function insert(array $input=[]):void{
            $this->Main->query2('INSERT INTO `project` ('
                        .'`id`'
                        .',`rodzaj_umowy`'
                        .',`rodzaj_umowy_alt`'
                        .',`numer_umowy`'
                        .',`temat_umowy`'
                        .',`kier_grupy`'
                        .',`kier_grupy_id`'
                        .',`term_realizacji`'
                        .',`harm_data`'
                        .',`koniec_proj`'
                        .',`nadzor`'
                        .',`nadzor_id`'
                        .',`kier_osr`'
                        .',`kier_osr_id`'
                        .',`technolog`'
                        .',`technolog_id`'
                        .',`r_dane`'
                        .',`j_dane`'
                        .',`klient`'
                        .',`typ`'
                        .',`system`'
                        .',`rodzaj_umowy_id`'
                        .',typ_id,system_id'
                        .',quota'
                        .','.parent::getUserKey()
                        .') VALUES ('
                        . ':id'
                        . ',:rodzaj_umowy'
                        . ',:rodzaj_umowy_alt'
                        . ',:numer_umowy'
                        . ',:temat_umowy'
                        . ',:kier_grupy'
                        . ',:kier_grupy_id'
                        . ',:term_realizacji'
                        . ',:harm_data'
                        . ',:koniec_proj'
                        . ',:nadzor'
                        . ',:nadzor_id'
                        . ',:kier_osr'
                        . ',:kier_osr_id'
                        . ',:technolog'
                        . ',:technolog_id'
                        . ',:r_dane'
                        . ',:j_dane'
                        . ',:klient'
                        . ',:typ'
                        . ',:system'
                        . ',:rodzaj_umowy_id'
                        . ',:typ_id'
                        . ',:system_id'
                        . ',:quota'
                        . ','.parent::getUserValue()
                        . ')'
                    ,array_merge(
                            [
                            ':id'=>[$input['id'],'INT'],
                            ':rodzaj_umowy'=>[$input['rodzaj_umowy'][1],'STR'],
                            ':rodzaj_umowy_alt'=>[$input['rodzaj_umowy'][2],'STR'],
                            ':numer_umowy'=>[$input['numer_umowy'],'STR'],
                            ':temat_umowy'=>[$input['temat_umowy'],'STR'],
                            ':kier_grupy'=>[$input['kier_grupy'][1],'STR'],
                            ':kier_grupy_id'=>[$input['kier_grupy'][0],'INT'],
                            ':term_realizacji'=>[$input['d-term_realizacji'],'STR'],
                            ':harm_data'=>[$input['d-harm_data'],'STR'],
                            ':koniec_proj'=>[$input['d-koniec_proj'],'STR'],
                            ':nadzor'=>[$input['nadzor'][1],'STR'],
                            ':nadzor_id'=>[$input['nadzor'][0],'INT'],
                            ':kier_osr'=>[$input['gl_kier'][1],'STR'],
                            ':kier_osr_id'=>[$input['gl_kier'][0],'INT'],
                            ':technolog'=>[$input['gl_tech'][1],'STR'],
                            ':technolog_id'=>[$input['gl_tech'][0],'INT'],
                            ':r_dane'=>[$input['r_dane'],'INT'],
                            ':j_dane'=>[$input['j_dane'],'STR'],
                            ':klient'=>[$input['klient'],'STR'],
                            ':typ'=>[$input['typ_umowy'][1],'STR'],
                            ':system'=>[$input['system_umowy'][1],'STR'],
                            ':rodzaj_umowy_id'=>[$input['rodzaj_umowy'][0],'INT'],
                            ':typ_id'=>[$input['typ_umowy'][0],'INT'],
                            ':system_id'=>[$input['system_umowy'][0],'INT'],
                            ':quota'=>[$input['quota'],'INT']
                            ,   
                            ]
                            ,parent::getUserParm()
                    ));
    }
    public function update(array $input=[]):void{
        $this->Main->query2('UPDATE `project` SET '
                . '`rodzaj_umowy`=:rodzaj_umowy'
                . ',`rodzaj_umowy_alt`=:rodzaj_umowy_alt'
                . ',`numer_umowy`=:numer_umowy'
                . ',`temat_umowy`=:temat_umowy'
                . ',`kier_grupy`=:kier_grupy'
                . ',`kier_grupy_id`=:kier_grupy_id'
                . ',`term_realizacji`=:term_realizacji'
                . ',`harm_data`=:harm_data'
                . ',`koniec_proj`=:koniec_proj'
                . ',`nadzor`=:nadzor'
                . ',`nadzor_id`=:nadzor_id'
                . ',`kier_osr`=:kier_osr'
                . ',`kier_osr_id`=:kier_osr_id'
                . ',`technolog`=:technolog'
                . ',`technolog_id`=:technolog_id'
                . ',`r_dane`=:r_dane'
                . ',`j_dane`=:j_dane'
                . ',`klient`=:klient'
                . ',`typ`=:typ'
                . ',`system`=:system'
                . ',`rodzaj_umowy_id`=:rodzaj_umowy_id'
                . ',`typ_id`=:typ_id'
                . ',`system_id`=:system_id'
                . ',`quota`=:quota'
                . ','.parent::getUpdateSql()
                . ' WHERE '
                . 'id=:id'
                ,array_merge(
            [
                ':rodzaj_umowy'=>[$input['rodzaj_umowy'][1],'STR'],
                ':rodzaj_umowy_alt'=>[$input['rodzaj_umowy'][2],'STR'],
                ':numer_umowy'=>[$input['numer_umowy'],'STR'],
                ':temat_umowy'=>[$input['temat_umowy'],'STR'],
                ':kier_grupy'=>[$input['kier_grupy'][1],'STR'],
                ':kier_grupy_id'=>[$input['kier_grupy'][0],'INT'],
                ':term_realizacji'=>[$input['d-term_realizacji'],'STR'],
                ':harm_data'=>[$input['d-harm_data'],'STR'],
                ':koniec_proj'=>[$input['d-koniec_proj'],'STR'],
                ':nadzor'=>[$input['nadzor'][1],'STR'],
                ':nadzor_id'=>[$input['nadzor'][0],'INT'],
                ':kier_osr'=>[$input['gl_kier'][1],'STR'],
                ':kier_osr_id'=>[$input['gl_kier'][0],'INT'],
                ':technolog'=>[$input['gl_tech'][1],'STR'],
                ':technolog_id'=>[intval($input['gl_tech'][0],10),'INT'],
                ':r_dane'=>[$input['r_dane'],'INT'],
                ':j_dane'=>[$input['j_dane'],'STR'],
                ':klient'=>[$input['klient'],'STR'],
                ':typ'=>[$input['typ_umowy'][1],'STR'],
                ':system'=>[$input['system_umowy'][1],'STR'],
                ':rodzaj_umowy_id'=>[$input['rodzaj_umowy'][0],'INT'],
                ':typ_id'=>[$input['typ_umowy'][0],'INT'],
                ':system_id'=>[$input['system_umowy'][0],'INT'],
                ':quota'=>[$input['quota'],'INT'],
                ":id"=>[$input['id'],'INT']
            ]
            ,parent::getAlterUserParm()    
            )
        ); 
    }
    public function projectExists(string $field_name='',string $field_value='',int $id=0):array{
        foreach($this->Main->squery('SELECT * FROM `project` WHERE `id`!=:id AND `'.$field_name.'`=:field_value AND `delete_status`=\'0\'',[':id'=>[$id,'INT'],':field_value'=>[$field_value,'STR']]) as $project){
             return $project;
        }
        return [];
    }
    public function getProjectPostField(int $id=0):array{
        foreach($this->Main->squery("SELECT "
                . "`id` "
                . ",CONCAT(`rodzaj_umowy_id`,'|',`rodzaj_umowy`,'|',`rodzaj_umowy_alt`) as `rodzaj_umowy` "
                . ",`numer_umowy`"
                . ",`klient`"
                . ",`temat_umowy`"
                . ",CONCAT(`typ_id`,'|',`typ`) as `typ_umowy` "
                . ",CONCAT(`system_id`,'|',`system`) as `system_umowy` "
                . ",CONCAT(`nadzor_id`,'|',`nadzor`) as `nadzor` "
                . ",SUBSTRING(`term_realizacji` FROM 1 FOR 10) as `d-term_realizacji`"
                . ",SUBSTRING(`harm_data`,1,10) as `d-harm_data`"
                . ",SUBSTRING(`koniec_proj`,1,10) as `d-koniec_proj`"
                . ",CONCAT(`kier_grupy_id`,'|',`kier_grupy`) as `kier_grupy` "
                . ",CONCAT(`technolog_id`,'|',`technolog`) as `gl_tech` "
                . ",CONCAT(`kier_osr_id`,'|',`kier_osr`) as `gl_kier` "
                . ",`r_dane`"
                . ",`j_dane`"
                 . ",`quota`"
                . "FROM "
                . "`project` "
                . "WHERE "
                . "`id`=:id"
                ,[
                    ':id'=>[$id,'INT']
                ]) as $project){
             return $project;
        }
        Throw New Exception ('Nie istnieje projekt o id '.$id.'. Został usunięt?',0);
    }
    public function setCloseStatus(array $input=[]):void{
        $this->Main->query('UPDATE `project` SET '
                . '`status`=:status'
                . ',`status_info`=:reason'
                . ','.parent::getUpdateSql()
                . ' WHERE '
                . '`id`=:id'
                ,array_merge(
                        [
                            ':status'=>['c','STR']
                            ,':reason'=>[$input['reason'],'STR']
                            ,':id'=>[$input['id'],'STR']
                        ]
                        ,parent::getAlterUserParm() 
                )
        );
    }
     public function setDeleteStatus(array $input=[]):void{
        $this->Main->query('UPDATE `project` SET '
                . '`status`=:status'
                . ',`status_info`=:reason'
                . ',`delete_status`=:delete_status'
                . ',`delete_date`=:delete_date'
                . ',`delete_reason`=:delete_reason'
                . ',`status_info`=:reason'
                . ','.parent::getUpdateSql()
                . ' WHERE '
                . '`id`=:id'
                ,array_merge(
                        [
                            ':delete_status'=>['1','STR']
                            ,':delete_date'=>[parent::getDate(),'STR']
                            ,':delete_reason'=>[$input['reason'],'STR']
                            ,':status'=>['d','STR']
                            ,':reason'=>[$input['reason'],'STR']
                            ,':id'=>[$input['id'],'STR']
                        ]
                        ,parent::getAlterUserParm() 
                )
        );
    }
    public function getProjectEmployeesEmail(int $id_project=0):array{
        return $this->Main->squery(''
                . 'SELECT '
                . 'CONCAT(`ep`.`name`,\' \',`ep`.`surname`) as `Pracownik`'
                . ',`e`.`email` as `Email`'
                . ' FROM '
                . ' `employee` as `e`, `employee_project` as `ep` '
                . 'WHERE '
                . '`e`.`id`=`ep`.`id_employee` '
                . 'AND `ep`.`id_project`=:id_project '
                . 'ORDER BY `ep`.`surname` ASC'
                ,[
                    ':id_project'=>[$id_project,'INT']
                ]
        );
    }
    public function getProjectForEmail(int $id=0):array{
         foreach($this->Main->squery(''
                 . 'SELECT '
                 . '`create_user_full_name`'
                 . ',`create_user_email`'
                 . ',`rodzaj_umowy`'
                 . ',`numer_umowy`'
                 . ',`temat_umowy`'
                 . ',`kier_grupy`'
                 . ',`term_realizacji` as \'d-term_realizacji\''
                 . ',`harm_data`'
                 . ',`koniec_proj` as \'d-koniec_proj\''
                 . ',`nadzor`'
                 . ',`kier_osr`'
                 . ',`technolog`'
                 . ',`klient`'
                 . ',`typ` as \'typ_umowy\''
                 . ',`system`'
                 . ',`r_dane`'
                 . ',`j_dane`'
                 . ',`quota`'
                 . ' FROM '
                 . '`project` '
                 . 'WHERE '
                 . '`id`=:id '
                 . 'AND `delete_status`=\'0\' '
                ,[
                    ':id'=>[$id,'INT']
                ]) as $project){
             return $project;
        }
        Throw New Exception ('Nie istnieje projekt o id '.$id.'. Został usunięt?',0);
    }
    public function getProjectDataForPdf(int $id=0):array{
        foreach($this->Main->squery('SELECT '
                . '`create_date`'
                . ',`create_user_full_name`'
                . ',`create_user_email`'
                . ',`rodzaj_umowy`'
                . ',`numer_umowy`'
                . ',`temat_umowy`'
                . ',`kier_grupy`'
                . ',`term_realizacji` as \'d-term_realizacji\''
                . ',`harm_data`'
                . ',`koniec_proj` as \'d-koniec_proj\''
                . ',`nadzor`'
                . ',`kier_osr`'
                . ',`technolog`'
                . ',`klient`'
                . ',`typ` as \'typ_umowy\''
                . ',`system`'
                . ',`r_dane`'
                . ',`j_dane`'
                . ',`quota` '
                . ' FROM '
                . '`project` '
                . 'WHERE '
                . '`id`=:id '
                . 'AND `delete_status`=\'0\''
                ,[
                    ':id'=>[$id,'INT']
                ]) as $project){
             return $project;
        }
        Throw New Exception ('Nie istnieje projekt o id '.$id.'. Został usunięt?',0);
    }
    public function getProjectDataForDoc(int $id=0):array{
        foreach($this->Main->squery('SELECT '
                . '`create_date`'
                . ',`create_user_full_name`'
                . ',`create_user_email`'
                . ',`rodzaj_umowy`'
                . ',`numer_umowy`'
                . ',`temat_umowy`'
                . ',`klient`'
                . ',`kier_grupy`'
                . ',`term_realizacji` as \'d-term_realizacji\''
                . ',`harm_data`'
                . ',`koniec_proj` as \'d-koniec_proj\''
                . ',`nadzor`'
                . ',`kier_osr`'
                . ',`technolog`'
                . ',`klient`'
                . ',`typ` as \'typ_umowy\''
                . ',`system`'
                . ',`r_dane`'
                . ',`j_dane`'
                . ',`quota` '
                . ' FROM '
                . '`project` '
                . 'WHERE '
                . '`id`=:id '
                . 'AND `delete_status`=\'0\' '
                ,[
                    ':id'=>[$id,'INT']
                ]) as $project){
             return $project;
        }
        Throw New Exception ('Nie istnieje projekt o id '.$id.'. Został usunięt?',0);
    }
}