package makemachine.utils
{
	import flash.display.*;
	import flash.geom.*;
	
	/**
	 * 
	 */
	public function trimAlphaChannel( original:Bitmap ):Bitmap 
	{		
		var test:Rectangle = original.bitmapData.getColorBoundsRect( 0xFF000000, 0x00000000, false );
		var copy:BitmapData = new BitmapData( test.width, test.height );
		copy.copyPixels( original.bitmapData, test, new Point( 0, 0 ) );
		return new Bitmap( copy );
	}
}