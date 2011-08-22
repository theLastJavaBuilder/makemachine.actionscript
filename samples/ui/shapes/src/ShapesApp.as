package
{
	import flash.display.Bitmap;
	import flash.display.Sprite;
	
	import makemachine.display.shapes.EllipseShape;
	import makemachine.display.shapes.PolygonShape;
	import makemachine.display.shapes.RectangleShape;
	import makemachine.display.shapes.RingShape;
	import makemachine.display.shapes.WedgeShape;
	import makemachine.display.ui.XBox;
	import makemachine.display.ui.YBox;
	
	[SWF( backgroundColor="0xFFFFFF", frameRate="60", width="620", height="208" )]
	public class ShapesApp extends Sprite
	{
		[Embed( source="dot.png" )]
		public static var BgTile:Class;
		
		public function ShapesApp()
		{
			var ybox:YBox = new YBox( this, 2, 2 );
			ybox.setSpacing( 3 );
			
			var xbox1:XBox = new XBox( ybox );
			xbox1.setSpacing( 3 );
			
			var rect:RectangleShape = new RectangleShape( xbox1 );
			rect.fillColor = 0x111111;
			
			rect = new RectangleShape( xbox1 );
			rect.gradientColors = [ 0x111111, 0x666666 ];
			rect.complexCorners = [ 0, 20, 20, 20 ];
			
			var circle:EllipseShape = new EllipseShape( xbox1 );
			circle.fillColor = 0x333333;
			circle.gradientColors = [ 0x111111, 0x00c6FF ];
			
			var ring:RingShape = new RingShape( xbox1 );
			ring.gradientColors = [ 0xFFFFFF, 0x00c6FF ];
			ring.thickness = 40;
			ring.setLineStyle( 2, 0x111111, 1 );
			
			var poly:PolygonShape = new PolygonShape( xbox1 );
			poly.sides = 8;
			poly.fillColor = 0x111111;
			
			rect = new RectangleShape( xbox1 );
			rect.setLineStyle( 2, 0x00c6ff, 1 );
			rect.fillColor = 0x111111;
			
			var xbox2:XBox = new XBox( ybox );
			
			rect = new RectangleShape( xbox2 );
			rect.width = 200;
			rect.cornerRadius = 20;
			rect.fillColor = 0x111111;
			
			var wedge:WedgeShape = new WedgeShape( xbox2 );
			wedge.fillColor = 0xFFFFFF;
			wedge.setLineStyle( 2, 0x111111, 1 );
			
			circle = new EllipseShape( xbox2 );
			circle.width = 210;
			circle.fillColor = 0x111111;
			circle.setLineStyle( 1, 0x00c6ff, 1 );
			
			rect = new RectangleShape( xbox2 );
			rect.fillColor = 0xFFFFFF;
			rect.setLineStyle( 2, 0x111111, 1 );
			rect.bitmapFill = Bitmap( new BgTile() ).bitmapData;
		}
	}
}