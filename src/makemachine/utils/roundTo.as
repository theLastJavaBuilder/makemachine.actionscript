package makemachine.utils
{
	/**
	 * Rounds a number to the specified number of decimal points
	 */
	public function roundTo( num:Number, dec:int ):Number
	{
		return Math.round( num * Math.pow( 10, dec ) ) / Math.pow( 10, dec );
	}
}