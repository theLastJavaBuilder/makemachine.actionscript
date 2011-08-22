package makemachine.utils
{
	public function titleCase( string:String, global:Boolean ):String
	{
		var upper:Function = function( char:String, ...args ):String
		{
			return char.toUpperCase();
		}
		
		if( global )
		{
			return string.replace(/^.|\b./g, upper );	
		} else {
			return string.replace(/(^\w)/, upper );
		}
	}
}