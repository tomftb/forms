<?php

require APP_ROOT.'/lib/phpmailer/src/Exception.php';
require APP_ROOT.'/lib/phpmailer/src/PHPMailer.php';
require APP_ROOT.'/lib/phpmailer/src/SMTP.php';

//use PHPMailer\PHPMailer\PHPMailer;
//use PHPMailer\PHPMailer\Exception;
use PHPMailer\PHPMailer as PHPMailer;

class Email

//class Email extends PHPMailer
{
    protected $emailParm=array();
    protected $email='';
    private $eFooter='';
    private $SN='';
    private $err='';
    private $Log;
    private $dbLink;
    private $sendAttempts=1;
    private $sendAttemptsTimeout=2;
    private ?object $Mailer;
    
    function __construct(){
        $this->Log=Logger::init(__METHOD__);
	$this->dbLink=LoadDb::load();
        $this->Mailer = new PHPMailer\PHPMailer(email['exception']);
        $this->Log->log(0,"[".__METHOD__."]");
        self::setConfig();
        $this->SN=filter_input(INPUT_SERVER,"SERVER_NAME");
    }
    public function setConfig():void{
        //print(__METHOD__."\n");
        if(!defined('email')){
            Throw New \Exception('Email config not set!');
        }
	$this->Mailer->SMTPAuth   = email['SMTPAuth'];               // enable SMTP authentication
	$this->Mailer->SMTPSecure = email['SMTPSecure'];              // sets the prefix to the servier
	$this->Mailer->Host       = email['Host'];
	$this->Mailer->Port       = email['Port'];
	$this->Mailer->Username   = email['Username'];
	$this->Mailer->Password   = email['Password'];
        $this->Mailer->CharSet    = email['CharSet'];
        $this->Mailer->SMTPKeepAlive = email['SMTPKeepAlive'];
        $this->Mailer->Timeout =  email['Timeout'];
        $this->sendAttempts = email['sendAttempts'];
        $this->sendAttemptsTimeout = email['sendAttemptsTimeout'];
        self::setIsSMTP(email['isSMTP']);
        $this->Mailer->isHTML(email['isHTML']);
        $this->Mailer->SetFrom(email['From'][0], email['From'][1]);
    }
    private function setIsSMTP(bool $isSMTP=true):void{
        //print(__METHOD__."\n");
        if($isSMTP){
            $this->Mailer->IsSMTP();
        }
    }
    private function parseParm($data)
    {
        if(!is_array($data)){
            $this->Log->log(0,'NO EMAIL PARAMETERS IN DATABASE');  
            Throw New \Exception('NO EMAIL PARAMETERS IN DATABASE',1);
        }
        $tmpArray=array();
        foreach($data as $value)
        {
            $tmpArray[$value['SKROT']]=$value['WARTOSC'];
        }
        return($tmpArray);
    }	
    private function getFooter($html)
    {   
        if($html){
            return ("<p style=\"font-size:12px;color:#999999;\">--<br/>Ta wiadomość została wygenerowana automatycznie z portalu ".$this->SN.", nie odpowiadaj na nią.");
        }
        return("\n\n--\nTa wiadomość została wygenerowana automatycznie z portalu ".$this->SN.", nie odpowiadaj na nią.");
    }
    public function sendMail($subject,$body,$recipient,$errHeader,$html=false)
    {
        $this->Log->log(0,"[".__METHOD__."]");
        $this->err='';
        $this->Mailer->isHTML($html);
        $this->Mailer->clearReplyTos();
        
        $this->Mailer->AddReplyTo(email['From'][0], email['From'][1]);
       // foreach($recipient as $data){
          //  $this->Mailer->AddAddress($data[0],$data[1]);
       // }
        $this->Mailer->Subject = $subject;
	$this->Mailer->AltBody = '';
	$this->Mailer->MsgHTML($body.$this->getFooter($html));
        
       // parent::setFrom($this->Username, $this->Username);
        if(!self::setRecipientAddresses($recipient)){
          Throw New \Exception ($this->err,0);
       }
        //$this->Subject  = $subject;
        //$this->Body     = $body.$this->getFooter($html);
        self::sendAttempt($errHeader);
        //if(!parent::send()){
          //  $this->Log->log(0,"[".__METHOD__."] ".$this->ErrorInfo);
           // parent::SmtpClose(); 
           // Throw New \Exception ('Projekt został założony, niestety pojawił się problem z wysyłką powiadomienia email.',0);
        //}
        return '';
    }
    private function sendAttempt(string $errHeader=''):void{
        
        $established=false;

        while($this->sendAttempts>0 && $established===false)
        {
            $this->Log->log(0,"[".__METHOD__."] attempt - ".$this->sendAttempts);
            //$this->Log->log(0,"[".__METHOD__."] error info - ".$this->Mailer->ErrorInfo);
            if($this->Mailer->Send()){
                $established=true;
                $this->connectAttemptTimeout=0;
            }
            $this->sendAttempts--;
            sleep($this->sendAttemptsTimeout);
        }
        if(!$established){
            //$this->Log->log(0,"[".__METHOD__."] Couldn't send Email! ");
            $this->Mailer->SmtpClose(); 
            Throw New \Exception ($errHeader,0);
            //Throw New Exception ("Couldn't send Email!\n");
        }
        $this->Mailer->SmtpClose(); 
    }
    private function setRecipientAddresses(array $recipient=[])
    {
        $no_err=true;
        foreach($recipient as $emailAdres)
        {
            $this->Log->logMulti(0,$emailAdres,__LINE__."::".__METHOD__); 
            if(count($this->Mailer->parseAddresses($emailAdres[0]))>0){
                $this->Mailer->addAddress($emailAdres[0],$emailAdres[1]);
            }
            else
            {
                $this->err.="<br/>[".$emailAdres[1]."] Nieprawidłowy adres email - ".$emailAdres[0];
                $no_err=false;
            }
        }
        return $no_err;
    }
    public function getErr()
    {
        return $this->err;
    }
}
