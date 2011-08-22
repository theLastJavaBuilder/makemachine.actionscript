package makemachine.utils
{
	/**
	 * Randomizes the elements of an array
	 */
	public function shuffle( array:Array ):Array
	{
		var result:Array = new Array();
		var clone:Array = array.slice();
		
		while ( clone.length > 0 )
		{
			var r:uint = Math.floor( Math.random()* clone.length );
			result.push( clone.splice( r, 1) );
		}
		return result;
	}
}