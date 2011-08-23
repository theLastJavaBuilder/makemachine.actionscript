package
{
	import flash.display.Sprite;
	
	import makemachine.display.ui.Button;
	
	/**
	 * Adding a Button element to the stage is very simple
	 * You can add a callback to a button that will be triggered when it is pressed
	 * Arbitrary data objects of any type can be attached to buttons
	 */
	[SWF( backgroundColor="0xCCCCCC", frameRate="60", width="110", height="50" )]
	public class HelloButtonApp extends Sprite
	{
		public function HelloButtonApp()
		{
			var btn:Button = new Button( this, 10, 10 );
			btn.setText( "Hello Button" );
			btn.callback = helloButton;
			btn.data = "Generic data object attached to button";
		}
		
		protected function helloButton( btn:Button ):void 
		{
			trace( btn.data );
		}
	}
}