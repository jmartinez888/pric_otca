<?php

namespace App;
use Illuminate\Database\Capsule\Manager as DB;
use Illuminate\Database\Eloquent\Model as Eloquent;

class LeccionSessionLinkVideo extends Eloquent
{
  protected $table = 'leccion_session_link_video';
  protected $primaryKey = 'Lsl_IdLeccSesLV';
  const CREATED_AT = 'Lsl_CreatedAt';
  const UPDATED_AT = 'Lsl_UpdatedAt';

  public static function getByLeccionSessionID ($session_id) {
    return self::where('Les_IdLeccSess', $session_id)->get();
  }
}

?>