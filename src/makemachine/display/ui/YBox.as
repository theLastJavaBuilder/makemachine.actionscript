package makemachine.display.ui
{
	import flash.display.*;
	import flash.geom.Rectangle;
	
	import makemachine.display.InterfaceElement;
	
	public class YBox extends Box
	{
		public function YBox( container:DisplayObjectContainer = null, xpos:Number = 0, ypos:Number = 0  ) 
		{
			super( container, xpos, ypos );
		}
		
		// -----------------------------------------------
		//
		//	public
		//
		// -----------------------------------------------
		
		// -----------------------------------------------
		//	-- overrides
		// -----------------------------------------------
		
		override public function measure():Rectangle
		{
			super.draw();
			
			var i:int = 0;
			var h:Number = 0;
			var w:Number = 0;
			var ypos:Number = 0;
			var l:int = numChildren;
			var element:InterfaceElement;
			for ( i; i < l; i++ )
			{
				element = getChildAt( i ) as InterfaceElement;
				ypos = Math.max( ypos, element.y );
				h = ypos + element.height;
				w = Math.max( w, element.width );
			}
			
			_width = w;
			_height = h;
			
			return new Rectangle( _width, _height );
		}
		
		override public function toString():String { return 'YBox' };
		
		// -----------------------------------------------
		//
		//	-- protected
		//
		// -----------------------------------------------
		
		// -----------------------------------------------
		//	-- method overrides
		// -----------------------------------------------
		
		override protected function draw():void
		{
			var i:int = 0;
			var l:int = numChildren;
			var element:InterfaceElement;
			var prev:InterfaceElement;
			
			for ( i; i < l; i++ )
			{
				element = getChildAt( i ) as InterfaceElement;
				element.validate();
				element.measure();
				element.y = prev != null ? ( prev.y + prev.height + _spacing ) : 0;
				element.y = Math.floor( element.y );
				prev = element;
			}
		}
	}
}