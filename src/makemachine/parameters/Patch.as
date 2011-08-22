package makemachine.parameters
{
	/**
	 * 
	 */
	public class Patch implements IGenerator
	{
		public static const OP_ADD_AND_MULTIPLY:int = 1;
		public static const OP_SUBTRACT_AND_MULTIPLY:int = 2;
		public static const OP_MULTIPLY:int = 3;
		
		public function Patch( param:Parameter )
		{
			parameter = param;
			position = -1; 
			value = -1;
		}
		
		private var position:int;
		private var value:Number;
		
		protected var generator:IGenerator;
		protected var parameter:Parameter;
		
		protected var _generatorOperation:int;
		public function set polarity( value:int ):void 
		{
			_generatorOperation = value;
		}
		
		public function get hasCarrier():Boolean { return !( generator == null ); }
		public function connect( gen:IGenerator, polarity:int = OP_ADD_AND_MULTIPLY ):void
		{
			generator = gen;
			_generatorOperation = polarity;
		}
		
		public function generate( bufferPosition:int ):Number 
		{
			if( generator )
			{
				if( position != bufferPosition )
				{
					var genValue:Number = generator.generate( bufferPosition );
					var parameterValue:Number = parameter.value;
					
					switch( _generatorOperation )
					{
						case OP_ADD_AND_MULTIPLY:
							value = parameterValue + ( parameterValue * genValue );
							break;
							
						case OP_SUBTRACT_AND_MULTIPLY:
							value = parameterValue - ( parameterValue * genValue );
							break;
							
						case OP_MULTIPLY:
							value = parameterValue * genValue;
							break;
						
						default:
							value = parameter.value;
							break;
					}
				}
				return value;
			} else {
				return parameter.value;
			}
		}
		
		public function reset():void 
		{
			value = -1;
			position = -1;
			
			if( generator )
			{
				generator.reset();
			}
		}
	}
}