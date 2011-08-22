package makemachine.display.ui
{
	import flash.display.DisplayObjectContainer;
	import flash.events.Event;
	import flash.geom.Rectangle;
	
	import makemachine.display.InterfaceElement;
	import makemachine.display.shapes.RectangleShape;
	import makemachine.display.text.BitmapText;

	/**
	 * Simple label displays text in h1 style
	 */
	public class Label extends InterfaceElement
	{
		public function Label( container:DisplayObjectContainer = null, xpos:Number = 0, ypos:Number = 0 )
		{
			super( container, xpos, ypos );
		}
		
		// -----------------------------------------------
		//
		//	-- properties
		//
		// -----------------------------------------------
		
		protected var background:RectangleShape;
		protected var field:BitmapText;
		
		// -----------------------------------------------
		//
		//	-- public
		//
		// -----------------------------------------------
		
		// -----------------------------------------------
		//	-- methods
		// -----------------------------------------------
		
		public function setText( value:String ):void 
		{
			field.text = value;
		}
		
		// -----------------------------------------------
		//	-- overrides
		// -----------------------------------------------
		
		override public function measure():Rectangle
		{
			_width = background.width;
			_height = background.height;
			return super.measure();
		}
		
		override public function toString():String { return 'Label'; }
		
		override public function validate(event:Event=null):void
		{
			super.validate();
			background.validate();
			field.validate();
		}
		// -----------------------------------------------
		//
		//	-- protected
		//
		// -----------------------------------------------
		
		// ------------------------------------------------
		//	-- overrides
		// ------------------------------------------------
		
		override protected function create():void
		{
			super.create();
			
			background = Factory.defaultBackground( this, 0, 0 );
			
			field = Factory.singleLineField( this, Factory.ELEMENT_PADDING, Factory.ELEMENT_PADDING, 'h1', 'Label' );
			field.textColor = Factory.METER_FILL_COLOR_1;
		}
		
		override protected function draw():void 
		{
			background.setSize( Factory.PANEL_WIDTH_LG, Math.round( Math.round( field.height ) + Factory.ELEMENT_PADDING * 2 ) );
		}
	}
}