package makemachine.display.shapes
{
	import flash.display.*;
	import flash.geom.*;
	
	public class RectangleShape extends ShapeBase
	{
		// --type constants
		public static const REGULAR		:String = 'regular';
		public static const COMPLEX		:String = 'complex';
		public static const ROUNDED		:String = 'rounded';
		
		protected var cornerType:String;
		
		public function RectangleShape( container:DisplayObjectContainer = null, xpos:Number = 0, ypos:Number = 0  )
		{  
			super( container, xpos, ypos );
		}
		
		
		// ------------------------------------------------
		//
		//	-- properties
		//	
		// ------------------------------------------------
		
		// ------------------------------------------------
		//	-- getter/setter
		// ------------------------------------------------
		
		public function set corners( value:Object ):void 
		{
			if( value is Number ) {
				cornerRadius = Number( value );
				return;
			}
			
			if( value is Array ) {
				complexCorners = value as Array;
				return;
			}
		}
		
		// -- getter / setters
		protected var _cornerRadius:Number;
		public function get cornerRadius():Number { return _cornerRadius; }
		public function set cornerRadius( value:Number ):void 
		{
			if( value != _cornerRadius ) 
			{
				if( value > 0 ) {
					_cornerRadius = value;
					cornerType = RectangleShape.ROUNDED;
				} else {
					cornerType = RectangleShape.REGULAR;
				}
				invalidate();
			}
		}
		
		protected var _cornerRadii:Array;
		public function set complexCorners( value:Array ):void
		{
			if( value.length == 4 && value != _cornerRadii ) {
				_cornerRadii = value;
				cornerType  = RectangleShape.COMPLEX;
				invalidate();
			}
		}
		
		override public function toString():String { return 'RectangleShape' };
		
		// ------------------------------------------------
		//
		//  protected
		//
		// ------------------------------------------------
		
		// ------------------------------------------------	
		// -- methods
		// ------------------------------------------------
		
		protected function validateCornerType( value:String ):Boolean
		{
			return  value == REGULAR ||
				value == ROUNDED ||
				value == COMPLEX;
		}
		
		// ------------------------------------------------	
		// -- overrides
		// ------------------------------------------------
		
		override protected function create():void
		{
			super.create();
			
			_width = 100;
			_height = 100;
			_fillColor = 0xFF0000;
			
			_cornerRadius = 0;
			_cornerRadii = [ 5, 5, 5, 5 ];
			cornerType = RectangleShape.REGULAR;
		}
		
		override protected function draw():void
		{
			// -- super takes care of creating fills and linestyle
			super.draw();
			
			switch( cornerType )
			{
				case REGULAR :
					g.drawRect( 0, 0, _width, _height );
					break;
				
				case ROUNDED :
					g.drawRoundRect( 0, 0, _width, _height, _cornerRadius );
					break;
				
				case COMPLEX :
					g.drawRoundRectComplex( 0, 0, _width, _height, _cornerRadii[0]/2, _cornerRadii[1]/2, _cornerRadii[2]/2, _cornerRadii[3]/2 );
					break;	
			}
			
			g.endFill();
		}
		
		
		
		
	}
}