<?php

namespace App;

use Illuminate\Database\Eloquent\Model as Eloquent;
use Illuminate\Database\Capsule\Manager as DB;

class ODifusionBanners extends Eloquent
{
  protected $table = 'ora_difusion_banner';
  protected $primaryKey = 'ODib_IdDifBanner';

  const CREATED_AT = 'ODib_CreatedAt';
  const UPDATED_AT = 'ODib_UpdatedAt';

  public function difusion () {
    return $this->belongsTo('App\ODifusion', 'ODif_IdDifusion');
  }

}
