package makemachine.display.text
{
	import flash.display.*;
	import flash.events.*;
	import flash.geom.Rectangle;
	import flash.text.*;
	
	import makemachine.display.InterfaceElement;
	import makemachine.display.text.fonts.Fonts;
	
	public class BitmapText extends InterfaceElement
	{
		protected var field	:TextField;
		protected var sprite:Sprite;
		protected var clone	:Bitmap;
		
		public function BitmapText( container:DisplayObjectContainer = null, xpos:Number = 0, ypos:Number = 0 ) 
		{
			super( container, xpos, ypos );
		}
		
		// ------------------------------------------------
		//
		//	 -- properties
		//
		// ------------------------------------------------
		
		// ------------------------------------------------
		//	 -- getter/setter
		// ------------------------------------------------
		
		public function set antiAliasType( value:String ):void 
		{
			if( value != field.antiAliasType ) 
			{
				field.antiAliasType = value;
				invalidate();
			}
		}
		
		public function set autoSize( value:String ):void 
		{
			if( value != field.autoSize ) 
			{
				field.autoSize = value;
				invalidate();
			}
		}	
		
		public function set background( value:Boolean ):void 
		{
			if( value != field.background ) 
			{
				field.background = value;
				invalidate();
			}
		}
	
		public function set backgroundColor( value:uint ):void 
		{
			if( value != field.backgroundColor ) 
			{
				field.backgroundColor = value;
				invalidate();
			}
		}
		
		public function set border( value:Boolean ):void 
		{
			if( value != field.border ) 
			{
				field.border = value;
				invalidate();
			}
		}
		
		public function set borderColor( value:uint ):void 
		{
			if( value != field.borderColor ) 
			{
				field.borderColor = value;
				invalidate();
			}
		}
	
		public function set condenseWhite( value:Boolean ):void 
		{
			if( value != field.condenseWhite ) 
			{
				field.condenseWhite = value;
				invalidate();
			}
		}
		
		public function set explicitWidth( value:Number ):void 
		{
			if( value != field.width ) 
			{
				field.width = _width = value;
				invalidate();
			}
		}
		
		public function set explicitHeight( value:Number ):void 
		{
			if( value != field.height ) 
			{
				field.height = _height = value;	
				invalidate();
			}
		}
		
		public function set gridFitType( value:String ):void 
		{
			if( value != field.gridFitType ) 
			{
				field.gridFitType = value;
				invalidate();
			}
		}
		
		private var _length:int;
		public function get length():int { return ( field ) ? field.length : 0; }
		
		public function set multiline( value:Boolean ):void 
		{
			if( value != field.multiline ) 
			{
				field.multiline = value;
				invalidate();
			}
		}
		
		private var _numLines:int;
		public function get numLines():int { return  ( field ) ? field.numLines : 0; }
		
		public function set sharpness( value:Number ):void  
		{
			if( value != field.sharpness ) 
			{
				field.sharpness = value;	
				invalidate();
			}
		}
		
		public function setStyleSheet( newStyleSheet:StyleSheet ):void 
		{
			if( newStyleSheet != field.styleSheet ) 
			{
				field.styleSheet = newStyleSheet;
				invalidate();
			}
		}
		
		protected var _styleName:String;
		public function setStyleName( stylename:String ):void 
		{
			_styleName = stylename;
			updateText();
			measure();
			invalidate();
		}
	
		protected var _text:String;
		public function get text():String { return field.text; }
		public function set text( value:String ):void 
		{	
			if( value != _text ) 
			{
				_text = value;
				updateText();
				measure();
				invalidate();
			}	
		}
		
		public function set textColor(value:uint):void 
		{
			if( value != field.textColor ) 
			{
				field.textColor = value;
				invalidate();
			}
		}
		
		private var _textWidth:Number;
		public function get textWidth():Number { return  ( field ) ? field.textWidth : 0; }
		
		private var _textHeight:Number;
		public function get textHeight():Number { return  ( field ) ? field.textHeight : 0; }
		
		public function set thickness (value:Number ):void 
		{
			if( value != field.thickness )
			{
				field.thickness = value;
				invalidate();
			}	
		}
		
		public function set wordWrap( value:Boolean ):void 
		{
			if( value != field.wordWrap ) 
			{
				field.wordWrap = value;
				invalidate();
			}
		}
		
		// ------------------------------------------------
		//
		//	 Public
		//
		// ------------------------------------------------
		
		public function appendText( newText:String ):void 
		{
			text = _text + newText;
		}
		
		// ------------------------------------------------
		//	 -- overrides
		// ------------------------------------------------
		
		override public function destroy():void 
		{
			if( clone && clone.bitmapData ) 
			{
				clone.bitmapData.dispose();
			}
		}
		
		override public function measure():Rectangle
		{
			if( created )
			{
				_width = field.width;
				_height = field.height;
			}
			return new Rectangle( x, y, _width, _height );
		}
		
		override public function toString():String { return "BitmapText"; }
		
		override public function set x( value:Number ):void 
		{
			if( value != super.x ) 
			{
				super.x = Math.round( value );
				invalidate();
			}
		}
		
		override public function set y( value:Number ):void 
		{
			if( value != super.y ) 
			{
				super.y = Math.round( value );
				invalidate();
			}
		}
		
		// ------------------------------------------------
		//
		//	-- protected
		//
		// ------------------------------------------------
		
		// ------------------------------------------------
		//	-- methods
		// ------------------------------------------------
		
		protected function updateText():void 
		{
			field.htmlText = '<span class="' + _styleName + '">' + _text + '</span>';
			invalidate();
		}
		
		// ------------------------------------------------
		//	-- overrides
		// ------------------------------------------------
		
		override protected function create():void 
		{
			super.create();
			
			mouseEnabled = false;
			cacheAsBitmap = true;
			
			sprite = new Sprite();
			
			field = new TextField();
			field.antiAliasType = AntiAliasType.ADVANCED;
			field.embedFonts = true;
			field.multiline = true;
			field.wordWrap = true;
			field.styleSheet = Fonts.defaultStyleSheet;
			field.mouseWheelEnabled = false;
			field.selectable = false;
			field.useRichTextClipboard = false;
			field.thickness = 100;
			field.sharpness = 100;	
		}
		
		override protected function draw():void
		{
			super.draw();
			
			updateText();
			
			if( !field.styleSheet ) 
			{
				field.styleSheet = Fonts.defaultStyleSheet;
			}
			
			if ( clone ) 
			{
				if ( clone.bitmapData ) clone.bitmapData.dispose();
				if( clone.parent ) clone.parent.removeChild( clone );
			}
			
			sprite.addChild( field );
			
			var bmd:BitmapData = new BitmapData( sprite.width, sprite.height, true, 0 );
			bmd.draw( sprite );
			
			if( field.parent ) field.parent.removeChild( field );
			
			clone = new Bitmap( bmd, PixelSnapping.ALWAYS, true );
			
			addChild( clone );
		}
	}
}