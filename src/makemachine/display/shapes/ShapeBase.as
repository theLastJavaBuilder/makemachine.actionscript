package makemachine.display.shapes
{
	import flash.display.*;
	import flash.events.*;
	import flash.geom.Matrix;
	
	import makemachine.display.InterfaceElement;
	
	public class ShapeBase extends InterfaceElement
	{
		public function ShapeBase( container:DisplayObjectContainer=null, xpos:Number=0, ypos:Number=0 )
		{
			super( container, xpos, ypos );
		}
		
		// ------------------------------------------------
		//
		//	-- properties
		//
		// ------------------------------------------------
		
		protected var g:Graphics;
		protected var shape:Shape;
		protected var hasTileFill:Boolean;
		protected var hasLineStyle:Boolean;
		protected var hasGradientFill:Boolean;
		protected var gradientMatrix:Matrix;
		protected var lineAlpha:Number;
		protected var lineColor:Number;
		protected var lineThickness:Number;
		
		// ------------------------------------------------
		//	-- getter/setter
		// ------------------------------------------------
		
		protected var _bitmapFill:BitmapData;
		public function set bitmapFill( bitmapData:BitmapData ):void 
		{
			if( bitmapData ) 
			{
				_bitmapFill = bitmapData;
				hasTileFill = true;
			} else {
				hasTileFill = false;
			}
		}
		
		public function set color( value:Object ):void 
		{
			if( value is uint ) {
				fillColor = value as uint;
			}
			
			if( value is Array ) {
				gradientColors = value as Array;
			}
			
			if( value is String ) 
			{
				var colors:Array = value.split( ',' );
				if( colors.length > 1 ) {
					gradientColors = colors;
				} else {
					fillColor = colors[0];
				}
			}
		}
		
		protected var _fillAlpha:Number;
		public function set fillAlpha( value:Number ):void 
		{
			if( value != _fillAlpha ) 
			{
				_fillAlpha = value
				invalidate();
			}
		}
		
		protected var _fillColor:uint;
		public function set fillColor( color:uint ):void 
		{
			if( !isNaN( color ) && color != _fillColor  ) 
			{
				_fillColor = color;
				hasGradientFill = false;
				invalidate();
			}
		}
		
		protected var _gradientAlphas:Array;
		public function set gradientAlphas( alphas:Array ):void
		{
			if( alphas.length > 1 && alphas != _gradientAlphas ) 
			{
				_gradientAlphas = alphas;
				invalidate();
			}
		}
		
		protected var _gradientColors:Array;
		public function set gradientColors( colors:Array ):void 
		{
			if( colors.length > 1 && colors != _gradientColors ) 
			{
				var i:int = 0;
				var length:int = colors.length;
				_gradientColors = colors;
				
				// -- alphas need to match in length
				// -- if you need custom alphas reset them
				if( _gradientAlphas.length != length ) 
				{
					for( i = 0; i < length; i++ ) 
					{
						_gradientAlphas[i] = 1;
					}
				}
				// -- ratios need to match in length
				// -- so create an even distribution of ratios
				if( _gradientRatios.length != length )
				{
					var n:Number = 0;
					var inc:Number = 255 / ( length -1 );
					for( i = 0; i < length; i++ )
					{
						_gradientRatios[i] = i * inc;
					}
				}
				
				hasGradientFill = true;
				invalidate();
			}
		}
		
		protected var _gradientRatios:Array;
		public function set gradientRatios( ratios:Array ):void 
		{
			if( ratios != _gradientRatios && ratios.length == _gradientColors.length ) 
			{
				_gradientRatios = ratios;
				invalidate();
			}
		}
		
		protected var _gradientRotation:Number;
		public function set gradientRotation( value:Number ):void 
		{
			if( value != _gradientRotation ) 
			{
				_gradientRotation = value;
				invalidate();
			}
		}
		
		protected var _gradientType:String;
		public function set gradientType( value:String ):void 
		{
			if( validateGradientType( value ) && value != _gradientType ) 
			{
				_gradientType = value;
				invalidate();
			}
		}
		
		
		
		// ------------------------------------------------
		//	-- methods
		// ------------------------------------------------
	
		public function clearLineStyle():void
		{
			if( hasLineStyle ) 
			{
				hasLineStyle = false;
				invalidate();
			}
		}
		
		public function setLineStyle( thickness:int, color:uint, lineAlphaValue:Number ):void
		{
			hasLineStyle = true;
			if( thickness != lineThickness || color != lineColor || lineAlpha != lineAlphaValue ) 
			{
				lineThickness = thickness;
				lineColor = color;
				lineAlpha = lineAlphaValue;
				invalidate();
			}
		}
		
		public function setSize(w:Number, h:Number):void 
		{
			if( w != _width || h != _height ) 
			{
				_width = w;
				_height = h;
				invalidate();
			}
		}
		
		// ------------------------------------------------
		//	-- overrides
		// ------------------------------------------------
		
		override public function destroy():void 
		{
			super.destroy();
			g.clear();
			graphics.clear();
			if( _bitmapFill ) 
			{
				_bitmapFill.dispose();
			}
		}
		
		override public function set height(value:Number):void 
		{
			if( value != _height ) 
			{
				_height = value;
				invalidate();
			}
		}
		
		override public function set width(value:Number):void 
		{
			if( value != _width ) 
			{
				_width = value;
				invalidate();
			}
		}
		
		override public function toString():String { return 'ShapeBase' };
		
		// ------------------------------------------------
		//
		//	-- protected
		//
		// ------------------------------------------------
		
		protected function validateGradientType( value:String ):Boolean
		{
			return value == GradientType.LINEAR || value == GradientType.RADIAL;
		}
		
		// ------------------------------------------------
		//	-- overrides
		// ------------------------------------------------
		
		override protected function create():void 
		{
			super.create();
			
			shape = new Shape();
			g = shape.graphics;
			hasTileFill = false;
			hasLineStyle = false;
			hasGradientFill = false;
			gradientMatrix = new Matrix();
			
			_fillAlpha = 1
			_fillColor = 0xFF0000;
			_gradientColors = [ 0xFFFFFFF ];
			_gradientAlphas = [1, 1];
			_gradientRatios = [ 0, 255 ];
			_width = _height = 0;
			
			_gradientRotation = Math.PI / 2;
			_gradientType = GradientType.LINEAR;	
			
			addChild( shape );
		}
		
		override protected function draw():void 
		{
			super.draw();
			g.clear();
			
			// create the fill
			if( hasTileFill ) 
			{
				g.beginBitmapFill( _bitmapFill, null, true, true );
			} 
			else 
			{
				if ( hasGradientFill ) 
				{
					gradientMatrix.createGradientBox( _width, _height, _gradientRotation );
					g.beginGradientFill( _gradientType, _gradientColors, _gradientAlphas, _gradientRatios, gradientMatrix );
				} else {
					g.beginFill( _fillColor, _fillAlpha  );
				}
			}
			
			if( hasLineStyle ) 
			{
				g.lineStyle( lineThickness, lineColor, 
							 lineAlpha, false, LineScaleMode.NONE,
							 CapsStyle.ROUND, JointStyle.ROUND  );
			}
		}
	}
}