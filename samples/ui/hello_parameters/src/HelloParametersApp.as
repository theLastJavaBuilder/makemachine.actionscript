package
{
	import flash.display.Sprite;
	import flash.events.Event;
	
	import makemachine.display.ui.Knob;
	import makemachine.display.ui.Slider;
	import makemachine.parameters.Parameter;
	
	[SWF( backgroundColor="0xAAAAAA", frameRate="60", width="160", height="170" )]
	public class HelloParametersApp extends Sprite
	{
		public function HelloParametersApp()
		{
			var slider:Slider = new Slider( this, 10, 10 );
			
			// -- Notice how when the slider is adjusted the value turns from "Hz" to "kHz"
			var param1:Parameter = new Parameter( "Frequency", 200, 2000, 250 );
			param1.units = "Hz";
			param1.addEventListener( Event.CHANGE, onParamUpdate );
			slider.parameter = param1;
			slider.validate();
			
			var knob1:Knob = new Knob( this, slider.x, slider.y + slider.height + 5 );
			knob1.parameter = param1;
			knob1.validate();
			
			var knob2:Knob = new Knob( this, knob1.x + knob1.width + 1, knob1.y );
			var param2:Parameter = new Parameter( "Amplitude", 0.0, 1.0, .5 );
			knob2.parameter = param2;
			knob2.validate();
		}
		
		protected function onParamUpdate( event:Event ):void 
		{
			if( event.target is Parameter )
			{
				var param:Parameter = event.target as Parameter;
				trace( int( param.value ) );
			}
		}
	}
}