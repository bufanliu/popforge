package de.popforge.interpolation
{
	import de.popforge.parameter.IMapping;
	
	import flash.geom.Point;
	
	public final class InterpolationCubic extends Interpolation
	{
		/**
		 * Creates a new InterpolationLinear object.
		 * 
		 * @param mapping The IMapping object used to map the normalized value.
		 */			
		public function InterpolationCubic( mapping: IMapping = null )
		{
			super( mapping );
		}
		
		/**
		 * Calculates the cosine interpolated value <em>y</em> for <em>x</em> based on the control points.
		 * 
		 * @param x Normalized position on the <em>x</em>-axis.
		 * @return The <em>y</em> value at given position <em>x</em>.
		 * 
		 */	
		override protected function interpolate( x: Number ): Number
		{
			var index: uint = findPointBefore( x );
			
			var p0: Point;
			var p1: Point = points[ index ];
			var p2: Point;
			var p3: Point;
			
			if ( ( index - 1 ) < 0 )
			{
				p0 = points[ int( 0 ) ];
			}
			else
			{
				p0 = points[ int( index - 1 ) ];
			}
			
			if ( ( index + 1 ) == numPoints )
			{
				p2 = p1;
				p3 = p1;
			}
			else
			{
				p2 = points[ int( index + 1  )];
				
				if ( ( index + 2 ) == numPoints )
				{
					p3 = p2;
				}
				else
				{
					p3 = points[ int( index + 2 ) ];
				}
			}
			
			var y: Number;
			var t: Number = ( x - p1.x ) / ( p2.x - p1.x );
			
			if ( index == 0 || index >= ( numPoints - 2 ) )
			{
				// Interpolate linear between first two and last two points.
				y = p1.y + ( p2.y - p1.y ) * t;
			}
			else
			{
				// Cubic interpolation between the rest
				var p: Number = ( p3.y - p2.y ) - ( p0.y - p1.y );
				var q: Number = ( p0.y - p1.y ) - p;
				var r: Number = p2.y - p0.y;
				var s: Number = p1.y;
				
				y = p * t * t * t + q * t * t + r * t + s;
			}
			
			return clamp( y );
		}
		
		/**
		 * Creates the string representation of the current object.
		 * @return The string representation of the current object.
		 * 
		 */	
		override public function toString(): String
		{
			return '[InterpolationCubic]';
		}		
	}
}