package
{
	import flash.display.Sprite;
	
	import makemachine.display.ui.Button;
	import makemachine.display.ui.icons.Icons;
	
	/**
	 * The Button class can have an icon used instead of a text label
	 * See makemachine.display.ui.icons for list available icons
	 * Icons tinted to the primary and secondary text colors
	 */
	public class IconButtonApp extends Sprite
	{
		public function IconButtonApp()
		{
			var btn:Button = new Button( this, 10, 10 );
			btn.setIcon( new Icons.PauseIcon() ) ;
			btn.callback = helloButton;
			btn.data = "Generic data object attached to button";
		}
		
		protected function helloButton( btn:Button ):void 
		{
			trace( btn.data );
		}
	}
}