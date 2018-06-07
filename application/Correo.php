<?php

class Correo
{
    private $mail;
    public function __construct() {
        $this->mail = new PHPMailer();
        $this->mail->IsSMTP();
        // $this->mail->CharSet="UTF-8";
        // Activamos / Desactivamos el "debug" de SMTP 
        // 0 = Apagado 
        // 1 = Mensaje de Cliente 
        // 2 = Mensaje de Cliente y Servidor 
        $this->mail->SMTPDebug = 0;
        // Log del debug SMTP en formato HTML 
        $this->mail->Debugoutput = 'html';
        $this->mail->Host = 'email-smtp.us-west-2.amazonaws.com';
        // $this->mail->Host = 'smtp.gmail.com';
        $this->mail->SMTPAuth = true;
        $this->mail->Username = 'AKIAJ4CISRDL4GEUDMXA';
        // $this->mail->Username = 'pruebanombrea@gmail.com';
        $this->mail->Password = 'AqP5InJ8BqxcNu9yMvO02yOwiwpbr61aaRbV0h99PXxX';
        // $this->mail->Password = '1357902468@pna';
        $this->mail->SMTPSecure = 'tls'; //tls or ssl
        $this->mail->Port = 587; //587 or 465
    }

    public function enviar($forEmail, $forName, $Subject, $contenido, $fromName = "Proyecto PRIC"){
        
        $this->mail->Subject = $Subject;

        $this->mail->IsHTML(true);
        $this->mail->Body    = $contenido;

        $this->mail->SetFrom('jhonmartinez888@gmail.com', $fromName);
        // $this->mail->FromName = 'Jhon Martinez - PRIC';
        $this->mail->AddAddress($forEmail, $forName);
        // $this->mail->AddReplyTo('phoenixd110@gmail.com', 'Information');
        // $this->mail->AltBody    = "AltBody - Poner tituloS";
        return $this->mail->send();
        // if($this->mail->send()) {
        //     echo 'Correo Enviado';
        //     } else {
        //     echo 'Error al enviar correo' . $this->mail->ErrorInfo;
        // }
    }
}



?>


