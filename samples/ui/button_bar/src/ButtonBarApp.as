package
{
	import flash.display.Sprite;
	import flash.events.Event;
	
	import makemachine.display.ui.Button;
	import makemachine.display.ui.ButtonBar;
	import makemachine.display.ui.icons.Icons;
	
	/**
	 * Button bar creates a horizontal row of buttons in which only one button can be selected at a time
	 * Buttons have their corners set so that outer buttons are rounded
	 * When a button is selected Event.SELECT is dispatched from the ButtonBar
	 * You can listen for this event and read the selectedIndex property from the ButtonBar to determin which button is selected
	 */
	[SWF( backgroundColor="0xCCCCCC", frameRate="60", width="295", height="50" ) ]
	public class ButtonBarApp extends Sprite
	{
		protected var bar:ButtonBar;
		
		public function ButtonBarApp()
		{
			var btn:Button;
			var buttons:Vector.<Button> = new Vector.<Button>();
			bar = new ButtonBar( this, 10, 10 );
			var icons:Vector.<Class> = Vector.<Class>( [ Icons.SineWaveIcon, 
														 Icons.TriangleWaveIcon, 
														 Icons.SquareWaveIcon, 
														 Icons.SawtoothDownIcon, 
														 Icons.SawtoothUpIcon, 
														 Icons.BatmanIcon, 
														 Icons.NoiseIcon ] );
			
			for( var i:int = 0; i < icons.length; i++ )
			{
				btn = new Button();
				btn.setIcon( new icons[i]() );
				buttons.push( btn );
			}
			
			bar.setContent( buttons );
			bar.setExplicitButtonSize( 30, 30 ); // -- buttons will auto size without setting an explicit size
			bar.addEventListener( Event.SELECT, onButtonBarSelect );
		}
		
		protected function onButtonBarSelect( event:Event ):void 
		{
			trace( bar.selectedIndex );
		}
	}
}