package makemachine.utils
{
	/**
	 * Prints a message to the console, caller is the object from which the message is printed
	 */
	public function print( caller:Object, message:Object ):void 
	{
		trace( 'print[ ' + String( caller ) + ' ] :: ' + String( message ) );
	}
}