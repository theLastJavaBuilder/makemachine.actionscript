package makemachine.utils
{
	/**
	 * Rounds to nearest whole integer
	 * Example roundToInt( 8, 5 ) // -- 10
	 * 		   roundToInt( 7, 5 ) // -- 5
	 */
	public function roundToInt( value:Number, round:int ):Number 
	{
		return round * Math.round( ( value / round ) );
	}
}