package makemachine.display.ui
{
	import flash.display.*;
	import flash.events.*;
	import flash.filters.*;
	import flash.geom.Point;
	import flash.geom.Rectangle;
	
	import makemachine.display.InterfaceElement;
	import makemachine.display.shapes.*;
	import makemachine.display.text.BitmapText;
	import makemachine.parameters.Parameter;
	import makemachine.utils.*;
	
	public class Knob extends InterfaceElement
	{	
		public function Knob( container:DisplayObjectContainer = null, xpos:Number = 0, ypos:Number = 0 )
		{
			super( container, xpos, ypos );	
		}
		
		// -----------------------------------------------
		//
		//	-- properties
		//
		// -----------------------------------------------
		
		protected var background:RectangleShape;
		protected var gutterRing:RingShape;
		protected var gutterWedge:WedgeShape;
		protected var fillRing:RingShape;
		protected var fillWedge:WedgeShape;
		protected var labelField:BitmapText;
		protected var valueField:BitmapText;
		
		protected var dragStart:Point;
		protected var dragStartValue:Number;
		
		// -----------------------------------------------
		//	-- getter/setter
		// -----------------------------------------------
		
		protected var _parameter:Parameter;
		public function get parameter():Parameter { return _parameter }
		public function set parameter( newParameter:Parameter ):void
		{
			if( _parameter ) 
			{
				_parameter.removeEventListener( Event.CHANGE, onParamUpdate );
			}
			
			_parameter = newParameter;
			_parameter.addEventListener( Event.CHANGE, onParamUpdate );
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
			_width = background.width;
			_height = background.height;
			return super.measure();
		}
		
		override public function toString():String { return "Knob"; }
		
		// -----------------------------------------------
		//
		//	protected
		//
		// -----------------------------------------------
		
		// -----------------------------------------------
		//	-- events
		// -----------------------------------------------
		protected function onEnterFrame( event:Event ):void 
		{
			var dist:Number = ( dragStart.y - background.mouseY ) / 50;
			dist = constrain( dist, -1, 1 );
			_parameter.value = _parameter.min + ( ( dragStartValue + dist ) * _parameter.max );
		}
		
		protected function onMouseDown( event:MouseEvent ):void
		{
			if( !stage ) return;
			
			stage.addEventListener( Event.ENTER_FRAME, onEnterFrame );
			stage.addEventListener( MouseEvent.MOUSE_UP, onStageMouseUp );
			
			dragStartValue = _parameter.normalizedValue;
			dragStart = new Point( event.localX, event.localY );
		}
		
		protected function onParamUpdate( event:Event ):void 
		{
			invalidate();
		}
		
		protected function onStageMouseUp( event:MouseEvent ):void 
		{
			if( !stage ) return;
			stage.removeEventListener( Event.ENTER_FRAME, onEnterFrame );
			stage.removeEventListener( MouseEvent.MOUSE_UP, onStageMouseUp );
		}
		
		// -----------------------------------------------
		//	-- overrides
		// -----------------------------------------------
		
		override protected function create():void
		{
			super.create();
			
			parameter = new Parameter( 'Parameter', 0, 1, .5 );
			
			background = Factory.defaultBackground( this );
			
			var size:int = ( Factory.PANEL_WIDTH_MD ) - ( Factory.ELEMENT_PADDING * 2 );
			var thickness:int = 35;
			
			gutterRing = new RingShape( this, Factory.ELEMENT_PADDING, Factory.ELEMENT_PADDING) ;
			gutterRing.setSize( size, size );
			gutterRing.thickness = thickness;
			gutterRing.fillColor = Factory.METER_FILL_COLOR_2;
			gutterRing.mouseEnabled = false;
			
			gutterWedge = new WedgeShape( this, Factory.ELEMENT_PADDING, Factory.ELEMENT_PADDING );
			gutterWedge.setSize( size, size );
			gutterWedge.startAngle = 130;
			gutterWedge.angle = 280;
			gutterWedge.mouseEnabled = false;
			
			fillRing = new RingShape( this, Factory.ELEMENT_PADDING, Factory.ELEMENT_PADDING) ;
			fillRing.setSize( size, size );
			fillRing.thickness = thickness;
			fillRing.fillColor = Factory.METER_FILL_COLOR_2;
			fillRing.fillColor = Factory.METER_FILL_COLOR_1;
			fillRing.mouseEnabled = false;
			
			fillWedge = new WedgeShape( this, Factory.ELEMENT_PADDING, Factory.ELEMENT_PADDING );
			fillWedge.setSize( size, size );
			fillWedge.startAngle = 130;
			fillWedge.angle = 180;
			fillWedge.mouseEnabled = false;
			
			labelField = Factory.singleLineField( this, 0, 0, 'primary', 'Knob' );
			labelField.textColor = Factory.TEXT_COLOR_1;
			
			background.setSize( Factory.PANEL_WIDTH_MD, Factory.PANEL_WIDTH_MD + labelField.height );
			labelField.x = ( Factory.PANEL_WIDTH_MD - labelField.textWidth ) * .5;
			
			valueField = Factory.singleLineField( this, 0, 0, 'secondary', '0.0' );
			valueField.textColor = Factory.TEXT_COLOR_2;
			valueField.thickness = 0;
			
			gutterRing.mask = gutterWedge;
			fillRing.mask = fillWedge;
			
			background.addEventListener( MouseEvent.MOUSE_DOWN, onMouseDown );
		}
		
		override protected function draw():void
		{
			labelField.text = titleCase( _parameter.name, true );
			labelField.y = Factory.PANEL_WIDTH_MD - Factory.ELEMENT_PADDING;
			labelField.x = ( Factory.PANEL_WIDTH_MD - labelField.width ) * .5;
			
			valueField.text = Factory.formatParameterText( _parameter );
			valueField.y = labelField.y + labelField.height;
			valueField.x = ( Factory.PANEL_WIDTH_MD - valueField.width ) * .5;
			
			background.setSize( Factory.PANEL_WIDTH_MD, Math.round( valueField.y + valueField.height + Factory.ELEMENT_PADDING ) );
			
			fillWedge.angle = 280 * _parameter.normalizedValue;
		}
	}
}