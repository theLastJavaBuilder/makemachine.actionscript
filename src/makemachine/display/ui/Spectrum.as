package makemachine.display.ui
{
	import flash.display.*;
	import flash.events.Event;
	import flash.geom.Rectangle;
	import flash.media.SoundMixer;
	import flash.utils.ByteArray;
	
	import makemachine.display.InterfaceElement;
	import makemachine.display.shapes.RectangleShape;
	import makemachine.parameters.*;
	
	public class Spectrum extends InterfaceElement
	{
		public function Spectrum( container:DisplayObjectContainer=null, xpos:Number=0, ypos:Number=0 )
		{
			super( container, xpos, ypos );	
		}
		
		// -------------------------------------------------------
		//
		//	-- properties
		//
		// -------------------------------------------------------
		
		protected var background:RectangleShape;
		protected var lineMask:RectangleShape;
		protected var line:Shape;
		protected var spectrumBackground:RectangleShape;
		
		// -------------------------------------------------------
		//	-- getter/setter
		// -------------------------------------------------------
		
		protected var _fourierTransform:BoolParameter;
		public function get fourierTransform():BoolParameter { return _fourierTransform; }
		
		protected var _stretchFactor:Parameter;
		public function get stretchFactor():Parameter { return _stretchFactor; }
		
		// -------------------------------------------------------
		//
		//	-- public
		//
		// -------------------------------------------------------
		
		// -------------------------------------------------------
		//	-- overrides
		// -------------------------------------------------------
		
		override public function toString():String { return 'Spectrum'; }
		
		// -------------------------------------------------------
		//
		//	-- protected
		//
		// -------------------------------------------------------
		
		// -------------------------------------------------------
		//	-- event handlers
		// -------------------------------------------------------
		
		protected function onEnterFrame( event:Event ):void 
		{
			var g:Graphics = line.graphics;
			g.clear();
			g.lineStyle( 1, Factory.METER_FILL_COLOR_1, 1 );
			
			var ypos:int = Factory.ELEMENT_PADDING + Math.round( spectrumBackground.height * .5 );
			
			g.moveTo( Factory.ELEMENT_PADDING, ypos );
			g.lineTo( spectrumBackground.width, ypos );
			
			if( !SoundMixer.areSoundsInaccessible() )
			{
				var bytes:ByteArray = new ByteArray();
				SoundMixer.computeSpectrum( bytes, _fourierTransform.value, _stretchFactor.value );
				g.moveTo( Factory.ELEMENT_PADDING, ypos );
				
				var i:int = 0;
				var n:Number;
				var inc:Number = spectrumBackground.width / 256;
				
				for( i; i < 256; i++) 
				{
					n = bytes.readFloat();
					g.lineTo( Factory.ELEMENT_PADDING + ( i * inc ), ypos - ( n * ypos ) );
				}
				
				g.moveTo( Factory.ELEMENT_PADDING, ypos );
				
				for( i = 0; i < 256; i++) 
				{
					n = bytes.readFloat();
					g.lineTo( Factory.ELEMENT_PADDING + ( i * inc ), ypos + ( n * ypos ) );
				}
			}

			line.mask = lineMask;
		}
		
		// -------------------------------------------------------
		//	-- overrides
		// -------------------------------------------------------
		
		override protected function create():void
		{
			super.create();
			
			_stretchFactor = new Parameter( 'Stretch Factor', 0, 40, 10 );
			_fourierTransform = new BoolParameter( 'Fourier', false );
			
			_width = Factory.PANEL_WIDTH_LG * 2
			_height = Factory.PANEL_WIDTH_LG;
			
			background = Factory.defaultBackground( this, 0, 0 );
			background.setSize( _width, _height );
			
			line = new Shape();
			addChild( line );
			
			lineMask = new RectangleShape( this, Factory.ELEMENT_PADDING, Factory.ELEMENT_PADDING );
			lineMask.setSize( _width - ( Factory.ELEMENT_PADDING * 2 ), _height - ( Factory.ELEMENT_PADDING * 2 ) );
			
			spectrumBackground = new RectangleShape( this, Factory.ELEMENT_PADDING, Factory.ELEMENT_PADDING );
			spectrumBackground.fillColor = Factory.METER_FILL_COLOR_2;
			spectrumBackground.fillAlpha = .2;
			spectrumBackground.setLineStyle( 1, Factory.METER_FILL_COLOR_2, 1 );
			spectrumBackground.cornerRadius = Factory.BACKGROUND_CORNER_RADIUS;
			spectrumBackground.setSize( lineMask.width, lineMask.height );
			spectrumBackground.visible;
			
			addEventListener( Event.ENTER_FRAME, onEnterFrame );
		}
	}
}