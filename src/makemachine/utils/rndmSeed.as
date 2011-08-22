package makemachine.utils
{
	/**
	 * Generates the same random number base on the provided seed value
	 */
	public function rndmSeed( seed:Number = 0 ):Number
	{
		seed = (seed * 9301 + 49297) % 233280;
		return seed / 233280;
	}
}