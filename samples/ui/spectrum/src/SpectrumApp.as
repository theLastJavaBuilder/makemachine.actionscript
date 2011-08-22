package
{
	import flash.display.Sprite;
	import flash.media.Sound;
	import flash.media.SoundChannel;
	
	import makemachine.display.ui.Button;
	import makemachine.display.ui.Slider;
	import makemachine.display.ui.Spectrum;
	import makemachine.display.ui.Toggle;
	import makemachine.display.ui.XBox;
	import makemachine.display.ui.YBox;
	import makemachine.display.ui.icons.Icons;
	
	[SWF( backgroundColor="0xCCCCCC", frameRate="60", width="440", height="160" )]
	public class SpectrumApp extends Sprite
	{
		protected var spectrum:Spectrum;
		protected var slider:Slider;
		protected var toggle:Toggle;
		protected var button:Button;
		
		protected var sound:Sound;
		protected var channel:SoundChannel;
		protected var playing:Boolean;
		
		[Embed(source="synth.mp3")]
		public static var Synth:Class;
		
		public function SpectrumApp()
		{
			var xbox:XBox = new XBox( this, 10, 10 );
			spectrum = new Spectrum( xbox );
			
			var ybox:YBox = new YBox( xbox );
			
			button = new Button( ybox );
			button.setIcon( new Icons.PlayIcon() );
			button.callback = toggleAudio;
			
			slider = new Slider( ybox );
			slider.parameter = spectrum.stretchFactor;
			
			toggle = new Toggle( ybox );
			toggle.parameter = spectrum.fourierTransform;
			
			sound = new Synth();
		}
		
		protected function toggleAudio( target:Button ):void
		{
			if( playing )
			{
				if( channel )
				{
					channel.stop();
				}
				playing = false;
				button.setIcon( new Icons.PlayIcon() );
			} else {
				playing = true;
				channel  = sound.play();
				button.setIcon( new Icons.StopIcon() );
			}
		}
	}
}