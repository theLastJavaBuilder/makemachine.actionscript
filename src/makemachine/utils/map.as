package makemachine.utils
{
	/**
	 * Maps the first parameter from the first range ( min1, max1 ) to value within the second range ( min2, max2 )
	 */
	public function map( value:Number, min1:Number, max1:Number, min2:Number, max2:Number ):Number 
	{
		return interpolate( normalize( value, min1, max1 ), min2, max2 );
	}
}