<?php

class Correo
{
    private $mail;

    private $lang;
    private $base_url;

    public function __construct() {
        $this->mail = new PHPMailer();
        $this->mail->CharSet = 'UTF-8';
        $this->mail->Encoding = 'base64';
        $this->mail->IsSMTP();
        // $this->mail->CharSet="UTF-8";
        // Activamos / Desactivamos el "debug" de SMTP 
        // 0 = Apagado 
        // 1 = Mensaje de Cliente 
        // 2 = Mensaje de Cliente y Servidor 
        $this->mail->SMTPDebug = 0;
        // Log del debug SMTP en formato HTML 
        $this->mail->Debugoutput = 'html';
        // $this->mail->Host = 'email-smtp.us-west-2.amazonaws.com';
        $this->mail->Host = 'smtp.sendgrid.net';
        $this->mail->SMTPAuth = true;
        // $this->mail->Username = 'AKIAJ4CISRDL4GEUDMXA';
        $this->mail->Username = 'apikey';
        // $this->mail->Password = 'AqP5InJ8BqxcNu9yMvO02yOwiwpbr61aaRbV0h99PXxX';
        $this->mail->Password = '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';
        $this->mail->SMTPSecure = 'tls'; //tls or ssl
        $this->mail->Port = 587; //587 or 465

        // // Instantiate a new PHPMailer 
        // $this->mail = new PHPMailer();

        // // Tell PHPMailer to use SMTP
        // $this->mail->isSMTP();
        // // Specify a configuration set. If you do not want to use a configuration
        // // set, comment or remove the next line.
        // $this->mail->addCustomHeader('X-SES-CONFIGURATION-SET', 'ConfigSet');         
        // // If you're using Amazon SES in a region other than US West (Oregon), 
        // // replace email-smtp.us-west-2.amazonaws.com with the Amazon SES SMTP  
        // // endpoint in the appropriate region.
        // $this->mail->Host = 'email-smtp.us-west-2.amazonaws.com';
        // // Tells PHPMailer to use SMTP authentication
        // $this->mail->SMTPAuth = true;
        // // Replace smtp_username with your Amazon SES SMTP user name.
        // $this->mail->Username = 'AKIAJ4CISRDL4GEUDMXA';
        // // Replace smtp_password with your Amazon SES SMTP password.
        // $this->mail->Password = 'AqP5InJ8BqxcNu9yMvO02yOwiwpbr61aaRbV0h99PXxX';
        // // Enable TLS encryption over port 587
        // $this->mail->SMTPSecure = 'tls';
        // $this->mail->Port = 587;

        $this->lang=Cookie::lenguaje();
        $this->base_url=BASE_URL;

    }

