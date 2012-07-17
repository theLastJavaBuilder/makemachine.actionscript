package makemachine.display.ui
{
	import flash.display.*;
	import flash.events.*;
	import flash.geom.Rectangle;
	
	import makemachine.display.InterfaceElement;
	import makemachine.display.shapes.RectangleShape;
	import makemachine.display.text.BitmapText;
	import makemachine.parameters.NumericParameter;
	import makemachine.utils.*;
	
	/**
	 * A horizontal slider that controls the value of a single parameter
	 */
	public class Slider extends InterfaceElement
	{
		public function Slider( container:DisplayObjectContainer=null, xpos:Number=0, ypos:Number=0 )
		{
			super( container, xpos, ypos );
		}
		
		// -------------------------------------------------------
		//
		//	-- properties
		//
		// -------------------------------------------------------
		
		protected var background:RectangleShape;
		protected var gutter:RectangleShape;
		protected var fill:RectangleShape;
		protected var labelField:BitmapText;
		protected var valueField:BitmapText;
		
		// -------------------------------------------------------
		//	-- getter/setter
		// -------------------------------------------------------
		
		protected var _parameter:NumericParameter;
		public function get parameter():NumericParameter { return _parameter }
		public function set parameter( newParameter:NumericParameter ):void
		{
			if( _parameter ) 
			{
				_parameter.removeEventListener( Event.CHANGE, onParamUpdate );
			}
			
			_parameter = newParameter;
			_parameter.addEventListener( Event.CHANGE, onParamUpdate );
			invalidate();
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
			_width = Factory.PANEL_WIDTH_LG;
			_height = background.height;
			return super.measure();
		}
		
		override public function toString():String { return 'Slider: ' + _parameter.name; }
		
		override public function validate(event:Event=null):void
		{
			super.validate();
			labelField.validate();
			valueField.validate();
			fill.validate();
			gutter.validate();
			background.validate();
		}
		
		// -------------------------------------------------------
		//
		//	-- protected
		//
		// -------------------------------------------------------
		
		// -------------------------------------------------------
		// -- event handlers
		// -------------------------------------------------------
		
		protected function onEnterFrame( event:Event ):void 
		{
			parameter.value = interpolate( gutter.mouseX / gutter.width, parameter.min, parameter.max );
		}
		
		protected function onGutterMouseDown( event:MouseEvent ):void 
		{
			if( stage )
			{
				stage.addEventListener( Event.ENTER_FRAME, onEnterFrame );
				stage.addEventListener( MouseEvent.MOUSE_UP, onStageMouseUp );
			}
		}
		
		protected function onParamUpdate( event:Event ):void 
		{
			invalidate();
		}
		
		protected function onStageMouseUp( event:Event ):void 
		{
			stage.removeEventListener( Event.ENTER_FRAME, onEnterFrame );
			stage.removeEventListener( MouseEvent.MOUSE_UP, onStageMouseUp );
		}
		
		// -------------------------------------------------------
		// -- overrides
		// -------------------------------------------------------
		
		override protected function create():void 
		{
			super.create();
			
			parameter = new NumericParameter( 'Slider', 0, 1, .5 );
			
			background = Factory.defaultBackground( this, 0, 0 );
			
			labelField = Factory.singleLineField( this, Factory.ELEMENT_PADDING, Factory.ELEMENT_PADDING, 'primary', 'Slider' );
			labelField.textColor = Factory.TEXT_COLOR_1;
			labelField.thickness = 100;
			
			gutter = new RectangleShape( this, Factory.ELEMENT_PADDING, labelField.y + labelField.height + Factory.ELEMENT_PADDING );
			gutter.fillColor = Factory.METER_FILL_COLOR_2;
			gutter.setSize( Factory.PANEL_WIDTH_LG - Factory.ELEMENT_PADDING * 2, 10 );
			gutter.buttonMode = true;
			
			valueField = Factory.singleLineField( this, gutter.x + gutter.width + Factory.ELEMENT_PADDING, gutter.y + gutter.height + Factory.ELEMENT_PADDING, 'secondary' );
			valueField.textColor = Factory.TEXT_COLOR_2;
			valueField.thickness = 0;
			
			fill = new RectangleShape( this, gutter.x, gutter.y );
			fill.fillColor = Factory.METER_FILL_COLOR_1;
			fill.setSize( Factory.PANEL_WIDTH_LG - Factory.ELEMENT_PADDING * 2, 10 );
			fill.mouseEnabled = 
			fill.mouseChildren = false;
			
			gutter.addEventListener( MouseEvent.MOUSE_DOWN, onGutterMouseDown );
		}
		
		override protected function draw():void 
		{
			super.draw();
			
			labelField.text = titleCase( _parameter.name, true );
			valueField.text = Factory.formatParameterText( _parameter );
			valueField.x = gutter.x + gutter.width -  valueField.width;
			valueField.y = labelField.y + labelField.height - valueField.height;
			fill.width = parameter.normalizedValue * gutter.width;
			background.setSize( Factory.PANEL_WIDTH_LG, Math.round( gutter.y + gutter.height + Factory.ELEMENT_PADDING  ));
		}
	}
}