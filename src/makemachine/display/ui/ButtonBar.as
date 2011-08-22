package makemachine.display.ui
{
	import flash.display.DisplayObjectContainer;
	import flash.events.Event;
	import flash.events.MouseEvent;
	import flash.geom.Rectangle;
	
	import makemachine.display.InterfaceElement;
	
	public class ButtonBar extends InterfaceElement
	{
		public function ButtonBar( container:DisplayObjectContainer=null, xpos:Number=0, ypos:Number=0 )
		{
			super( container, xpos, ypos );
		}
		
		// ----------------------------------------------
		//
		//	-- properties
		//
		// ----------------------------------------------
		
		protected var xbox:XBox;
		protected var buttons:Vector.<Button>;
		
		// ----------------------------------------------
		//
		//	-- getter/setter
		//
		// ----------------------------------------------
		protected var _selectedIndex:int;
		public function get selectedIndex():int { return _selectedIndex; }
		
		// ----------------------------------------------
		//
		//	-- public
		//
		// ----------------------------------------------
		
		// ----------------------------------------------
		//	-- methods
		// ----------------------------------------------
		
		public function setContent( content:Vector.<Button> ):void 
		{
			xbox.clear();
			buttons = content;
			
			if( !buttons ) return;
			
			var i:int = 0;
			var button:Button;
			var l:int = buttons.length;
			var radius:int = Factory.BACKGROUND_CORNER_RADIUS;
			
			var w:int = 0;
			var h:int = 0;
			
			buttons.slice(0);
			
			for( i = 0; i < l; i++) 
			{
				button = buttons[i];
			
				if( i == 0  ) 
				{
					button.setCorners( radius, 0, radius, 0 );
				} else if( i == l - 1 )
				{
					button.setCorners( 0, radius, 0, radius );
				} else {
					button.setCorners( 0, 0, 0, 0 );
				}
				
				xbox.addChild( button );
				
				button.selectable = true;
				button.addEventListener( MouseEvent.MOUSE_DOWN, onButtonSelect );
			}
			
			buttons[0].selected = true;
			_selectedIndex = 0;
		}
		
		public function setExplicitButtonSize( w:int, h:int ):void 
		{
			if( !buttons ) return;
			
			var i:int = 0;
			var button:Button;
			var l:int = buttons.length;
			
			for( i = 0; i < l; i++) 
			{
				button = buttons[i];
				button.setExplicitSize( w, h );
			}
			
			xbox.invalidate();
		}
		
		// ----------------------------------------------
		//	-- overrides
		// ----------------------------------------------
		
		override public function measure():Rectangle
		{
			return xbox.measure();
		}
		
		override public function toString():String { return 'ButtonBar'; }
		
		// ----------------------------------------------
		//
		//	-- protected 
		//
		// ----------------------------------------------
		
		// ------------------------------------------------
		//	-- overrides
		// ------------------------------------------------
		
		override protected function create():void
		{
			super.create();
			xbox = new XBox( this );
		}
		
		// ----------------------------------------------
		//	-- event handlers
		// ----------------------------------------------
		
		protected function onButtonSelect( event:MouseEvent ):void 
		{
			if( !buttons ) return;
			
			var i:int = 0;
			var button:Button;
			var l:int = buttons.length;
			var selectedButton:Button;
			
			for( i = 0; i < l; i++) 
			{
				button = buttons[i];
				if( button != event.target )
				{
					button.selected = false;
				} else {
					selectedButton = button;
				}
			}
			
			_selectedIndex = selectedButton.selected ? buttons.indexOf( selectedButton ) : -1;
			
			if( _selectedIndex == -1 )
			{
				buttons[0].selected = true;
				_selectedIndex = 0;
			}
			
			dispatchEvent( new Event( Event.SELECT ) );
		}
	}
}