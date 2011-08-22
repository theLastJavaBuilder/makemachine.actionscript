package makemachine.utils
{
	import flash.geom.Point;
	
	/**
	 * Creates a grid of points from left - right / top - bottom in fixed size cells based on number of colums
	 */
	public function grid( cellCount:int, cellWidth:int, cellHeight:int, columns:int ):Vector.<Point>
	{
		var newRow:Boolean;
		var xpos:Number = 0;
		var ypos:Number = 0;
		var points:Vector.<Point> = new Vector.<Point>();
		
		for ( var i:int = 0; i < cellCount; i++ )
		{
			points.push( new Point( xpos, ypos ) );
			newRow = xpos + cellWidth >= cellWidth * columns ? true : false;
			xpos = newRow ? 0 : xpos + cellWidth;
			ypos = newRow ? ypos + cellHeight : ypos;
		}
		
		return points;
	}
}