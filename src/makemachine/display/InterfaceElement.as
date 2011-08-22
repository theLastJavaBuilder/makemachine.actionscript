package makemachine.display
{
	import flash.display.*;
	import flash.events.Event;
	import flash.geom.Rectangle;

	public class InterfaceElement extends Sprite
	{	
		public var id:Object;
		public var data:Object;
		
		public function InterfaceElement( container:DisplayObjectContainer = null, xpos:Number = 0, ypos:Number = 0 )
		{
			super();
			
			cacheAsBitmap = true;
	
			if( container ) {
				container.addChild( this );
			}
			
			x = xpos;
			y = ypos;
			
			create();
			invalidate();
		}
		
		// -------------------------------------------------------
		//
		//	-- properties
		//
		// -------------------------------------------------------
		
		protected var created:Boolean;
		protected var invalidated:Boolean;
		
		// -----------------------------------------------
		//	-- getter/setter
		// -----------------------------------------------
		
		protected var _height:Number;
		override public function get height():Number { return _height; }
		
		protected var _width:Number;
		override public function get width():Number { return _width; }
		
		// -----------------------------------------------
		//
		//	-- public
		//
		// -----------------------------------------------
		
		// -----------------------------------------------
		//	-- methods
		// -----------------------------------------------
		
		public function destroy():void 
		{
			// -- override w/ sub-class	
		}
		
		public function invalidate():void
		{
			invalidated = true;
			addEventListener( Event.ENTER_FRAME, validate );
		}
		
		public function measure():Rectangle
		{
			return new Rectangle( x, y, _width, _height );
		}
		
		public function validate( event:Event = null ):void
		{
			if( created && invalidated )
			{
				draw();
				measure();
				invalidated = false;
				removeEventListener( Event.ENTER_FRAME, validate );
			}
		}
		
		// -----------------------------------------------
		//	-- overrides
		// -----------------------------------------------
		
		override public function toString():String { return 'InterfaceElement'; }
		
		// -----------------------------------------------
		//
		//	-- protected
		//
		// -----------------------------------------------
		
		// -----------------------------------------------
		//	-- methods
		// -----------------------------------------------
		
		protected function create():void 
		{
			// -- override this method w/ sub-class and always call super.create()
			created = true;
			invalidated = true;
		}
		
		protected function draw():void 
		{
			// -- override this method w/ sub-class always call super.draw()
		}
		
	}
}