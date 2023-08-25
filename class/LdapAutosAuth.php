<?php

class LdapAutosAuth {
    private ?bool $sslValue=false;
    private ?array $content=[];
    private $requestResult;
    private ?object $responseData;
    private ?array $checkProperty=['id','name','surname','mail','city','department'];
    
    public function __construct(){
        $this->responseData=new \stdClass();
    }
    public function __call($m,$a){
        Throw New \Exception(__METHOD__.'() Method `'.$m.'` not exists in this class `'.__CLASS__.'`!\nMethod call with arguments:\n'.serialize($a),1);
    }
    public function auth(string $login='', string $password=''){

        /*
         * SET DATA
         */
        $data = [
            'token'=>self::getToken()
            ,'user' =>$login
            ,'pass'=>$password
            ,'group' => 'app.panel_autos'
            ];
        /*
         * SET BASIC CONTENT
         */
        self::setBasicContent($data);
        /*
         * SET SSL
         */
        self::{'setSSL_'.AUTOS_API_AD_SSL_INTERNAL}();
        
        /*
         * CHECK RESPONSE HEADER
         */
        self::checkResponseHeader();
        self::setResponse();
        self::checkResponseData();
	return $this->responseData;
    }
    private function setBasicContent(array $data=[]):void{
        //echo __METHOD__."<br/>";
        $this->content['http']=[
			'ignore_errors' => true,
			'method' => 'POST',
			'header'  => "Content-type: application/x-www-form-urlencoded",
			'content' => http_build_query($data)
        ];
    }
    private function setSSLcontent():void{
        //echo __METHOD__."<br/>";
        $this->content['ssl'] =[
                    'verify_peer' => $this->sslValue,
                    'verify_peer_name'  => $this->sslValue,
                    'verify_expiry'     => $this->sslValue,
                    'allow_self_signed' => $this->sslValue,
                    'cafile' => AUTOS_SSL_CERT 
        ];
    }
    private function setSSL_yes(){
        //echo __METHOD__."<br/>";
        $this->sslValue=true;
        self::checkCert();
        self::setSSLcontent();
    }
    private function setSSL_no(){
        //echo __METHOD__."<br/>";
        $this->sslValue=false;
    }
    private function getToken() {
        //echo __METHOD__."<br/>";
        $date = time();
	$hashString = md5($date);
        $splitDate = str_split($date, 2);
	$hash[0] = substr($hashString, 0, 7);
	$hash[1] = substr($hashString, 7, 7);
	$hash[2] = substr($hashString, 14, 5);
	$hash[3] = substr($hashString, 19, 9);
	$hash[4] = substr($hashString, -4);
	// 2/4/5/1/3
	$newHash = $hash[1].$splitDate[1].$hash[3].$splitDate[3].$hash[4].$splitDate[4].$hash[0].$splitDate[0].$hash[2].$splitDate[2];
	return self::encode($newHash);
    }
    public function encode(string $value=''):string {
        //echo __METHOD__."<br/>";
	$key = sha1('Yy7NS9GpHt4X57PKyec7b4xtNjYWsSDxnDrqdWYc');
	$strLen = strlen($value);
	$keyLen = strlen($key);
	$j = 0;
	$crypttext = '';
	for ($i = 0; $i < $strLen; $i++) {
            $ordStr = ord(substr($value, $i, 1));
	    if ($j == $keyLen) {
	        $j = 0;
	    }
	    $ordKey = ord(substr($key, $j, 1));
	    $j++;
	    $crypttext .= strrev(base_convert(dechex($ordStr + $ordKey), 16, 36));
	}
	return $crypttext;
    }
    private function checkCert(){
        //echo __METHOD__."<br/>";
        if(!file_exists(AUTOS_SSL_CERT)){
            Throw New \Exception("AUTOS_SSL_CERT - `".AUTOS_SSL_CERT." NOT EXISTS!",1);
        }
        if(!is_file(AUTOS_SSL_CERT)){
            Throw New \Exception("AUTOS_SSL_CERT  - `".AUTOS_SSL_CERT." NOT A FILE!",1);
        }
        if(!is_readable(AUTOS_SSL_CERT)){
            Throw New \Exception("AUTOS_SSL_CERT - `".AUTOS_SSL_CERT." `NOT READABLE!",1);
        }
    }
    private function checkResponseHeader(){
        //echo __METHOD__."<br/>";
        //echo "<BR/><BR/><BR/><BR/><BR/><BR/>RESULT<br/>";
        /*
         * SET RESPONSE
         */
        $this->requestResult = @file_get_contents(AUTOS_API_AD_INTERNAL, false, stream_context_create($this->content));
        
        $matches=null;
        $responseCode='500';
        $error=[];

        if(!$this->requestResult){
            $error = error_get_last();
            Throw New \Exception($error['message'],1);
        }
        /*
         * SUPER GLOBAL VARIABLE
         */
        if(!array_key_exists(0, $http_response_header)){
            Throw New \Exception("Key 0 not exists in http_response_header!",1);
        }
        preg_match('{HTTP\/\S*\s(\d{3})}', $http_response_header[0], $matches);
        if($matches===null){
             Throw New \Exception("HTTP code not found in http_response_header[0]!",1);
        }
        foreach($matches as $lp => $m){
            $responseCode=$m;
        }
        if($responseCode!=='200'){
            //BAD RESPONSE - ".$responseCode."!
            Throw New \Exception("Nieprawidłowy kod odpowiedzi z serwera Autos Active Directory! Złe hasło?",0);
        }
    }
    private function setResponse(){
        //echo __METHOD__."<br/>";
	$this->responseData = json_decode($this->requestResult);
        if(json_last_error()){
            Throw New \Exception(json_last_error_msg(),1);
        }
        //echo "Return:<br/><pre>";
        //print_r($this->responseData);
        //echo "</pre>";
    }
    private function checkResponseData(){
        foreach($this->checkProperty as $property){
            if(!property_exists($this->responseData, $property)){
                Throw New \Exception("Property `".$property."` not exists in responseData \r\n".serialize($this->responseData),1);
            }
        }
        
    }
}
