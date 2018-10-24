<?php

/*
 * -------------------------------------
 * www.dlancedu.com | Jaisiel Delance
 * framework mvc basico
 * Database.php
 * -------------------------------------
 */

use Illuminate\Database\Capsule\Manager as Capsule;
// use Illuminate\Events\Dispatcher;
// use Illuminate\Container\Container;
class Database extends PDO
{
    public function __construct() {
        parent::__construct(
                'mysql:host=' . DB_HOST .
                ';dbname=' . DB_NAME,
                DB_USER,
                DB_PASS,
                array(
                    PDO::MYSQL_ATTR_INIT_COMMAND => 'SET NAMES ' . DB_CHAR. ', sql_mode="NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_AUTO_CREATE_USER,NO_ENGINE_SUBSTITUTION" '
                    ));



        $capsule = new Capsule();

        $capsule->addConnection([
            'driver'    => 'mysql',
            'host'      => DB_HOST,
            'database'  => DB_NAME,
            'username'  => DB_USER,
            'password'  => DB_PASS,
            'charset'   => DB_CHAR,
            'collation' => 'utf8_general_ci',
            'prefix'    => '',
        ]);


        // // $capsule->setEventDispatcher(new Dispatcher(new Container));

        // Make this Capsule instance available globally via static methods... (optional)
        $capsule->setAsGlobal();

        // Setup the Eloquent ORM... (optional; unless you've used setEventDispatcher())
        $capsule->bootEloquent();



    }
}


?>
