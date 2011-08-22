package makemachine.utils
{
	/**
	 * Replaces all instances of the search key with the replacement parameter
	 */
	public function replace( string:String, search:String, replacement:String ):String
	{
		var pattern:RegExp = new RegExp( search, 'gi' );
		return string.replace( pattern, replacement );
	}
}