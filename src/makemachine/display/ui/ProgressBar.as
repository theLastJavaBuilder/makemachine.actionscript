package makemachine.display.ui
{
	import flash.display.*;
	import flash.events.*;
	import flash.geom.Rectangle;
	
	import makemachine.display.InterfaceElement;
	import makemachine.display.shapes.RectangleShape;
	import makemachine.display.text.BitmapText;
	import makemachine.parameters.Parameter;
	import makemachine.utils.*;
	
	/**
	 * A horizontal slider that controls the value of a single progress
	 */
	public class ProgressBar extends InterfaceElement
	{
		public function ProgressBar( container:DisplayObjectContainer=null, xpos:Number=0, ypos:Number=0 )
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
		
		// -------------------------------------------------------
		//	-- getter/setter
		// -------------------------------------------------------
		
		protected var _progress:Parameter;
		public function get progress():Parameter { return _progress }
		public function set progress( newParameter:Parameter ):void
		{
			if( _progress ) 
			{
				_progress.removeEventListener( Event.CHANGE, onParamUpdate );
			}
			
			_progress = newParameter;
			_progress.addEventListener( Event.CHANGE, onParamUpdate );
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
		
		override public function toString():String { return 'Slider: ' + _progress.name; }
		
		override public function validate(event:Event=null):void
		{
			super.validate();
			labelField.validate();
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
		
		protected function onParamUpdate( event:Event ):void 
		{
			invalidate();
		}
		
		// -------------------------------------------------------
		// -- overrides
		// -------------------------------------------------------
		
		override protected function create():void 
		{
			super.create();
			
			progress = new Parameter( 'Progress', 0, 1, .5 );
			
			background = Factory.defaultBackground( this, 0, 0 );
			
			labelField = Factory.singleLineField( this, Factory.ELEMENT_PADDING, Factory.ELEMENT_PADDING, 'primary', 'Progress' );
			labelField.textColor = Factory.TEXT_COLOR_1;
			labelField.thickness = 100;
			
			gutter = new RectangleShape( this, Factory.ELEMENT_PADDING, labelField.y + labelField.height + Factory.ELEMENT_PADDING );
			gutter.fillColor = Factory.METER_FILL_COLOR_2;
			gutter.setSize( Factory.PANEL_WIDTH_LG - Factory.ELEMENT_PADDING * 2, 10 );
			gutter.buttonMode = true;
			
			fill = new RectangleShape( this, gutter.x, gutter.y );
			fill.fillColor = Factory.METER_FILL_COLOR_1;
			fill.setSize( Factory.PANEL_WIDTH_LG - Factory.ELEMENT_PADDING * 2, 10 );
			fill.mouseEnabled = 
			fill.mouseChildren = false;
		}
		
		override protected function draw():void 
		{
			super.draw();
			
			labelField.text = _progress.name;
			fill.width = progress.normalizedValue * gutter.width;
			background.setSize( Factory.PANEL_WIDTH_LG, Math.round( gutter.y + gutter.height + Factory.ELEMENT_PADDING  ));
		}
	}
}