# forms
- extension=gd
- require composer require laminas/laminas-escaper
- require composer require phpoffice/phpspreadsheet
- composer install

## DATABASE

- name forms
- user forms
- password 
- host 127.0.0.1 (for sql views)

## REQUIREMENTS

- PHP ldap extensions
- Create directory ./upload/project_doc/
- Create directory ./upload/project_pdf/
- Create directory ./upload/filled_form_excel/

## Application

- user tborczynski
- password admin1234 (PASSWORD_BCRYPT)
- set proper APP_URL constant in .cfg/consts.php