<?php

class Slo_project_stage_model extends Database_model {
    public function __construct(){
        parent::__construct();
    }
    public function __call($m,$a){
        Throw New \Exception(__METHOD__.'() Method `'.$m.'` not exists in this class `'.__CLASS__.'`!\nMethod call with arguments:\n'.serialize($a),1);
    }
    public function insertStage(array $parm=[]):void{
        $this->Main->query2(
                "INSERT INTO `slo_project_stage` (`id`,`departmentId`,`departmentName`,`title`,`type`,`new_page`,`part`,".parent::getUserKey().") VALUES (:id,:departmentId,:departmentName,:title,:type,:new_page,:part,".parent::getUserValue().");"
                ,array_merge($parm, parent::getUserParm()));
    }
    public function insertSection(array $parm=[':id'=>[0,'INT'],':id_parent'=>[0,'INT']]):void{
        $this->Main->query2(
            "INSERT INTO `slo_project_stage_section` (`id`,`id_parent`,".parent::getUserKey().") VALUES (:id,:id_parent,".parent::getUserValue().");"
            ,array_merge($parm,parent::getUserParm()));   
    }
    public function insertSubsection(array $parm=[':id'=>[0,'INT'],':id_parent'=>[0,'INT']]):void{
        $this->Main->query2(
            "INSERT INTO `slo_project_stage_subsection` (`id`,`id_parent`,".parent::getUserKey().") VALUES (:id,:id_parent,".parent::getUserValue().");"
            ,array_merge($parm,parent::getUserParm()));   
    }
    public function insertSubsectionRow(array $parm=[':id'=>[0,'INT'],':id_parent'=>[0,'INT']]):void{
        $this->Main->query2(
            "INSERT INTO `slo_project_stage_subsection_row` (`id`,`id_parent`,".parent::getUserKey().") VALUES (:id,:id_parent,".parent::getUserValue().");"
            ,array_merge($parm,parent::getUserParm()));   
    }
    public function insertSubsectionRowImage(array $parm=[':id'=>[0,'INT'],':id_parent'=>[0,'INT']]):void{
        $this->Main->query2(
            "INSERT INTO `slo_project_stage_subsection_row_i` (`id`,`id_parent`,".parent::getUserKey().") VALUES (:id,:id_parent,".parent::getUserValue().");"
            ,array_merge($parm,parent::getUserParm()));   
    }
    public function insertTabStop(array $parm=[]):void{
        $this->Main->query2(
                    "INSERT INTO `slo_project_stage_subsection_row_p_tabstop` (`id_parent`,`lp`,`position`,`measurement`,`measurementName`,`alignment`,`alignmentName`,`leadingSign`,`leadingSignName`,".parent::getUserKey().") VALUES (:id_parent,:lp,:position,:measurement,:measurementName,:alignment,:alignmentName,:leadingSign,:leadingSignName,".parent::getUserValue().");"
                    ,array_merge($parm,parent::getUserParm())
                );
    }
    public function insertVariable(array $parm=[]){
        $this->Main->query2(
                    "INSERT INTO `slo_project_stage_subsection_row_p_variable` (`id_parent`,`id_variable`,`name`,`value`,`type`,".parent::getUserKey().") VALUES (:id,:id_variable,:name,:value,:type,".parent::getUserValue().");"
                    ,array_merge($parm,parent::getUserParm())
                );
    }
    public function insertProperty(string $table='',array $parm=['id_parent'=>[0,'INT'],'property'=>['','STR'],'value'=>['','STR']]):void{
        $this->Main->query2(
                 "INSERT INTO `".$table."` (`id_parent`,`property`,`value`,".parent::getUserKey().") VALUES (:id_parent,:property,:value,".parent::getUserValue().");"
                  ,array_merge($parm, parent::getUserParm())
            );
    }
    public function delete(string $table='',array $parm=[':id'=>[0,'INT']]):void{
         $this->Main->query2("DELETE FROM `".$table."` WHERE `id_parent`=:id;",$parm);
    }
    public function getStageFullData(array $parm=[':id'=>[0,'INT']]):object{
        return $this->Main->squery("SELECT s.`id`,s.`departmentId`,s.`departmentName`,s.`title`,s.`new_page` as valuenewline, s.`create_user_login`,s.`create_user_email`,s.`create_date`,s.`mod_user_login`,s.`mod_user_email`,s.`mod_date`,s.`buffer_user_id` as 'bu',b.`login` as 'bl' FROM `slo_project_stage` s LEFT JOIN `uzytkownik` as b ON s.`buffer_user_id`=b.`id` WHERE s.id=:id",$parm,'FETCH_OBJ','fetch');  
    }
    public function getStageEqual(array $parm=[':id'=>[0,'INT']]){
        return $this->Main->squery("SELECT s.`id` as 'i',s.`title` as 't',d.`name` as 'd',s.`create_user_full_name` as 'cu',s.`create_user_login` as 'cul',s.`create_date` as 'cd',s.`mod_user_login` as 'mu',s.`mod_date` as 'md',s.`buffer_user_id` as 'bu',s.`delete_status` as 'wu',b.`login` as 'bl' FROM `slo_project_stage` as s LEFT JOIN `uzytkownik` as b ON s.`buffer_user_id`=b.`id`, `department` as d WHERE s.`departmentId`=d.`id` AND s.`id`=:id LIMIT 0,1",$parm);
    }
    public function getSection(array $parm=[':id'=>[0,'INT']]):array{
        return $this->Main->squery("SELECT `id` FROM `slo_project_stage_section` WHERE `id_parent`=:id AND `delete_status`='0';",$parm,'FETCH_OBJ','fetchAll');
    }
    public function getSubsection(array $parm=[':id'=>[0,'INT']]):array{
        return $this->Main->squery("SELECT `id` FROM `slo_project_stage_subsection` WHERE `id_parent`=:id AND `delete_status`='0';",$parm,'FETCH_OBJ','fetchAll');
    }
    public function getSubsectionRow(array $parm=[':id'=>[0,'INT']]):array{
        return $this->Main->squery("SELECT `id` FROM `slo_project_stage_subsection_row` WHERE `id_parent`=:id AND `delete_status`='0';",$parm,'FETCH_OBJ','fetchAll');
    }
    public function deleteStage(array $parm=[':id'=>[0,'INT']]):void{
        $this->Main->query("UPDATE `slo_project_stage` SET `delete_status`=:status,`delete_reason`=:reason,`delete_date`=:status_date,".parent::getUpdateSql()." WHERE `id`=:id",
                array_merge($parm,parent::getStatusDate(),parent::getAlterUserParm()));
    }
    public function hideStage(array $parm=[':id'=>[0,'INT']]):void{
         $this->Main->query("UPDATE `slo_project_stage` SET `hide_status`=:status,`hide_reason`=:reason,`hide_date`=:status_date,".parent::getUpdateSql()." WHERE `id`=:id",
                array_merge($parm,parent::getStatusDate(),parent::getAlterUserParm()));
    }
    public function updateDeleteWithReason(string $table='slo_project_stage_subsection_row', array $parm=[':id'=>[0,'INT'],':reason'=>['Removed by edit','STR'],':status'=>['1','STR']]){
          $this->Main->query("UPDATE ".$table." SET `delete_status`=:status,`delete_reason`=:reason,`delete_date`=:status_date,".parent::getUpdateSql()." WHERE `id_parent`=:id AND `delete_status`='0'",
                array_merge($parm,parent::getStatusDate(),parent::getAlterUserParm()));
    }
    public function getStages(string $where='',array $parm=[]):array{
        return $this->Main->squery("SELECT s.`id` as 'i',s.`title` as 't',b.`login` as 'bl' FROM `slo_project_stage` s LEFT JOIN `uzytkownik` as b ON s.`buffer_user_id`=b.`id` ".$where,$parm);
    }
    public function getChildId(string $table='slo_project_stage_subsection_row_i',array $parm=[':id'=>[0,'INT']]):array{
        return $this->Main->squery("SELECT `id` FROM `".$table."` WHERE `id_parent`=:id AND `delete_status`='0';",$parm,'FETCH_OBJ','fetchAll');
    }
}