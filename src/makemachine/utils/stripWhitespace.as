package makemachine.utils
{
	/**
	 * Strips tabs, newlines and multiple spaces from a string and replaces them with a single empty space
	 */
	public function stripWhitespace( string:String ):String 
	{
		var whitespace:RegExp = /(\t|\n|\s{2,})/g;
		string = string.replace( whitespace, ' ' );
		return string;
	}
}