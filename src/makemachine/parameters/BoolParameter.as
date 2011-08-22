package makemachine.parameters
{
	import flash.events.Event;
	import flash.events.EventDispatcher;

	public class BoolParameter extends EventDispatcher
	{
		public function BoolParameter( paramName:String = '', startValue:Boolean = false )
		{
			_name = paramName;
			_value = startValue;
		}
		
		// -----------------------------------------------
		//
		//	-- properties
		//
		// -----------------------------------------------
		
		// -----------------------------------------------
		//	-- getter/setter
		// -----------------------------------------------
		
		protected var _name:String;
		public function get name():String { return _name; }
		
		protected var _value:Boolean;
		public function get value():Boolean { return _value; }
		public function set value( newValue:Boolean ):void 
		{
			if( _value != newValue )
			{
				_value = newValue;
				dispatchEvent( new Event( Event.CHANGE ) );
			}
		}
		
		// -------------------------------------------------------
		//
		//	-- public
		//
		// -------------------------------------------------------
		
		// -------------------------------------------------------
		//	-- overrides
		// -------------------------------------------------------
		
		override public function toString():String { return 'BoolParameter: ' + _name; }
	}
}