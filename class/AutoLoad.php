<?php
/*
 * APP_ROOT => filter_input(INPUT_SERVER,"DOCUMENT_ROOT")."/..";
 */

//namespace Autoload;

/*
 * NEW CLASS VERSION OF Autoload
 */
class Autoload{
    private static ?array $dir=[
        'app_pages/'
        ,'class/'
        ,'model/'
        ,'modul/'
        ,'lib/'
        ,'controller/'
        ];
    private static ?array $class=[
        'fullname'=>'',
        'dir'=>[],
        'name'=>'',
        'src'=>'',
        'load'=>'throwError'
    ];    
    private function __construct(){
        
    }
    static public function load(string $load=''):void{
        //echo "[".__METHOD__."]";
        //echo " Load - ".$load."<br/>";
        self::$class['fullname']=$load;
        self::$class['dir']=explode('\\',$load);
        self::$class['name']=end(self::$class['dir']);
        /*
         * Remove last array element - class to load
         */
        array_pop(self::$class['dir']);       
        self::search();
        self::{self::$class['load']}(); 
    }
    static private function search():void{
        (string)$classDir=self::getClassDir();
        foreach(self::$dir as $d){
            //echo __METHOD__." ".APP_ROOT.$d.$classDir."\r\n";
            if(self::check(APP_ROOT.$d.$classDir)){      
                break;
            }
        }
    }
    static private function check(string $dir=''):bool{
        //echo __METHOD__."\r\n";
        //echo "DIR - ".$dir."\r\n";
        //echo "name - ".self::$class['name']."\r\n";
        //echo "full - ".$dir.self::$class['name'].".php\r\n";
        if(!is_dir($dir)){
            //echo "not a dir - ".$dir."\r\n";
            return false;
        }
        if(!file_exists($dir.self::$class['name'].'.php')){
            //echo "fie not exists - ".$dir.self::$class['name'].".php\r\n";
            return false;      
        }
        if(!is_readable($dir.self::$class['name'].'.php')){
            //echo "fie not readable - ".$dir.self::$class['name'].".php\r\n";
            Throw New \Exception ('Class file `'.$dir.self::$class['name'].'.php'.'` not readable!');
        }
        self::$class['src']=$dir.self::$class['name'].'.php';
        self::$class['load']='loadFile';
        return true;
    }
    static private function getClassDir():string{
        (string) $tmp='';
        (string) $first='';
        (string) $last='/';
        foreach(self::$class['dir'] as $d){
            $tmp.=$first.$d.$last;
            $first="/";
            $last="";
        }
        return $tmp;
    }
    static private function throwError(){
        Throw New \Exception ('Class `'.self::$class['fullname'].'` not found!');
    }
    static private function loadFile(){
        require_once(self::$class['src']);
    }
    private function __destruct(){
        
    }
}
class Autoload2{
    private static ?array $dir=[
        'app_pages/'
        ,'class/'
        ,'model/'
        ,'modul/'
        ,'lib/'
        ,'controller/'
        //,'vendor/'
        ];
    private static ?string $found='';
    private static ?string $class='';
    private static ?string $run='noClass';
    
    static public function load(string $load=''):void{
        //echo "[".__METHOD__."]";
        //echo " Load - ".$load."<br/>";
        $partClassName=explode('\\',$load);
        self::$class=end($partClassName);
        self::$found='';
        self::$run='noClass';
        //echo 'CLASS TO LOAD => '.$className."<br/>";
        foreach(self::$dir as $dirName){
            //echo " dir - ".$dirName."<br/>";
            self::searchInDir(APP_ROOT.'/'.$dirName);//
            if(self::$found!==''){
                break;
            }
        }
        call_user_func('Autoload2::'.self::$run);
    }
    private static function searchInDir($d){//$f,&$found
        //echo "LOOK FOR => ".$f."\r\n";
        if(is_dir($d)){
            //echo "IS A DIR ".$d." \r\n";
            foreach (scandir($d) as $dirFile){
                if($dirFile!=='.' && $dirFile!=='..'){
                    //echo 'DIR HAVE FILES => '.$dirFile.'<br/>';
                    self::searchInDir($d.'/'.$dirFile);//$f,,$found
                }
            }
        }
        else {
            self::compareFile($d);//,$f,$found
        }
    }
    private static function compareFile($d){//,$f,&$found
        //echo "NOT A DIR => ".$d."\r\n";
        //echo "LOOK FOR CLASS => ".$f."\r\n";
        $tmpDirParts=explode('/',$d);
        array_pop($tmpDirParts);
        array_push($tmpDirParts,self::$class.".php");
        $newF=implode('/',$tmpDirParts);

        //echo "NEW FILE => ".$newF."\r\n";
        // TURN OF && !class_exists($f, false)
        if($d===$newF && is_readable($newF)){
            //echo "FOUND FILE, RETURN => ".$d."<br/>";
            self::$found=$d;
            self::$run='loadClass';
        }
    }
    private static function loadClass():void{
         require(self::$found);
    }
    private static function noClass():void{
        throw new \Exception('Class cannot be found ( ' . self::$class . ' )');
    }
}
/*
 * OLD Function VERSION
 */
function Autoload($className){

    $dir=[
        'app_pages/'
        ,'class/'
        ,'model/'
        ,'modul/'
        ,'lib/'
        ,'controller/'
        ];
    /*
	EXPLODE className - namespace for example Person\Barnes\David to class David
    */
    //echo "<pre>";
    //print_r($className);
    //echo "</pre>";
    $partClassName=explode('\\',$className);
    $class=end($partClassName);
    $found='';
    //echo 'CLASS TO LOAD => '.$className."<br/>";
    foreach($dir as $dirName){
        searchInDir(APP_ROOT.'/'.$dirName,$class,$found);
        if($found!==''){
            //echo "FILE => ".$found."<br/>";
            break;
        }
    }
    if($found!==''){
	//echo "LOAD => REQUIRE => ".$found."<br/>";
        require($found);
    }
    else{
        throw new Exception('Class cannot be found ( ' . $className . ' )');
    }
}
function searchInDir($d,$f,&$found){
    //echo "LOOK FOR => ".$f."\r\n";
    if(is_dir($d)){
        //echo "IS A DIR ".$d." \r\n";
        foreach (scandir($d) as $dirFile){
            if($dirFile!=='.' && $dirFile!=='..'){
                //echo 'DIR HAVE FILES => '.$dirFile.'<br/>';
                searchInDir($d.'/'.$dirFile,$f,$found);
            }
        }
    }
    else {
        compareFile($d,$f,$found);
    }
}
function compareFile($d,$f,&$found){
    //echo "NOT A DIR => ".$d."\r\n";
    //echo "LOOK FOR CLASS => ".$f."\r\n";
    $tmpDirParts=explode('/',$d);
    array_pop($tmpDirParts);
    array_push($tmpDirParts,$f.".php");
    $newF=implode('/',$tmpDirParts);
    
    //echo "NEW FILE => ".$newF."\r\n";
    // TURN OF && !class_exists($f, false)
    if($d===$newF && is_readable($newF)){
        //echo "FOUND FILE, RETURN => ".$d."<br/>";
        $found=$d;
    }
}
//spl_autoload_register('Autoload');
//echo __NAMESPACE__."<br/>";
//spl_autoload_register(__NAMESPACE__ .'\Autoload::load');
//spl_autoload_register('\Autoload::load');//
spl_autoload_register('\Autoload2::load');