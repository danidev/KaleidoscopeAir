package org.core.sound
{
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.events.EventDispatcher;
	import flash.events.IOErrorEvent;
	import flash.events.ProgressEvent;
	import flash.events.TimerEvent;
	import flash.media.Sound;
	import flash.media.SoundChannel;
	import flash.media.SoundMixer;
	import flash.media.SoundTransform;
	import flash.net.URLRequest;
	import flash.utils.ByteArray;
	import flash.utils.Timer;
	
	import org.core.events.GenericEvent;

	public class AudioPlayer extends EventDispatcher {
		
		public static var SONG_COMPLETE:String = "SONG_COMPLETE";
		public static var START_PLAY:String = "START_PLAY";
		public static var TIMER_TIC:String = "TIMER_TIC";
		
		private var _path:String;
		private var _sound:Sound;
		private var _channel:SoundChannel;

		private var _loadingWidth:Number;
		private var _downloadComplete:Boolean;
		
		private var _positionTimer:Timer;
		
		private var _isPlaying:Boolean;
		
		private var _pausePoint:Number;
		
		public function AudioPlayer() {
			_isPlaying = false;
			_pausePoint = 0;
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
			
			//playSong(0);
		}
		
		public function Play(pos:Number=-1): void {
			if (pos>-1) _pausePoint = pos;
			playSong(_pausePoint);
		}
		
		public function Stop(): void {
			try {
				_channel.stop();
			} catch (error:Error) {}
			
			try {
				_sound.close();
			} catch (error:Error) {}
			
			try {
			} catch (error:Error) {}
			
			_channel = null;
			_isPlaying = false;
			_pausePoint = 0;
		}
		
		public function Pause(): void {
			_pausePoint = _channel.position;
			_channel.stop();
			_isPlaying = false;
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
			_channel.stop();
			_pausePoint = 0;
			_isPlaying = false;
			dispatchEvent(new Event(SONG_COMPLETE));
		}
		
		private function playSong(time:Number): void {
			trace("[Mp3] playSong");
			if (_channel != null) {
				_channel.removeEventListener(Event.SOUND_COMPLETE, song_complete);
			}
			
			if (_isPlaying) {
				_channel.stop();
			}
			
			_channel = _sound.play(time);
			_isPlaying = true;
			
			var t:SoundTransform = _channel.soundTransform;
			t.volume = 1;
			_channel.soundTransform = t;
			_channel.addEventListener(Event.SOUND_COMPLETE, song_complete);
			
			//timer posizione riproduzione
			
			if (_positionTimer==null) {
				_positionTimer = new Timer(50);
				_positionTimer.addEventListener(TimerEvent.TIMER, positionTimer_Timer);
			}
			_positionTimer.start();
		}
		
		private function positionTimer_Timer(event:TimerEvent):void {
			if (_channel!=null && _sound!=null) {
				dispatchEvent(new GenericEvent(TIMER_TIC,{"position":_channel.position,"length":_sound.length}));
			} else {
				dispatchEvent(new GenericEvent(TIMER_TIC,{"position":0,"length":1}));
			}
			//var w = (_song.position*(_bgMovie.width))/_soundFactory.length;
			//_playingMovie.width = w;
			//_tbInfo.htmlText = _songTitle+" "+GetSongInfo();
		}
		
		public function get IsPlaying(): Boolean {return _isPlaying;}
		public function get AudioLength():Number {if (_sound!=null) return _sound.length else return -1;}
	}
}