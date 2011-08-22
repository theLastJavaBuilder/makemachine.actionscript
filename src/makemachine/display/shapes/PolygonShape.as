package makemachine.display.shapes
{
	import flash.display.*;
	import flash.geom.*;
	
	public class PolygonShape extends ShapeBase
	{
		public function PolygonShape( container:DisplayObjectContainer=null, xpos:Number=0, ypos:Number=0 )
		{
			super( container, xpos, ypos );
		}
		
		// ------------------------------------------------
		//
		//	-- properties
		//
		// ------------------------------------------------
		
		// -----------------------------------------------
		//	-- getter/setter
		// -----------------------------------------------
		
		protected var _radius:Number;
		public function set radius( n:Number ):void 
		{
			if( n > 0 && n != _radius ) 
			{
				_radius = n;
				_width = _height = _radius * 2;
				invalidate();
			}
		}
		
		protected var _sides:int;
		public function set sides( n:int ):void 
		{
			if( n != _sides && n > 2 ) 
			{
				_sides = n;
				invalidate();
			}
		} 
		
		protected var _startAngle:Number;
		public function set startAngle( n:Number ):void 
		{
			if( n != _startAngle ) 
			{
				_startAngle = n;
				invalidate();
			}
		}
		
		// ------------------------------------------------	
		// -- methods
		// ------------------------------------------------
		
		override public function toString():String { return 'PolygonShape'; }
		
		// ------------------------------------------------	
		//
		// -- protected
		//
		// ------------------------------------------------
		
		// ------------------------------------------------	
		// -- overrides
		// ------------------------------------------------
		
		override protected function create():void 
		{
			super.create();
			
			_sides = 6;
			_radius = 50;
			_startAngle = 0;
			_width = _height = _radius * 2;
		}
		
		override protected function draw():void
		{
			super.draw();
			
			var start:Point;
			var xpos:Number = 0;
			var ypos:Number = 0;
			var radius:Number = 0;
			var degrees:Number = 360 / _sides;
			var angle:Number = _startAngle;
			
			for( var j:int = 0; j <= _sides; j++ ) 
			{
				xpos = ( Math.cos( Math.PI * angle / 180 ) * ( _radius ) );
				ypos = ( Math.sin( Math.PI * angle / 180 ) * ( _radius ) );
				
				if( j == 0 ) 
				{
					start = new Point( xpos, ypos );
					g.moveTo( xpos, ypos );
				} else {
					g.lineTo( xpos, ypos );
					if( j == _sides  ) 
					{
						g.lineTo( start.x, start.y ); 
					}
				}
				
				angle += degrees;
			}
			
			shape.x = shape.y = _radius;
		}
	}
}