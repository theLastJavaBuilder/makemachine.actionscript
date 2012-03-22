package makemachine.display.shapes
{
	import flash.display.*;
	import flash.events.*;
	import flash.geom.Point;
	
	public class RingShape extends ShapeBase
	{
		protected var _xradius:Number;
		protected var _yradius:Number;
		
		public function RingShape( container:DisplayObjectContainer=null, xpos:Number=0, ypos:Number=0 )
		{
			super( container, xpos, ypos );
		}
		
		// -----------------------------------------------
		//
		//	-- properties
		//
		// -----------------------------------------------
		
		// -----------------------------------------------
		//	-- getter/setter
		// -----------------------------------------------
		
		override public function set width(value:Number):void 
		{
			if( _xradius * .5 != value )
			{
				_width = value;
				_xradius = value * .5;
				invalidate();
			}
		}
		
		override public function set height(value:Number):void 
		{
			if( _yradius * .5 != value ) 
			{
				_height = value;
				_yradius = value * .5;
				invalidate();
			}
		}
		
		protected var _thickness:Number;
		public function set thickness( value:Number ):void 
		{
			if( _thickness != value ) 
			{
				_thickness = value;
				invalidate();
			}
		}
		
		// -----------------------------------------------
		//	-- overrides
		// -----------------------------------------------
		
		override public function setSize(w:Number, h:Number):void
		{
			width = w;
			height = h;
		}
		
		override public function toString():String { return 'RingShape' };
		
		// -----------------------------------------------
		//
		//	-- protected
		//
		// -----------------------------------------------
		
		// -----------------------------------------------
		//	-- method overrides
		// -----------------------------------------------
		
		override protected function create():void 
		{
			super.create();
			
			_width = 100;
			_height = 100;
			
			_xradius = _width * .5;
			_yradius = _height * .5;
			_thickness = 20;
		}
		
		override protected function draw():void
		{
			// -- super takes care of creating fills and linestyle
			super.draw();
			
			var i:int;
			var radius:int = 100
			var p:Point = new Point();
			var segments:int = 40;
			var degrees:Number = 360 / segments;
			
			// -- outer ring
			for( i = 0; i <= segments; i++ ) 
			{
				p.x = Math.cos( ( ( degrees * i )  ) * Math.PI / 180 ) * _xradius; 
				p.y = Math.sin( ( ( degrees * i ) ) * Math.PI / 180 ) * _yradius;
				
				if( i == 0 ) {
					g.moveTo( p.x, p.y );
					continue;
				}
				
				g.lineTo( p.x, p.y );
			}
			
			// -- inner ring
			for( i = 0; i <= segments; i++ ) 
			{
				p.x = Math.cos( ( ( degrees * i )  ) * Math.PI / 180 ) * ( _xradius - ( _thickness * .5 ) ); 
				p.y = Math.sin( ( ( degrees * i ) ) * Math.PI / 180 ) * ( _yradius - ( _thickness * .5 ) );
				
				if( i == 0 ) {
					g.moveTo( p.x, p.y );
					continue;
				}
				
				g.lineTo( p.x, p.y );
			}
			
			g.endFill();
			
			shape.x = _xradius;
			shape.y = _yradius;
		}
	}
}