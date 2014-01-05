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
package
{
	import display.Console;
	import display.Kaleidos;
	import display.Mp3;
	import display.Screen;
	
	import flash.display.Sprite;
	import flash.display.StageAlign;
	import flash.display.StageDisplayState;
	import flash.display.StageScaleMode;
	import flash.ui.Mouse;
	
	[SWF(width="800", height="600", frameRate="30", backgroundColor="#000000")]
	public class KaleidoscopeAir extends Sprite
	{
		public static var STAGE_WIDTH:int;
		public static var STAGE_HEIGHT:int;
		
		public function KaleidoscopeAir()
		{
			initStage();
			
			var s:Screen = new Screen();
			this.addChild(s);
			s.SetupKeyboardCommands();
		}
		
		private function initStage(): void {
			stage.scaleMode = StageScaleMode.NO_SCALE;
			stage.align = StageAlign.TOP_LEFT;
			
			stage.displayState = StageDisplayState.FULL_SCREEN_INTERACTIVE;

			STAGE_WIDTH = stage.nativeWindow.width;
			STAGE_HEIGHT = stage.nativeWindow.height;
			
			Mouse.hide();
		}
	}
}