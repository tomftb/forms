<?php
//define('APP_ROOT',substr(filter_input(INPUT_SERVER,"DOCUMENT_ROOT"),0,-6));
define('HH',filter_input(INPUT_SERVER,"HTTP_HOST"));
define('APP_NAME',"Formularze autos.com.pl");
define('APP_TITLE',"Formularze Autos");
define('APP_PORT',80);
define('APP_URL','http://local.forms:'.APP_PORT);
define('TMP_UPLOAD_DIR',APP_ROOT.'/tmp_upload/');
define('UPLOAD_DIR',APP_ROOT.'/upload/');
define('UPLOAD_PROJECT_DOC_DIR',UPLOAD_DIR.'project_doc/');
define('UPLOAD_PROJECT_PDF_DIR',UPLOAD_DIR.'project_pdf/');
define('UPLOAD_PROJECT_IMG_DIR',UPLOAD_DIR.'project_img/');
define('UPLOAD_PROJECT_REPORT_DOC_DIR',UPLOAD_DIR.'project_report_doc/');
define('UPLOAD_PROJECT_REPORT_PDF_DIR',UPLOAD_DIR.'project_report_pdf/');
define('UPLOAD_PROJECT_REPORT_IMG_DIR',UPLOAD_DIR.'project_report_img/');
define('CDT',date('Y-m-d H:i:s'));
define('RA',filter_input(INPUT_SERVER,"REMOTE_ADDR"));
define('DR_PUBLIC',filter_input(INPUT_SERVER,"DOCUMENT_ROOT"));
define('APP_AUTHOR',"Autor: Tomasz Borczyński");
/*
	LOG LEVEL:
	0 = basic
	1 = advanced
	2 = extra
*/
define('LOG_LVL',2);