    public function enviar($forEmail, $forName, $Subject, $contenido, $fromName = "Proyecto PRIC",$fromEmail='noreply@atixw.com'){
        
        $this->mail->Subject ="=?ISO-8859-1?B?".base64_encode(utf8_decode($Subject))."=?="; 

        $this->mail->IsHTML(true);
        //$this->mail->MsgHTML = $this->body_html($contenido);
        //$this->mail->AltBody = $this->body_html($contenido);
        $this->mail->Body   = $this->body_html($contenido);
     

        $this->mail->SetFrom($fromEmail, $fromName);
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

    private function body_html($contenido){
        $html_body="
                    <center>
                    <table align='center' border='0' cellpadding='0' cellspacing='0' height='100%' width='100%' id='bodyTable' style='border-collapse: collapse;mso-table-lspace: 0pt;mso-table-rspace: 0pt;-ms-text-size-adjust: 100%;-webkit-text-size-adjust: 100%;height: 100%;margin: 0;padding: 0;width: 100%;background-color: #FAFAFA;'>
                        <tbody>
                            <tr>
                                <td align='center' valign='top' id='bodyCell' style='mso-line-height-rule: exactly;-ms-text-size-adjust: 100%;-webkit-text-size-adjust: 100%;height: 100%;margin: 0;padding: 10px;width: 100%;border-top: 0;'>
                                    <!-- BEGIN TEMPLATE // -->
                                    <!--[if (gte mso 9)|(IE)]>
                                    <table align='center' border='0' cellspacing='0' cellpadding='0' width='600' style='width:600px;'>
                                        <tr>
                                            <td align='center' valign='top' width='600' style='width:600px;'>
                                                <![endif]-->
                                                <table border='0' cellpadding='0' cellspacing='0' width='100%' class='templateContainer' style='border-collapse: collapse;mso-table-lspace: 0pt;mso-table-rspace: 0pt;-ms-text-size-adjust: 100%;-webkit-text-size-adjust: 100%;border: 0;max-width: 600px !important;'>
                                                    <tbody><tr>
                                                        <td valign='top' id='templatePreheader' style='background:#FAFAFA none no-repeat center/cover;mso-line-height-rule: exactly;-ms-text-size-adjust: 100%;-webkit-text-size-adjust: 100%;background-color: #FAFAFA;background-image: none;background-repeat: no-repeat;background-position: center;background-size: cover;border-top: 0;border-bottom: 0;padding-top: 9px;padding-bottom: 9px;'></td>
                                                    </tr>
                                                    <tr>
                                                        <td valign='top' id='templateHeader' style='background:#FFFFFF none no-repeat center/cover;mso-line-height-rule: exactly;-ms-text-size-adjust: 100%;-webkit-text-size-adjust: 100%;background-color: #FFFFFF;background-image: none;background-repeat: no-repeat;background-position: center;background-size: cover;border-top: 0;border-bottom: 0;padding-top: 9px;padding-bottom: 0;'><table border='0' cellpadding='0' cellspacing='0' width='100%' class='mcnImageBlock' style='min-width: 100%;border-collapse: collapse;mso-table-lspace: 0pt;mso-table-rspace: 0pt;-ms-text-size-adjust: 100%;-webkit-text-size-adjust: 100%;'>
                                                            <tbody class='mcnImageBlockOuter'>
                                                                <tr>
                                                                    <td valign='top' style='padding: 9px;mso-line-height-rule: exactly;-ms-text-size-adjust: 100%;-webkit-text-size-adjust: 100%;' class='mcnImageBlockInner'>
                                                                        <table align='left' width='100%' border='0' cellpadding='0' cellspacing='0' class='mcnImageContentContainer' style='min-width: 100%;border-collapse: collapse;mso-table-lspace: 0pt;mso-table-rspace: 0pt;-ms-text-size-adjust: 100%;-webkit-text-size-adjust: 100%;'>
                                                                            <tbody><tr>
                                                                                <td class='mcnImageContent' valign='top' style='padding-right: 9px;padding-left: 9px;padding-top: 0;padding-bottom: 0;text-align: center;mso-line-height-rule: exactly;-ms-text-size-adjust: 100%;-webkit-text-size-adjust: 100%;'>
                                                                                    
                                                                                    <img align='center' alt='' src='#url_img#' width='564' style='max-width: 700px;padding-bottom: 0;display: inline !important;vertical-align: bottom;border: 0;height: auto;outline: none;text-decoration: none;-ms-interpolation-mode: bicubic;' class='mcnImage'>
                                                                                </td>
                                                                            </tr>
                                                                        </tbody></table>
                                                                    </td>
                                                                </tr>
                                                            </tbody>
                                                        </table><table border='0' cellpadding='0' cellspacing='0' width='100%' class='mcnDividerBlock' style='min-width: 100%;border-collapse: collapse;mso-table-lspace: 0pt;mso-table-rspace: 0pt;-ms-text-size-adjust: 100%;-webkit-text-size-adjust: 100%;table-layout: fixed !important;'>
                                                        <tbody class='mcnDividerBlockOuter'>
                                                            <tr>
                                                                <td class='mcnDividerBlockInner' style='min-width: 100%;padding: 18px;mso-line-height-rule: exactly;-ms-text-size-adjust: 100%;-webkit-text-size-adjust: 100%;'>
                                                                    <table class='mcnDividerContent' border='0' cellpadding='0' cellspacing='0' width='100%' style='min-width: 100%;border-top: 2px solid #EAEAEA;border-collapse: collapse;mso-table-lspace: 0pt;mso-table-rspace: 0pt;-ms-text-size-adjust: 100%;-webkit-text-size-adjust: 100%;'>
                                                                        <tbody><tr>
                                                                            <td style='mso-line-height-rule: exactly;-ms-text-size-adjust: 100%;-webkit-text-size-adjust: 100%;'>
                                                                                <span></span>
                                                                            </td>
                                                                        </tr>
                                                                    </tbody></table>
                                                                    <!--
                                                                    <td class='mcnDividerBlockInner' style='padding: 18px;'>
                                                                        <hr class='mcnDividerContent' style='border-bottom-color:none; border-left-color:none; border-right-color:none; border-bottom-width:0; border-left-width:0; border-right-width:0; margin-top:0; margin-right:0; margin-bottom:0; margin-left:0;' />
                                                                        -->
                                                                    </td>
                                                                </tr>
                                                            </tbody>
                                                        </table></td>
                                                    </tr>
                                                    <tr>
                                                        <td valign='top' id='templateBody' style='background:#FFFFFF none no-repeat center/cover;mso-line-height-rule: exactly;-ms-text-size-adjust: 100%;-webkit-text-size-adjust: 100%;background-color: #FFFFFF;background-image: none;background-repeat: no-repeat;background-position: center;background-size: cover;border-top: 0;border-bottom: 2px solid #EAEAEA;padding-top: 0;padding-bottom: 9px;'><table border='0' cellpadding='0' cellspacing='0' width='100%' class='mcnTextBlock' style='min-width: 100%;border-collapse: collapse;mso-table-lspace: 0pt;mso-table-rspace: 0pt;-ms-text-size-adjust: 100%;-webkit-text-size-adjust: 100%;'>
                                                            <tbody class='mcnTextBlockOuter'>
                                                                <tr>
                                                                    <td valign='top' class='mcnTextBlockInner' style='padding-top: 9px;mso-line-height-rule: exactly;-ms-text-size-adjust: 100%;-webkit-text-size-adjust: 100%;'>
                                                                        <!--[if mso]>
                                                                        <table align='left' border='0' cellspacing='0' cellpadding='0' width='100%' style='width:100%;'>
                                                                            <tr>
                                                                                <![endif]-->
                                                                                
                                                                                <!--[if mso]>
                                                                                <td valign='top' width='600' style='width:600px;'>
                                                                                    <![endif]-->
                                                                                    <table align='left' border='0' cellpadding='0' cellspacing='0' style='max-width: 100%;min-width: 100%;border-collapse: collapse;mso-table-lspace: 0pt;mso-table-rspace: 0pt;-ms-text-size-adjust: 100%;-webkit-text-size-adjust: 100%;' width='100%' class='mcnTextContentContainer'>
                                                                                        <tbody><tr>
                                                                                            
                                                                                            <td valign='top' class='mcnTextContent' style='padding-top: 0;padding-right: 18px;padding-bottom: 9px;padding-left: 18px;mso-line-height-rule: exactly;-ms-text-size-adjust: 100%;-webkit-text-size-adjust: 100%;word-break: break-word;color: #202020;font-family: Helvetica;font-size: 16px;line-height: 150%;text-align: left;'>                                                                            
                                                                                                #contenido#
                                                                                            </td>
                                                                                        </tr>
                                                                                    </tbody></table>
                                                                                    <!--[if mso]>
                                                                                </td>
                                                                                <![endif]-->
                                                                                
                                                                                <!--[if mso]>
                                                                            </tr>
                                                                        </table>
                                                                        <![endif]-->
                                                                    </td>
                                                                </tr>
                                                            </tbody>
                                                        </table></td>
                                                    </tr>
                                                    <tr>
                                                        <td valign='top' id='templateFooter' style='background:#FAFAFA none no-repeat center/cover;mso-line-height-rule: exactly;-ms-text-size-adjust: 100%;-webkit-text-size-adjust: 100%;background-color: #FAFAFA;background-image: none;background-repeat: no-repeat;background-position: center;background-size: cover;border-top: 0;border-bottom: 0;padding-top: 9px;padding-bottom: 9px;'></td>
                                                    </tr>
                                                </tbody></table>
                                                <!--[if (gte mso 9)|(IE)]>
                                            </td>
                                        </tr>
                                    </table>
                                    <![endif]-->
                                    <!-- // END TEMPLATE -->
                                </td>
                            </tr>
                        </tbody>
                    </table>
                    </center>
                    ";
        $html_body = str_replace("#url_img#",$this->base_url."public/img/cabecera_email_es.jpg",$html_body);
        $html_body = str_replace("#contenido#",$contenido,$html_body);

        return $html_body;

    }
}



?>


