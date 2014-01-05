package org.core.utils
{
	import flash.display.Graphics;

	public class Drawings
	{
		public static function OutlineRect(target:Graphics,x:int,y:int,width:int,height:int,color:uint,thickness:Number=1.0): void {
			target.lineStyle(thickness,color,1.0,true);
			target.moveTo(x,y);
			target.lineTo(x+width,y);
			target.lineTo(x+width,y+height);
			target.lineTo(x,y+height);
			target.lineTo(x,y);
		}
		
		public static function FilledRect(target:Graphics,x:int,y:int,width:int,height:int,color:uint,alpha:Number=1.0): void {
			target.beginFill(color,alpha);
			target.drawRect(x,y,width,height);
			target.endFill();
		}
		
		public static function FilledCircle(target:Graphics,x:int,y:int,radius:int,color:uint,alpha:Number=1.0): void {
			target.beginFill(color,alpha);
			target.drawCircle(x,y,radius);
			target.endFill();
		}
		
		public static function DrawLine(target:Graphics,x:int,y:int,width:int,height:int,color:uint,thickness:Number=1.0): void {
			target.lineStyle(thickness,color,1.0,true);
			target.moveTo(x,y);
			target.lineTo(x+width,y+height);
		}
	}
}