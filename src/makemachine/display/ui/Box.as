package makemachine.display.ui
{
	import flash.display.*;
	import flash.events.*;
	
	import makemachine.display.InterfaceElement;
	import makemachine.display.shapes.RectangleShape;
	import makemachine.utils.print;
	
	/**
	 * Base class for vertical and horizontal stacking containers 
	 */
	public class Box extends InterfaceElement
	{
		public function Box( container:DisplayObjectContainer = null, xpos:Number = 0, ypos:Number = 0 ) 
		{
			super( container, xpos, ypos );
		}
		
		// ----------------------------------------------
		//
		//	-- properties
		//
		// ----------------------------------------------
		
		protected var items:Vector.<InterfaceElement>;
		
		// ----------------------------------------------
		//	-- getter/setter
		// ----------------------------------------------
		
		protected var _spacing:int;
		public function setSpacing( value:int ):void 
		{
			_spacing = value;
			invalidate();
		}
		
		// ----------------------------------------------
		//
		//	-- public
		//
		// ----------------------------------------------
		
		// ----------------------------------------------
		//	-- methods
		// ----------------------------------------------
		
		public function clear():void 
		{
			if( items )
			{
				items.slice( 0 );
				
				while ( numChildren > 0 )  
				{
					var child:DisplayObject = removeChildAt( 0 );
					if( child is InterfaceElement ) InterfaceElement( child ).destroy();
				}
			}
		}
		
		public function setContent( newContent:Vector.<InterfaceElement> ):void
		{
			if( newContent )
			{
				clear();
				items = newContent;
				
				for each( var item:InterfaceElement in items ) 
				{
					addChild( item );
				}
			}
			
			invalidate();
		}
		
		// ----------------------------------------------
		//	-- overrides
		// ----------------------------------------------
		
		override public function toString():String { return "Box"; }
		
		// ----------------------------------------------
		//
		//	-- protected
		//
		// ----------------------------------------------
		
		// ----------------------------------------------
		//	-- overrides
		// ----------------------------------------------
		
		override protected function create():void
		{
			super.create();
			
			mouseEnabled = false;
			mouseChildren = true;
			
			_width = 0;
			_height = 0;
			_spacing = Factory.ELEMENT_SPACING;
		}
		
		override public function destroy():void
		{
			if( items )
			{
				items.slice( 0 );
				
				while ( numChildren > 0 )  
				{
					var element:InterfaceElement = removeChildAt( 0 ) as InterfaceElement;
					element.destroy();
				}
			}
			
			if( parent ) parent.removeChild( this );
		}
	}
}