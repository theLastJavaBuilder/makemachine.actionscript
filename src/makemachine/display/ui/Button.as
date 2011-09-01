package makemachine.display.ui
{
	import flash.display.*;
	import flash.events.*;
	import flash.geom.*;
	
	import makemachine.display.InterfaceElement;
	import makemachine.display.shapes.RectangleShape;
	import makemachine.display.text.BitmapText;
	
	/**
	 * Simple button can have a text or graphic label
	 */
	public class Button extends InterfaceElement
	{
		public function Button( container:DisplayObjectContainer=null, xpos:Number = 0, ypos:Number = 0 )
		{
			super( container, xpos, ypos );
		}
		
		// -------------------------------------------------------
		//
		//	-- properties
		//
		// -------------------------------------------------------
		
		protected var background:RectangleShape;
		protected var labelField:BitmapText;
		protected var label:Sprite;
		protected var style:Factory;
		protected var color1:ColorTransform;
		protected var color2:ColorTransform;
		
		// -------------------------------------------------------
		//	-- getter/setter
		// -------------------------------------------------------
		
		protected var _autoSize:Boolean;
		public function set autoSize( value:Boolean ):void 
		{
			if( _autoSize != value )
			{
				_autoSize = value;
				invalidate();
			}
		}
		
		protected var _callback:Function;
		public function set callback( value:Function ):void {
			_callback = value;
		}
		
		protected var _explicitWidth:int;
		protected var _explicitHeight:int;
		public function setExplicitSize( w:int, h:int ):void 
		{
			_autoSize = false;
			_explicitWidth = w;
			_explicitHeight = h;
			invalidate();
		}
		
		protected var _selected:Boolean;
		public function get selected():Boolean { return _selected; }
		public function set selected( value:Boolean ):void 
		{
			if( value != _selected )
			{
				_selected = value;
				if( _selected )
				{
					label.transform.colorTransform = color1;
				} else {
					label.transform.colorTransform = color2;
				}
				
				dispatchEvent( new Event( Event.SELECT ) );
			}
		}
		
		protected var _selectable:Boolean;
		public function set selectable( value:Boolean ):void 
		{
			_selectable = value;
			if( !value ) selected = false;
		}
	
		// -------------------------------------------------------
		//
		//	-- public 
		//
		// -------------------------------------------------------
		
		// -------------------------------------------------------
		//	-- methods
		// -------------------------------------------------------
		
		public function setIcon( icon:DisplayObject ):void 
		{
			clearLabel();
			icon.addEventListener( Event.ADDED_TO_STAGE, onIconAdded );
			label.addChild( icon );
			addChild( label );
			invalidate();
		}
		
		public function setText( value:String ):void 
		{
			labelField.text = value;
			clearLabel();
			label.addChild( labelField );
			invalidate();
		}
		
		public function setCorners( tl:int, tr:int, bl:int, br:int ):void 
		{
			background.complexCorners = [ tl, tr, bl, br ];
		}
		
		// -------------------------------------------------------
		//	-- overrides
		// -------------------------------------------------------
		
		override public function measure():Rectangle 
		{
			_width = background.width;
			_height = background.height;
			return super.measure();
		}
		
		override public function toString():String { return 'Button'; }
		
		override public function validate(event:Event=null):void
		{
			super.validate( event );
			labelField.validate();
			background.validate();
		}
		
		// -------------------------------------------------------
		//
		//	-- protected
		//
		// -------------------------------------------------------
		
		// -------------------------------------------------------
		//	-- methods
		// -------------------------------------------------------
		
		protected function clearLabel():void 
		{
			while( label.numChildren > 0 ) label.removeChildAt( 0 );
		}
		
		// -------------------------------------------------------
		//	-- event handlers
		// -------------------------------------------------------
		
		protected function onIconAdded( event:Event ):void 
		{
			invalidate();
			if( event.target is EventDispatcher )
			{
				EventDispatcher( event.target ).removeEventListener( Event.ADDED_TO_STAGE, onIconAdded );
			}
		}
		
		protected function onMouseOver( event:MouseEvent ):void 
		{
			background.fillColor = style.mouseOverColor;
			label.transform.colorTransform = color1;
		}
		
		protected function onMouseOut( event:MouseEvent ):void 
		{
			background.fillColor = style.mouseUpColor;
			if( _selectable ) 
			{
				if( !_selected ) {
					label.transform.colorTransform = color2;
				}
			} else {
				label.transform.colorTransform = color2;
			}	
		}
		
		protected function onMouseDown( event:MouseEvent ):void
		{
			if( _callback != null ) _callback( this );
			if( _selectable )
			{
				selected = !_selected;
			}
		}
		
		// -------------------------------------------------------
		//	-- overrides
		// -------------------------------------------------------
		
		override protected function create():void
		{
			super.create();
			
			style = new Factory();
			
			_autoSize = true;
			_explicitWidth = 100;
			_explicitHeight = 100;
			
			buttonMode = true;
			mouseChildren = false;
			
			color1 = new ColorTransform( 0, 0, 0, 1, style.textColor1 >> 16 & 0xFF, style.textColor1 >> 8 & 0xFF, style.textColor1 & 0xFF, 1 );
			color2 = new ColorTransform( 0, 0, 0, 1, style.textColor2 >> 16 & 0xFF, style.textColor2 >> 8 & 0xFF, style.textColor2 & 0xFF, 1 );
			
			label = new Sprite();
			label.mouseEnabled = false;
			label.mouseChildren = false;
			
			background = Factory.defaultBackground( this );
			background.fillColor = Factory.MOUSE_UP_COLOR;
			
			labelField = Factory.singleLineField( label, 0, 0, 'primary', 'LabelButton' );
			label.transform.colorTransform = color2;
			
			addChild( label );
			
			addEventListener( MouseEvent.MOUSE_OVER, onMouseOver );
			addEventListener( MouseEvent.MOUSE_OUT, onMouseOut );
			addEventListener( MouseEvent.MOUSE_DOWN, onMouseDown );
		}
		
		override protected function draw():void
		{	
			labelField.validate();
			
			var w:int = Math.ceil( label.width + Factory.ELEMENT_PADDING * 4 );
			var h:int = Math.ceil( label.height + Factory.ELEMENT_PADDING * 2 );
			
			if( _autoSize ) {
				background.setSize( w, h );
			} else {
				_explicitWidth = Math.max( _explicitWidth, w );
				_explicitHeight = Math.max( _explicitHeight, h );
				background.setSize( _explicitWidth, _explicitHeight );
			}
			
			label.x = ( background.width - label.width ) * .5;
			label.y = ( background.height - label.height ) * .5
		}
	}
}