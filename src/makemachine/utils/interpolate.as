package makemachine.utils
{
	/**
	 * Interpolates a normalized value within the range of the supplied min and max values
	 */
	public function interpolate( n:Number, min:Number, max:Number ):Number 
	{
		return min + ( ( max - min ) * n ); 
	}
}