package
{
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.media.Sound;
	import flash.media.SoundChannel;
	import flash.media.SoundTransform;
	
	import makemachine.display.ui.*;
	import makemachine.display.ui.icons.Icons;
	import makemachine.parameters.Parameter;
	
	[SWF( backgroundColor="0xCCCCCC", frameRate="60", width="423", height="145" )]
	public class SpectrumApp extends Sprite
	{
		protected var spectrum:Spectrum;
		protected var stretch:Slider;
		protected var volume:Slider;
		protected var toggle:Toggle;
		protected var button:Button;
		
		protected var sound:Sound;
		protected var channel:SoundChannel;
		protected var playing:Boolean;
		
		[Embed(source="synth.mp3")]
		public static var Synth:Class;
		
		public function SpectrumApp()
		{
			var xbox:XBox = new XBox( this, 1, 1 );
			spectrum = new Spectrum( xbox );
			
			var ybox:YBox = new YBox( xbox );
			
			stretch = new Slider( ybox );
			stretch.parameter = spectrum.stretchFactor;
			
			toggle = new Toggle( ybox );
			toggle.parameter = spectrum.fourierTransform;
			
			volume = new Slider(ybox);
			volume.parameter = new Parameter( 'Volume', 0, 1, .5 );
			volume.parameter.addEventListener( Event.CHANGE, onVolumeUpdate );
			
			sound = new Synth();
			
			button = new Button( ybox );
			button.setIcon( new Icons.PlayIcon() );
			button.callback = toggleAudio;
			button.setExplicitSize( Factory.PANEL_WIDTH_LG, button.height );
		}
		
		protected function toggleAudio( target:Button = null ):void
		{
			if( playing )
			{
				if( channel )
				{
					channel.stop();
					channel.removeEventListener( Event.SOUND_COMPLETE, onSoundComplete );
				}
				playing = false;
				button.setIcon( new Icons.PlayIcon() );
			} else {
				playing = true;
				channel  = sound.play();
				channel.addEventListener(Event.SOUND_COMPLETE, onSoundComplete );
				button.setIcon( new Icons.StopIcon() );
			}
		}
		
		protected function onVolumeUpdate( event:Event ):void 
		{
			if( channel )
			{
				channel.soundTransform = new SoundTransform( volume.parameter.value );
			}
		}
		
		protected function onSoundComplete( event:Event ):void 
		{
			toggleAudio();
		}
	}
}