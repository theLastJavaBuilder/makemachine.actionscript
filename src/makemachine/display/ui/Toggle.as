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
		protected var style:Factory;
		
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
			
			style = new Factory();
			
			background = Factory.defaultBackground( this );
			background.buttonMode = true;
			background.width = Factory.PANEL_WIDTH_LG;
			
			ring = new RingShape( this, style.elementPadding, style.elementPadding );
			ring.fillColor = style.meterFillColor1;
			ring.thickness = 2;
			ring.mouseEnabled = false;
			
			fill = new EllipseShape( this, ring.x + 5, ring.y + 5 );
			fill.setLineStyle( 2, style.meterFillColor2, 1 );
			fill.mouseEnabled = false;
			
			labelField = Factory.singleLineField( this, 0, 0, 'primary', _parameter.name );
			labelField.textColor = style.textColor1;
			
			background.addEventListener( MouseEvent.MOUSE_DOWN, onMouseDown );
		}
		
		override protected function draw():void 
		{
			super.draw();
			
			labelField.text = _parameter.name;
			labelField.textColor = _parameter.value ? style.textColor1 : style.textColor2;
			
			ring.fillColor = _parameter.value ? style.meterFillColor1 : style.meterFillColor2;
			ring.setSize( labelField.height, labelField.height );
			fill.setSize( ring.height * .5, ring.height * .5 );
			fill.x = ( ring.x + ring.width * .5 ) - fill.width * .5;
			fill.y = ( ring.y + ring.height * .5 ) - fill.height * .5;
			
			if( _parameter.value )
			{
				fill.fillColor = style.meterFillColor1;
			} else {
				fill.fillColor = style.backgroundColor;
			}
			
			background.height = labelField.height + style.elementPadding * 2;
			labelField.x = ring.x + ring.width + style.elementPadding;
			labelField.y = ( ring.y + ring.height + 5 - labelField.height ) * .5;
		}
	}
}