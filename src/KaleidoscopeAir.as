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