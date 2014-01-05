package display
{
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.events.EventDispatcher;
	import flash.events.IOErrorEvent;
	import flash.events.ProgressEvent;
	import flash.media.Sound;
	import flash.media.SoundChannel;
	import flash.media.SoundMixer;
	import flash.media.SoundTransform;
	import flash.net.URLRequest;
	import flash.utils.ByteArray;
	
	public class Mp3 extends EventDispatcher {
		
		private var _path:String;
		private var _sound:Sound;
		private var _song:SoundChannel;
		//private var _timer:Timer;
		private var _loadingWidth:Number;
		private var _downloadComplete:Boolean;
		
		public function Mp3(path:String) {
			Init(path);
		}
		
		public function Init(path:String): void {
			_path = path;
			
			_downloadComplete = false;
			var link:URLRequest = new URLRequest(_path);
			_sound = new Sound();
			_sound.addEventListener(Event.COMPLETE, sound_complete);
			_sound.addEventListener(Event.ID3, sound_id3);
			_sound.addEventListener(IOErrorEvent.IO_ERROR, sound_error);
			_sound.addEventListener(ProgressEvent.PROGRESS, sound_progress);
			_sound.load(link);
			
			playSong(0);
			
			/*setupAndPlay();
			setupScrollingDisplay();
			setupSpectrumDisplay();
			_timer = new Timer(33);
			_timer.addEventListener(TimerEvent.TIMER,timer_tic);
			_timer.start();*/
		}
		
		private function sound_complete(e:Event): void {
			_downloadComplete = true;
			_sound.removeEventListener(Event.COMPLETE, sound_complete);
			_sound.removeEventListener(Event.ID3, sound_id3);
			_sound.removeEventListener(IOErrorEvent.IO_ERROR, sound_error);
			_sound.removeEventListener(ProgressEvent.PROGRESS, sound_progress);
		}
		
		private function sound_id3(e:Event): void {
			//tbInfo.text = e.currentTarget.id3.songName; //+" ("+e.currentTarget.id3.artist+")";
		}
		
		private function sound_error(e:IOErrorEvent): void {
			trace("[Mp3] sound_error");
		}
		
		private function sound_progress(e:ProgressEvent): void {
			//_loadingWidth = (e.bytesLoaded*_scrollingGfx.width)/e.bytesTotal;
		}
		
		private function song_complete(e:Event): void {
			playSong(0);
			_song.stop();
		}
		
		private function playSong(time:Number): void {
			trace("[Mp3] playSong");
			if (_song != null) {
				_song.removeEventListener(Event.SOUND_COMPLETE, song_complete);
			}
			
			_song = _sound.play(time);
			
			var t:SoundTransform = _song.soundTransform;
			t.volume = 1;
			_song.soundTransform = t;
			_song.addEventListener(Event.SOUND_COMPLETE, song_complete);
		}
		
		public function DrawSpectrum(sprite:Sprite,w:int,h:int,color:uint,thickness:Number,alpha:Number): void {
			var ba:ByteArray = new ByteArray();
			SoundMixer.computeSpectrum(ba);
			sprite.graphics.clear();
			sprite.graphics.lineStyle(thickness,color,alpha);
			sprite.graphics.moveTo(0,h/2);
			//sprite.graphics.beginFill(color);
			for(var i:uint=0; i<256; i++) {
				var ypos:Number = ba.readFloat()*(h/2) + (h/2);
				var xpos:Number = w*i/256;
				//var cellW:Number = w/256;
				//var cellH:Number = h/256;
				//sprite.graphics.drawRect(xpos, ypos, cellW, cellH);
				sprite.graphics.lineTo(xpos,ypos);
			}
		}
	}
}