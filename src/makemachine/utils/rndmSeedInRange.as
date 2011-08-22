package makemachine.utils
{
	/**
	 * Generates the same random number between the min and max paramters
	 */
	public function rndmSeedInRange( seed:Number, min:Number, max:Number ):Number
	{
		var dif:Number = max - min + 1;
		var num:Number = rndmSeed( seed );
		return min + ( dif * num );
	}
}