package
{
	import flash.display.Sprite;
	
	import makemachine.display.ui.Knob;
	import makemachine.display.ui.Label;
	import makemachine.display.ui.Slider;
	import makemachine.display.ui.XBox;
	import makemachine.display.ui.YBox;
	
	/**
	 * Demonstrates the basic usage of XBox and YBox containers 
	 */
	[SWF( backgroundColor="0xCCCCCC", frameRate="60", width="150", height="190" )]
	public class ContainersApp extends Sprite
	{
		public function ContainersApp()
		{
			var ybox:YBox = new YBox( this, 5, 5 );
			
			// -- label size is based on constant values in the Factory class
			var label:Label = new Label( ybox );
			label.setText( "Controls" );
			
			// -- notice how the two knobs fit nicely below the label
			var xbox:XBox = new XBox( ybox, 0, 0 );
			
			var knob1:Knob = new Knob( xbox );
			var knob2:Knob = new Knob( xbox );
			
			var slider:Slider = new Slider( ybox );
		}
	}
}