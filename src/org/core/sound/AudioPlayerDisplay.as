package org.core.sound
{
	import assets.mp3Player;
	
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.events.MouseEvent;
	
	import org.core.events.GenericEvent;
	import org.core.utils.Drawings;
	
	public class AudioPlayerDisplay extends Sprite
	{
		private var _player:AudioPlayer;
		private var _asset:mp3Player;
		private var _btnBar:Sprite;
		
		public function AudioPlayerDisplay(player:AudioPlayer) {
			
			super();
			
			_player = player;
			_player.addEventListener(AudioPlayer.SONG_COMPLETE,songComplete);
			_player.addEventListener(AudioPlayer.TIMER_TIC,songUpdate);
			
			init();
		}
		
		private function init(): void {
			_asset = new mp3Player();
			_asset.btnPlayPause.gotoAndStop(1);
			_asset.btnPlayPause.buttonMode = true;
			_asset.btnPlayPause.addEventListener(MouseEvent.CLICK,toggleClick);
			
			_asset.btnStop.gotoAndStop(1);
			_asset.btnStop.buttonMode = true;
			_asset.btnStop.addEventListener(MouseEvent.CLICK,stopClick);
			
			_btnBar = new Sprite();
			Drawings.FilledRect(_btnBar.graphics,0,0,_asset.barBg.width,_asset.barBg.height,0x000000,0);
			_btnBar.x = _asset.barBg.x;
			_btnBar.y = _asset.barBg.y;
			_btnBar.buttonMode = true;
			_btnBar.addEventListener(MouseEvent.CLICK,barClick);
			
			_asset.addChild(_btnBar);
			
			this.addChild(_asset);
		}
		
		private function toggleClick(evt:MouseEvent): void {
			if (_player.IsPlaying) {
				_player.Pause();
				_asset.btnPlayPause.gotoAndStop(1);
			} else {
				_player.Play();
				_asset.btnPlayPause.gotoAndStop(2);
			}
		}
		
		private function stopClick(evt:MouseEvent): void {
			_asset.btnPlayPause.gotoAndStop(1);
			_player.Stop();
		}
		
		private function songComplete(evt:Event): void {
			_asset.btnPlayPause.gotoAndStop(1);
		}
		
		private function songUpdate(evt:GenericEvent): void {
			var pos:Number = evt.Data["position"];
			var len:Number = evt.Data["length"];
			
			var w:Number = (pos*(_asset.barBg.width))/len;
			_asset.barFg.width = w;
		}
		
		private function barClick(evt:MouseEvent): void {
			trace(evt.currentTarget.mouseX);
			
			if (_player.AudioLength>-1) {
				_player.Play(evt.currentTarget.mouseX*_player.AudioLength/_asset.barBg.width);
			}
		}
	}
}