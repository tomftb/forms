<?php

/**
 * Description of Db_model
 *
 * @author tomborc
 */
abstract class Database_model {
    protected ?object $Main;
    private ?string $date='';
    private ?string $RA='';
    private ?array $addOn=[
        /* create */
        'create'=>[
            'v'=>'`create_user_id`,`create_user_login`,`create_user_full_name`,`create_user_email`,`create_date`,`create_host`'
            ,'p'=>':create_user_id,:create_user_login,:create_user_full_name,:create_user_email,:create_date,:create_host'
        ],
        /* mod */
        'modify'=>[
            'v'=>'`mod_user_id`,`mod_user_login`,`mod_user_full_name`,`mod_user_email`,`mod_date`,`mod_host`'
            ,'p'=>':mod_user_id,:mod_user_login,:mod_user_full_name,:mod_user_email,:mod_date,:mod_host'
        ],
        /* SQL UPDATE */
        'update'=>'`mod_user_id`=:mod_user_id,`mod_user_login`=:mod_user_login,`mod_user_full_name`=:mod_user_full_name,`mod_user_email`=:mod_user_email,`mod_date`=:mod_date,`mod_host`=:mod_host',
    ];
    protected function __construct(){
        $this->Main=\LoadDb::load();
        $this->date=date("Y-m-d H:i:s");
        $this->RA=filter_input(INPUT_SERVER,'REMOTE_ADDR');
    }
    public function __call($m,$a){
        Throw New \Exception(__METHOD__.'() Method `'.$m.'` not exists in this class `'.__CLASS__.'`!\nMethod call with arguments:\n'.serialize($a),1);
    }
    protected function getCreateUserParm(){
        return [
            ':create_user_id'=>[intval($_SESSION['userid'],10),'INT'],
            ':create_user_login'=>[$_SESSION['username'],'STR'],
            ':create_user_full_name'=>[$_SESSION['nazwiskoImie'],'STR'],
            ':create_user_email'=>[$_SESSION['mail'],'STR'],
            ':create_date'=>[$this->date,'STR'],
            ':create_host'=>[$this->RA,'STR']
        ];
    }
    protected function getAlterUserParm(){
        return[
            ':mod_user_id'=>[intval($_SESSION['userid'],10),'INT'],
            ':mod_user_login'=>[$_SESSION['username'],'STR'],
            ':mod_user_full_name'=>[$_SESSION['nazwiskoImie'],'STR'],
            ':mod_user_email'=>[$_SESSION['mail'],'STR'],
            ':mod_date'=>[$this->date,'STR'],
            ':mod_host'=>[$this->RA,'STR']
        ];
    }
    protected function getCreateSql(){
        return $this->addOn['create'];
    }
    protected function getModifySql(){
        return $this->addOn['modify'];
    }
    protected function getUpdateSql(){
        return $this->addOn['update'];
    }
    protected function getUserKey(){
        return $this->addOn['create']['v'].','.$this->addOn['modify']['v'];
    }
    protected function getUserValue(){
        return $this->addOn['create']['p'].','.$this->addOn['modify']['p'];
    }
    protected function getUserParm(){
        return array_merge(self::getCreateUserParm(),self::getAlterUserParm());
    }
    public function lastInsertId(){
        $this->Main->lastInsertId();
    }
    protected function getStatusDate(){
        return [':status_date'=>[$this->date,'STR']];
    }
}