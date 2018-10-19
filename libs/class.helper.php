<?php
class Helper {
	/**
	 * [create_thumbnail_image description]
	 * @param  [type]  $image         [ruta imagen]
	 * @param  [type]  $destino       [destino imagen]
	 * @param  integer $desired_width [ancho relativo]
	 * @return [type]                 [null]
	 */
	public static function create_thumbnail_image($image, $destino, $desired_width = 120) {
    // print_r($image);

     $src_img = imagecreatefromjpeg($image);

     $width = imagesx($src_img);
     $height = imagesy($src_img);
     $desired_height = floor($height * ($desired_width / $width));
     $dest_img = imagecreatetruecolor($desired_width, $desired_height);
     imagecopyresampled($dest_img, $src_img, 0, 0, 0, 0, $desired_width, $desired_height, $width, $height);
     imagejpeg($dest_img, $destino, 100);
     imagedestroy($dest_img);
  }
	public static function makeThumbnails($updir, $img, $id) {
	    $thumbnail_width = 134;
	    $thumbnail_height = 189;
	    $thumb_beforeword = "thumb";
	    $arr_image_details = getimagesize("$updir" . $id . '_' . "$img"); // pass id to thumb name
	    $original_width = $arr_image_details[0];
	    $original_height = $arr_image_details[1];
	    if ($original_width > $original_height) {
	        $new_width = $thumbnail_width;
	        $new_height = intval($original_height * $new_width / $original_width);
	    } else {
	        $new_height = $thumbnail_height;
	        $new_width = intval($original_width * $new_height / $original_height);
	    }
	    $dest_x = intval(($thumbnail_width - $new_width) / 2);
	    $dest_y = intval(($thumbnail_height - $new_height) / 2);
	    if ($arr_image_details[2] == IMAGETYPE_GIF) {
	        $imgt = "ImageGIF";
	        $imgcreatefrom = "ImageCreateFromGIF";
	    }
	    if ($arr_image_details[2] == IMAGETYPE_JPEG) {
	        $imgt = "ImageJPEG";
	        $imgcreatefrom = "ImageCreateFromJPEG";
	    }
	    if ($arr_image_details[2] == IMAGETYPE_PNG) {
	        $imgt = "ImagePNG";
	        $imgcreatefrom = "ImageCreateFromPNG";
	    }
	    if ($imgt) {
	        $old_image = $imgcreatefrom("$updir" . $id . '_' . "$img");
	        $new_image = imagecreatetruecolor($thumbnail_width, $thumbnail_height);
	        imagecopyresized($new_image, $old_image, $dest_x, $dest_y, 0, 0, $new_width, $new_height, $original_width, $original_height);
	        $imgt($new_image, "$updir" . $id . '_' . "$thumb_beforeword" . "$img");
	    }
	}
}

 ?>