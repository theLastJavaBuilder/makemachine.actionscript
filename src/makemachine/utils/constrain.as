package makemachine.utils
{
	/**
	 * Constrains the supplied number between two values
	 */
	public function constrain( value:Number, min:Number, max:Number ):Number 
	{
		return Math.min( Math.max( value, min ), max );
	}
}