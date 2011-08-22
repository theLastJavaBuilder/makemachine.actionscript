package makemachine.display.ui
{
	import flash.display.*;
	import flash.geom.Rectangle;
	
	import makemachine.display.InterfaceElement;
	
	public class XBox extends Box
	{
		public function XBox( container:DisplayObjectContainer = null, xpos:Number = 0, ypos:Number = 0 )
		{
			super( container, xpos, ypos );
		}
		
		// -----------------------------------------------
		//
		//	-- public
		//
		// -----------------------------------------------
		
		// -----------------------------------------------
		//	-- overrides
		// -----------------------------------------------
		
		override public function measure():Rectangle
		{
			var i:int = 0;
			var h:Number = 0;
			var w:Number = 0;
			var l:int = numChildren;
			var element:InterfaceElement;
			var xpos:Number = 0;
			
			for ( i; i < l; i++ )
			{
				element = getChildAt( i ) as InterfaceElement;
				element.measure();
				w += element.width;
				
				h = Math.max( h, element.height );
				xpos = Math.max( xpos, element.x );
				w = xpos + element.width;
			}
			
			_width = w;
			_height = h;
			
			return super.measure();
		}
		
		override public function toString():String { return 'XBox'; }
		
		// -----------------------------------------------
		//
		//	-- protected
		//
		// -----------------------------------------------
		
		// -----------------------------------------------
		//	-- overrides
		// -----------------------------------------------
		
		override protected function draw():void
		{
			super.draw();
			
			var i:int = 0;
			var l:int = numChildren;
			var element:InterfaceElement;
			var prev:InterfaceElement;
			
			
			for ( i; i < l; i++ )
			{
				element = getChildAt( i ) as InterfaceElement;
				element.validate();
				element.measure();
				element.x = prev != null ? ( prev.x + prev.width + _spacing ) : 0;
				element.x = Math.ceil( element.x );
				prev = element;
			}
		}
	}
}