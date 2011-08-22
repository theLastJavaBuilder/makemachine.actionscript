package makemachine.utils
{
	/**
	 * Validates that the supplied string conforms to e-mail formatting
	 */
	public function validateEmail( value:String ):Boolean
	{
		var pattern:RegExp = /(\w|[_.\-])+@((\w|-)+\.)+\w{2,4}+/;
		return pattern.exec( value );
	}
}