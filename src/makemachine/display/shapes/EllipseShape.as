package makemachine.display.shapes
{
	import flash.display.*;
	
	public class EllipseShape extends ShapeBase
	{
		public static const ELLIPTICAL:String = 'elliptical';
		public static const CIRCULAR:String = 'circular';
		
		protected var shapeType:String;
		
		public function EllipseShape( container:DisplayObjectContainer=null, xpos:Number=0, ypos:Number=0 )
		{
			super( container, xpos, ypos );
		}
		
		// ------------------------------------------------
		//	
		// -- public
		// 
		// ------------------------------------------------
		
		// ------------------------------------------------	
		// -- overrides
		// ------------------------------------------------
		
		override public function toString():String { return "EllipseShape"; }
		
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
			_width = 100;
			_height = 100;
		}
		
		override protected function draw():void
		{
			super.draw();
			g.drawEllipse( 0, 0, _width, _height );
			shape.x = shape.y = 0;
			g.endFill();
		}
	}
}