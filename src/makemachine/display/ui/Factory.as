package makemachine.display.ui
{
	import flash.text.TextFieldAutoSize;
	import flash.display.DisplayObjectContainer;
	
	import makemachine.display.text.BitmapText;
	import makemachine.display.shapes.RectangleShape;
	import makemachine.parameters.Parameter;

	public class Factory
	{
		// -- padding inside an element
		public static var ELEMENT_PADDING:int = 5; 
		
		// -- space between components in xbox & ybox
		public static var ELEMENT_SPACING:int = 5; 
		
		// -- element sizes
		public static const PANEL_WIDTH_LG:int = 170;
		public static const PANEL_WIDTH_MD:int = ( PANEL_WIDTH_LG - ELEMENT_SPACING ) * .5;
		public static const PANEL_WIDTH_SM:int = ( PANEL_WIDTH_LG - ELEMENT_SPACING * 3 ) * .25;
		
		// -- used for generating the default background
		public static var BACKGROUND_COLOR:uint = 0x111111;
		public static var BACKGROUND_ALPHA:Number = .8;
		public static var BACKGROUND_CORNER_RADIUS:int = 5;
		
		// -- fill colors for meter type objects, such as slider & knob gutters
		public static var METER_FILL_COLOR_1:uint = 0x00c6ff;
		public static var METER_FILL_COLOR_2:uint = 0x666666;
		
		// -- text colors
		public static var TEXT_COLOR_1:uint = 0x00c6ff;
		public static var TEXT_COLOR_2:uint = 0xCCCCCC;
		
		// -- button colors
		public static var MOUSE_UP_COLOR:uint = 0x111111;
		public static var MOUSE_OVER_COLOR:uint = 0x222222;
		public static var MOUSE_DOWN_COLOR:uint = 0x11111;
		
		/**
		 * Generates a default background shape
		 */
		public static function defaultBackground( container:DisplayObjectContainer, xpos:int = 0, ypos:int = 0 ):RectangleShape 
		{
			var r:RectangleShape = new RectangleShape( container, xpos, ypos );
			r.fillAlpha = BACKGROUND_ALPHA;
			r.fillColor = BACKGROUND_COLOR;
			r.cornerRadius = BACKGROUND_CORNER_RADIUS;
			return r;
		}
		
		/**
		 * Generates nicely formatted parameter text
		 */
		public static function formatParameterText( parameter:Parameter ):String 
		{
			var result:String;
			
			if( parameter.value > 1 ) 
			{
				if( parameter.value > 1000 )
				{
					result = ( parameter.value / 1000 ).toPrecision( 3 ) + ' k' + parameter.units;
				} else {
					result = parameter.value.toPrecision( 3 ) + ' ' + parameter.units;
				}
			} else {
				result = parameter.value.toFixed( 2 ) + ' ' + parameter.units;
			}
			
			return result;
		}
		
		/**
		 * Factory method for a single line bitmap text field
		 */
		public static function singleLineField( container:DisplayObjectContainer = null, xpos:int = 0, ypos:int = 0, stylename:String = '', initText:String = '' ):BitmapText 
		{
			var field:BitmapText = new BitmapText( container, xpos, ypos );
			field.multiline = field.wordWrap = false;
			field.autoSize = TextFieldAutoSize.LEFT;
			field.setStyleName( stylename );
			field.text = initText;
			return field;
		}
		
		/**
		 * Factory method for a multi line bitmap text field
		 */
		public static function multilineField( container:DisplayObjectContainer = null, xpos:int = 0, ypos:int = 0, w:int = 100, stylename:String = '', initText:String = '' ):BitmapText 
		{
			var field:BitmapText = new BitmapText( container, xpos, ypos );
			field.explicitWidth = w;
			field.multiline = field.wordWrap = true;
			field.autoSize = TextFieldAutoSize.LEFT;
			field.setStyleName( stylename );
			field.text = initText;
			return field;
		}
	}
}