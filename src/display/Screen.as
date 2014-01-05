package display
{
	import com.greensock.TweenLite;
	
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.events.KeyboardEvent;
	import flash.net.URLLoader;
	import flash.net.URLRequest;
	import flash.ui.Keyboard;
	
	import org.core.utils.Drawings;
	
	public class Screen extends Sprite
	{
		private var _black:Sprite;
		private var _surface:Sprite;
		private var _kaleidoscopes:Array;
		
		private var _toggle:Boolean;
		private var _current:int;
		
		private var _configLoader:URLLoader;
		
		private var _console:Console;
		
		public function Screen()
		{
			super();
			Init();
		}
		
		public function SetupKeyboardCommands(): void {
			stage.addEventListener(KeyboardEvent.KEY_DOWN,keyDown);
		}
		
		private function keyDown(evt:KeyboardEvent): void {
			trace(evt.keyCode);
			//var s:String = String.fromCharCode(evt.charCode);
			
			if (evt.keyCode == Keyboard.SPACE) {
				toggle();
			} else if (evt.keyCode == 112) {
				//F1 toggle console
				_console.visible = !_console.visible;
			} else if (evt.charCode>=48 && evt.charCode<=57) {
				_current = evt.charCode-48;
				toggle();
			}
		}
		
		private function toggle(): void {
			_toggle = !_toggle;
			
			if (_toggle) {
				TweenLite.to(_black,0.7,{alpha:1.0});
			} else {
				playNext();
				TweenLite.to(_black,2,{alpha:0.0});
			}
		}
		
		public function Init(): void {
			_toggle = true;
			_current = 0;
			
			_configLoader = new URLLoader();
			_configLoader.addEventListener(Event.COMPLETE, levelDataLoaded);
			_configLoader.load(new URLRequest("local/config.txt"));
		}
		
		private function levelDataLoaded(e:Event=null):void {
			initGfx();
			initKaleidoscopes(e.target.data.toString().split("\r\n"));
		}
		
		private function initGfx(): void {
			_surface = new Sprite();
			this.addChild(_surface);
			
			_black = new Sprite();
			Drawings.FilledRect(_black.graphics,0,0,KaleidoscopeAir.STAGE_WIDTH,KaleidoscopeAir.STAGE_HEIGHT,0x000000);
			this.addChild(_black);
			
			_console = new Console();
			this.addChild(_console);
			_console.SetText("");
			_console.visible = false;
		}
		
		private function initKaleidoscopes(arr:Array): void {	
			_kaleidoscopes = new Array();
			for each(var s:String in arr) {
				if (s.length>0) {
					var k:Kaleidos = new Kaleidos(KaleidoscopeAir.STAGE_WIDTH,KaleidoscopeAir.STAGE_HEIGHT);
					k.Load("local/images/"+s);
					_surface.addChild(k);
					_kaleidoscopes.push(k);
				}
			}
		}
		
		private function playNext(): void {
			for each(var k:Kaleidos in _kaleidoscopes) {
				k.Hide();
			}
			
			_kaleidoscopes[_current].Show();
			_console.SetText(_current+". "+_kaleidoscopes[_current].Path);
			
			_current = (_current+1)%_kaleidoscopes.length;
		}
	}
}