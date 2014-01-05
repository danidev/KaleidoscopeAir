/**
 * KaleidoscopeAir - a visual application for the music performances of 
 * Space Aliens From Outer Space
 * Copyright (C) 2012 by Daniele Pagliero
 * 
 * This program is free software: you can redistribute it and/or modify
 * it under the terms of the GNU General Public License as published by
 * the Free Software Foundation, either version 3 of the License, or
 * (at your option) any later version.
 * 
 * This program is distributed in the hope that it will be useful,
 * but WITHOUT ANY WARRANTY; without even the implied warranty of
 * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
 * GNU General Public License for more details.
 * 
 * You should have received a copy of the GNU General Public License
 * along with this program.  If not, see <http://www.gnu.org/licenses/>.
 * 
 * */
package utils
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
	}
}