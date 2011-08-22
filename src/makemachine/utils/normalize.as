package makemachine.utils
{
	/**
	 * Normalizes a value between min and max
	 */
	public function normalize( value:Number, min:Number, max:Number ):Number 
	{
		return ( value - min ) / ( max - min );
	}
}