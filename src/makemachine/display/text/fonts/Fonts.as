package makemachine.display.text.fonts
{
	import flash.text.StyleSheet;

	public class Fonts
	{
		[Embed(source="Droid_Sans/DroidSans.ttf", embedAsCFF="false", fontName="default", mimeType="application/x-font")]
		public static const DefaultFont:Class;
		
		protected static var _defaultStyleSheet:StyleSheet;
		public static function get defaultStyleSheet():StyleSheet { return _defaultStyleSheet; }
		
		protected static var styles:String = '.h1{' +
											 	'font-family: default;' +
												'font-size: 14px;' +
											 '}' +
											 '.primary{' +
											 	'font-family: default;' +
											 	'font-size: 12px;' +
											 '}' +
											 '.secondary{' +
											 	'font-family: default;' +
											 	'font-size: 10px;' +
											 '}'
		
		{	
			_defaultStyleSheet = new StyleSheet();
			_defaultStyleSheet.parseCSS( styles );
		}						
	}
}