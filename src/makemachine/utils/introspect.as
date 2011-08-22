package makemachine.utils
{
	import flash.utils.describeType;
	
	/**
	 * Prints all read and read-write properties of an object to console
	 */
	public function introspect( caller:Object, obj:Object ):void
	{
		var prop:String;
		var access:String;
		var desc:XML = describeType( obj );
		
		if ( obj == null ) { 
			print( 'introspect', 'object is null ' ); 
			return;
		}
		
		print( caller + ': instrospect', obj );
		
		for each( var a:XML in desc.accessor )
		{
			prop = String( a.@name )
			access = String( a.@access );
			if ( obj.hasOwnProperty( prop ) ) 
			{
				if( access == 'readwrite' || access == 'readonly' )
				{
					print( String( caller ), String( obj ) + '.' + prop  + ' = ' + obj[ prop ] );
				} else {
					print( String( caller ), 'ERROR - property: ' + prop + ' is ' + access );
				}
			}
		}
		
		for each( var v:XML in desc.variable )
		{
			prop = String( v.@name );
			if( obj.hasOwnProperty( prop ) )
			{
				print( String( caller ), String( obj ) + '.' + prop  + ' = ' + obj[ prop ] );
			}
		}
	}
}