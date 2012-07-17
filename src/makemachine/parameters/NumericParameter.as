package makemachine.parameters
{
	import flash.events.Event;
	import flash.events.EventDispatcher;
	
	import makemachine.utils.*;
	
	/**
	 * A Parameter represents a single numerical value, it can be given a name and min & max values
	 */
	public class NumericParameter extends EventDispatcher
	{
		public function NumericParameter( paramName:String, minimum:Number, maximum:Number, initial:Number )
		{
			_name = paramName;
			_min = minimum;
			_max = maximum;
			_units = '';
			_patch = new Patch( this );
			
			value = initial;
		}
		
		// -------------------------------------------------------
		//
		//	-- properties
		//
		// -------------------------------------------------------
		
		// -------------------------------------------------------
		//	-- getter/setter
		// -------------------------------------------------------
		
		protected var _name:String;
		public function get name():String { return _name; }
		public function set name( newName:String ):void 
		{
			if( _name != newName )
			{
				_name = newName;
				dispatchEvent( new Event( Event.CHANGE ) );
			}
		}
		
		protected var _value:Number;
		public function get value():Number { return _value; }
		public function set value( newValue:Number ):void 
		{
			_value = constrain( newValue, _min, _max );
			dispatchEvent( new Event( Event.CHANGE ) );
		}
		
		protected var _min:Number;
		public function get min():Number { return _min; }
		public function set min( newMin:Number ):void
		{
			if( _min != newMin )
			{
				_min = newMin;
				correct();
				dispatchEvent( new Event( Event.CHANGE ) );
			}
		}
		
		protected var _max:Number;
		public function get max():Number { return _max; }
		public function set max( newMax:Number ):void
		{
			if( _max != newMax )
			{
				_max = newMax;
				correct();
				dispatchEvent( new Event( Event.CHANGE ) );
			}
		}
		
		public function get normalizedValue():Number { return normalize( _value, _min, _max ); }
		
		protected var _patch:Patch;
		public function get patch():Patch { return _patch; }
		
		protected var _units:String;
		public function get units():String { return _units; }
		public function set units( newUnits:String ):void 
		{
			if( newUnits != _units )
			{
				_units = newUnits;
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
		
		override public function toString():String { return 'Parameter: ' + _name; }
		
		// -------------------------------------------------------
		//
		//	-- protected
		//
		// -------------------------------------------------------
		
		// -------------------------------------------------------
		//	-- methods
		// -------------------------------------------------------
		
		protected function correct():void 
		{
			if( _min > _max )
			{
				var n:Number;
				n = _min;
				_min = _max;
				_max = n;
				value = _value;
			}
		}
	}
}