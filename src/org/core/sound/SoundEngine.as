package org.core.sound
{
	import flash.media.SoundChannel;
	import flash.media.SoundMixer;
	import flash.media.SoundTransform;
	
	import sounds.*;

	public class SoundEngine
	{
		//SINGLETON
		private static var _instance:SoundEngine = null;
		
		public static function GetInstance(): SoundEngine {
			if (_instance==null) {
				_instance = new SoundEngine();
			}
			return _instance;
		}
		
		public function SoundEngine() {
			
		}
		//END SINGLETON
		private var _channel:SoundChannel;
		
		private var _clickSound:Click;
		private var _alert1:Alert1;
		private var _alert2:Alert2;
		private var _alert3:Alert3;
		
		public function Initialize():void {
			_channel = new SoundChannel();
			_clickSound = new Click();
			_alert1 = new Alert1();
			_alert2 = new Alert2();
			_alert3 = new Alert3();
		}
		
		public function PlayClick(): void {
			_channel = _clickSound.play();
			
			var t:SoundTransform = _channel.soundTransform;
			t.volume = 1;
			_channel.soundTransform = t;
		}
		
		public function PlayOpenAlert(): void {
			_channel = _alert1.play();
			
			var t:SoundTransform = _channel.soundTransform;
			t.volume = 0.5;
			_channel.soundTransform = t;
		}
		
		public function PlayCorrect(): void {
			_channel = _alert2.play();
			
			var t:SoundTransform = _channel.soundTransform;
			t.volume = 0.5;
			_channel.soundTransform = t;
		}
		
		public function PlayError(): void {
			_channel = _alert3.play();
			
			var t:SoundTransform = _channel.soundTransform;
			t.volume = 0.5;
			_channel.soundTransform = t;
		}
	}
}