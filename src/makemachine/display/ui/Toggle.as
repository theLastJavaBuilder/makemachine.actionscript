package makemachine.display.ui
{
	import flash.display.DisplayObjectContainer;
	import flash.events.Event;
	import flash.events.MouseEvent;
	import flash.geom.Rectangle;
	
	import makemachine.display.InterfaceElement;
	import makemachine.display.shapes.*;
	import makemachine.display.text.BitmapText;
	import makemachine.parameters.BoolParameter;
	
	public class Toggle extends InterfaceElement
	{
		public function Toggle(container:DisplayObjectContainer=null, xpos:Number=0, ypos:Number=0)
		{
			super( container, xpos, ypos );
		}
		
		// -------------------------------------------------------
		//
		//	-- properties
		//
		// -------------------------------------------------------
		
		protected var background:RectangleShape;
		protected var fill:EllipseShape;
		protected var labelField:BitmapText;
		protected var ring:RingShape;
		
		// -------------------------------------------------------
		//	-- getter/setter
		// -------------------------------------------------------
		
		protected var _parameter:BoolParameter;
		public function get parameter():BoolParameter { return _parameter }
		public function set parameter( newParameter:BoolParameter ):void
		{
			if( _parameter ) 
			{
				_parameter.removeEventListener( Event.CHANGE, onParamUpdate );
			}
			
			_parameter = newParameter;
			_parameter.addEventListener( Event.CHANGE, onParamUpdate );
		}
		
		// -------------------------------------------------------
		//
		//	-- public
		//
		// -------------------------------------------------------
		
		// -------------------------------------------------------
		//	-- overrides
		// -------------------------------------------------------
		
		override public function measure():Rectangle
		{
			_width = Factory.PANEL_WIDTH_LG
			_height = background.height;
			return super.measure();
		}
		
		override public function toString():String { return 'Toggle'; }
		
		// -------------------------------------------------------
		//
		//	-- protected
		//
		// -------------------------------------------------------
		
		// -------------------------------------------------------
		//	-- event handlers
		// -------------------------------------------------------
		
		protected function onMouseDown( event:MouseEvent ):void 
		{
			_parameter.value = !_parameter.value;
		}
		
		protected function onParamUpdate( event:Event ):void 
		{
			invalidate();
		}
		
		// -------------------------------------------------------
		//	-- overrides
		// -------------------------------------------------------
		
		override protected function create():void
		{
			super.create();
			
			parameter = new BoolParameter( 'Toggle', false );
			
			background = new RectangleShape( this, 0, 0 );
			background.fillAlpha = Factory.BACKGROUND_ALPHA;
			background.fillColor = Factory.BACKGROUND_COLOR;
			background.cornerRadius = Factory.BACKGROUND_CORNER_RADIUS;
			background.setSize( Factory.PANEL_WIDTH_LG, 100 );
			background.buttonMode = true;
			
			ring = new RingShape( this, Factory.ELEMENT_PADDING, Factory.ELEMENT_PADDING );
			ring.fillColor = Factory.METER_FILL_COLOR_1;
			ring.thickness = 2;
			ring.mouseEnabled = false;
			
			fill = new EllipseShape( this, ring.x + 5, ring.y + 5 );
			fill.setLineStyle( 2, Factory.METER_FILL_COLOR_2, 1 );
			fill.mouseEnabled = false;
			
			labelField = Factory.singleLineField( this, 0, 0, 'primary', _parameter.name );
			labelField.textColor = Factory.TEXT_COLOR_1;
			
			background.addEventListener( MouseEvent.MOUSE_DOWN, onMouseDown );
		}
		
		override protected function draw():void 
		{
			super.draw();
			
			labelField.text = _parameter.name;
			labelField.textColor = _parameter.value ? Factory.TEXT_COLOR_1 : Factory.TEXT_COLOR_2;
			
			ring.fillColor = _parameter.value ? Factory.METER_FILL_COLOR_1 : Factory.METER_FILL_COLOR_2;
			ring.setSize( labelField.height, labelField.height );
			fill.setSize( ring.height * .5, ring.height * .5 );
			fill.x = ( ring.x + ring.width * .5 ) - fill.width * .5;
			fill.y = ( ring.y + ring.height * .5 ) - fill.height * .5;
			
			if( _parameter.value )
			{
				fill.fillColor = Factory.METER_FILL_COLOR_1;
			} else {
				fill.fillColor = Factory.BACKGROUND_COLOR;
			}
			
			background.height = labelField.height + Factory.ELEMENT_PADDING * 2;
			labelField.x = ring.x + ring.width + Factory.ELEMENT_PADDING;
			labelField.y = ( ring.y + ring.height + 5 - labelField.height ) * .5;
		}
	}
}