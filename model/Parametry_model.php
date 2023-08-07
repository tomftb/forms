<?php

class Parametry_model extends Database_model {
    public function __construct(){
        parent::__construct();
    }
    public function __call($m,$a){
        Throw New \Exception(__METHOD__.'() Method `'.$m.'` not exists in this class `'.__CLASS__.'`!\nMethod call with arguments:\n'.serialize($a));
    }
    public function getDefaults():array{
        return $this->Main->squery('SELECT `ID` as \'i\' ,`Skrót` as \'s\',`Nazwa` as \'n\',`Opis` as \'o\',`Wartość` as \'v\',`Typ` as \'t\',`ModDat` as \'md\',`ModUser` as \'mu\' FROM `v_parm_v2` ORDER BY `ID` asc');
    }
    public function getAll(array $input=[':f'=>['','STR']]):array{
        return $this->Main->squery('SELECT `ID` as \'i\' ,`Skrót` as \'s\',`Nazwa` as \'n\',`Opis` as \'o\',`Wartość` as \'v\',`Typ` as \'t\',`ModDat` as \'md\',`ModUser` as \'mu\' FROM `v_parm_v2` WHERE ID LIKE (:f) OR Skrót LIKE (:f) OR Nazwa LIKE (:f) OR Opis LIKE (:f) OR Wartość LIKE (:f) ORDER BY ID ASC',$input);
    }
    public function get(array $input=[':i'=>[0,'INT']]):array{
        return $this->Main->squery("SELECT * FROM `parametry` WHERE `ID`=:i;",$input);
    }
    public function update(array $input=[':W'=>['','STR'],':MD'=>['','STR'],':ML'=>['','STR'],':MU'=>['','STR'],':MUI'=>['','STR'],':MH'=>['','STR'],':I'=>[0,'INT']]):void{
        try{
            $this->Main->beginTransaction(); //PHP 5.1 and new
            $this->Main->execute('UPDATE `parametry` SET `WARTOSC`=:W,`MOD_DATE`=:MD,`MOD_LOGIN`=:ML,`MOD_USER`=:MU,`MOD_USER_ID`=:MUI,`MOD_HOST`=:MH WHERE `ID`=:I',$input);
            $this->Main->commit();  
        }
        catch (PDOException $e){
            $this->dbLink->rollback();
            Throw New Exception ("[".__METHOD__."] Wystąpił błąd zapytania bazy danych: ".$e->getMessage(),1); 
        } 
    }
    public function getParmSkrt(array $input=[':i'=>[0,'INT']]){
        return $this->Main->squery('SELECT `SKROT` FROM parametry WHERE ID=:i',$input)[0]['SKROT'];
    }
    public function getColor(){
        return $this->Main->squery('SELECT `ENG` as `n`,`HEX` as `v` FROM `slo_color` WHERE 1;');
    }
    public function getTextAlign(){
        return $this->Main->squery('SELECT `PL` as n,`ENG` as `v` FROM `slo_style` WHERE `GROUP`=1 ORDER BY `NUMBER` ASC');
    }
    public function getTextDecoration(){
        return $this->Main->squery('SELECT `PL` as n,`ENG` as `v` FROM `slo_style` WHERE `GROUP`=0 ORDER BY `NUMBER` ASC');
    }
    public function getMeasurement(){
        return $this->Main->squery('SELECT `PL` as n,`ENG` as `v` FROM `slo_style` WHERE `GROUP`=2 ORDER BY `NUMBER` ASC');
    }
    public function getFontFamily(){
        return $this->Main->squery('SELECT `NAME` as n,`NAME` as `v` FROM `slo_font_family` ORDER BY `NAME` ASC');
    }
    public function getLineSpacing(){
        return $this->Main->squery('SELECT `NAME` as n,`VALUE` as `v` FROM `slo_list` WHERE `TYPE`=\'l\' ORDER BY `id` ASC');
    }
    public function getListType(){
        return $this->Main->squery('SELECT `NAME` as n,`VALUE` as v FROM `slo_list_type` ORDER BY `VALUE` ASC');
    }
}
