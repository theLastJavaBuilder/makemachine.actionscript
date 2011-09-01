package
{
	import flash.display.Sprite;
	
	import makemachine.display.ui.*;
	
	[SWF( backgroundColor="0xCCCCCC", frameRate="60", width="295", height="248" )]
	public class UICustomizationApp extends Sprite
	{
		public function UICustomizationApp()
		{
			var container:XBox = new XBox( this, 5, 5 );
			
			// -- gray and green
			Factory.BACKGROUND_COLOR = 0x333333;
			Factory.METER_FILL_COLOR_1 = 0xb4ff00;
			Factory.METER_FILL_COLOR_2 = 0x76a700;
			Factory.TEXT_COLOR_1 = 0xb4ff00
			Factory.TEXT_COLOR_2 = 0xffffff;	
			Factory.MOUSE_UP_COLOR = Factory.BACKGROUND_COLOR;
			Factory.MOUSE_OVER_COLOR = 0x555555
			Factory.BACKGROUND_CORNER_RADIUS = 0;
				
			var ybox:YBox 
			var xbox:XBox;
			
			ybox = new YBox( container );
			new Label( ybox ).setText( 'Customization' );
			new Slider( ybox );
			
			xbox = new XBox( ybox );
			new Knob( xbox ).parameter.name = 'Volume';
			new Knob( xbox ).parameter.name = 'Freq';
			
			new Toggle( ybox ).parameter.name = 'Mute';
			var btn:Button = new Button( ybox );
			btn.setText( 'Hello Button' );
			btn.setExplicitSize( Factory.PANEL_WIDTH_LG, btn.height );
			
			container.setSpacing( 5 );
			
			// -- blue and white, very round
			Factory.BACKGROUND_COLOR = 0xFFFFFF;
			Factory.METER_FILL_COLOR_1 = 0x71bbc9;
			Factory.METER_FILL_COLOR_2 = 0x61aab9;
			Factory.TEXT_COLOR_1 = 0x81ccd9
			Factory.TEXT_COLOR_2 = 0x555555;	
			Factory.MOUSE_UP_COLOR = Factory.BACKGROUND_COLOR;
			Factory.MOUSE_OVER_COLOR = 0xEEEEEE
			Factory.BACKGROUND_CORNER_RADIUS = 20;
			
			ybox = new YBox( container );
			new Label( ybox ).setText( 'Customization' );
			new Slider( ybox );
			
			xbox = new XBox( ybox );
			new Knob( xbox ).parameter.name = 'Volume';
			new Knob( xbox ).parameter.name = 'Freq';
			
			new Toggle( ybox ).parameter.name = 'Mute';
			btn = new Button( ybox );
			btn.setText( 'Hello Button' );
			btn.setExplicitSize( Factory.PANEL_WIDTH_LG, btn.height );
			
			
		}
	}
}