package makemachine.display.shapes
{
	import flash.display.*;
	import flash.geom.Point;
	
	public class WedgeShape extends ShapeBase
	{
		public function WedgeShape( container:DisplayObjectContainer = null, xpos:Number = 0, ypos:Number = 0 )
		{
			super( container, xpos, ypos );
		}
		
		// -----------------------------------------------
		//
		//	-- properties
		//
		// -----------------------------------------------
		
		protected var radius:Number;
		
		// -----------------------------------------------
		//	-- getter/setter
		// -----------------------------------------------
		
		protected var _angle:Number;
		public function get angle():Number { return _angle; }
		public function set angle( value:Number ):void 
		{
			if( value != _angle ) 
			{
				_angle = value;
				invalidate();
			}
		}
		
		protected var _segments:int;
		public function set segments( value:int ):void 
		{
			if( _segments != value )
			{
				_segments = value;
				invalidate();
			}
		}
		
		protected var _startAngle:Number;
		public function get startAngle():Number { return _startAngle; }
		public function set startAngle( value:Number ):void 
		{
			if( _startAngle != value ) 
			{
				_startAngle = value;
				invalidate();
			}
		}
		
		// -----------------------------------------------
		//	-- overrides
		// -----------------------------------------------
		
		override public function set width( value:Number ):void 
		{
			if( value != _width )
			{
				radius = value * .5;
				_width = _height = value;
				invalidate();
			}
		}
		
		override public function set height( value:Number ):void 
		{
			if( value != _height )
			{
				radius = value * .5;
				_width = _height = value;				
				invalidate();
			}
		}
		
		override public function setSize(w:Number, h:Number):void
		{
			_width = _height = w;
			radius = _width * .5;
		}
		
		override public function toString():String { return 'WedgeShape'; }
		
		// -----------------------------------------------
		//
		//	-- protected
		//
		// -----------------------------------------------
		
		// -----------------------------------------------
		//	-- overrides
		// -----------------------------------------------
		
		override protected function create():void
		{
			super.create();
			
			_width = _height = 100;
			radius 	= _width * .5;
			
			_angle = 270;
			_segments = 40;
			_startAngle = 0;
		}
		
		override protected function draw():void
		{	
			// -- super takes care of creating fills and linestyle
			super.draw();
			
			var i:int;
			var p:Point = new Point();
			var degrees:Number = ( _startAngle + ( _angle - _startAngle ) ) / _segments;
			
			for( i = 0; i <= _segments; i++ ) 
			{
				p.x = Math.cos( ( ( degrees * i ) + _startAngle ) * Math.PI / 180 ) * radius;
				p.y = Math.sin( ( ( degrees * i ) + _startAngle ) * Math.PI / 180 ) * radius;
				g.lineTo( p.x, p.y );
			}
			
			g.endFill();
			shape.x = shape.y = radius;
		}
		
	}
}