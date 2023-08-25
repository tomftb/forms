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
                 FROM `project` WHERE `delete_status`=\'0\' ORDER BY `id` DESC'
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
    public function get_v_slo_um_proj():array{
        return $this->Main->squery('SELECT * FROM `v_slo_um_proj` ORDER BY `ID` ASC');
    }
    public function get_v_all_proj_v10(int $id=0):array{
        foreach($this->Main->squery('SELECT `id`,`numer_umowy`,`klient`,`temat_umowy`,`term_realizacji`,`harm_data`,`koniec_proj`,`quota`,`r_dane` FROM `project` WHERE `delete_status`=\'0\' AND `id`=:id',[':id'=>[$id,'INT']]) as $project){
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
}