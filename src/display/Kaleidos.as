package display
{
	import flash.display.Bitmap;
	import flash.display.BitmapData;
	import flash.display.IBitmapDrawable;
	import flash.display.Loader;
	import flash.display.MovieClip;
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.filters.BlurFilter;
	import flash.geom.Matrix;
	
	import org.core.utils.ImageLoader;
	
	public class Kaleidos extends Sprite
	{
		private var hsize:Number;
		private var vsize:Number;
		private var diag:Number;
		private var map:BitmapData;
		private var mapHolder:MovieClip;
		private var code:MovieClip;
		private var image:BitmapData;
		private var stampImage:BitmapData;
		
		private var rotate1:Boolean;
		private var rotate2:Boolean;
		private var rotate3:Boolean;
		private var flip:Boolean;
		private var singleview:Boolean;
		private var slice:MovieClip;
		private var slices:Number;
		private var angle:Number;
		private var nudge:Number;
		private var rotspeed1:Number;
		private var rotspeed2:Number;
		private var rotspeed3:Number;
		private var sclfact:Number;
		private var rot:Number;
		private var r:Number;
		private var r2:Number;
		private var sh1:Number;
		private var sh2:Number;
		private var scl:Number;
		private var m:Matrix;
		
		private var _path:String;
		
		public function Kaleidos(w:int,h:int) {
			super();
			hsize = w;
			vsize = h;
		}
		
		public function Load(path:String): void {
			_path = path;
			ImageLoader.CreateLoader(path,onComplete,onError);
		}
		
		public function Show(): void {
			this.addEventListener(Event.ENTER_FRAME,onEnterFrame);
			this.visible = true;
		}
		
		public function Hide(): void {
			this.removeEventListener(Event.ENTER_FRAME,onEnterFrame);
			this.visible = false;
		}
		
		private function onComplete(e:Event): void {
			var loader:Loader = e.currentTarget.loader as Loader;
			ImageLoader.RemoveHandlers(loader,onComplete);
			this.addChild(loader);
			
			init(loader.content as Bitmap);
		}
		
		private function onError(e:Event): void {
			trace("path error: "+_path); 
			var loader:Loader = e.currentTarget.loader as Loader;
			ImageLoader.RemoveHandlers(loader,onComplete);
		}
		
		
		private function init(image:Bitmap): void {
			diag = Math.sqrt(2*hsize*hsize)*0.62;
			map = new BitmapData(hsize, vsize, true, 0x00000000);
			var bmap:Bitmap = new Bitmap();
			bmap.bitmapData = map;
			mapHolder = new MovieClip();
			mapHolder.addChild(bmap);
			this.addChild(mapHolder);

			stampImage = new BitmapData(image.width, image.height, false);
			stampImage.draw(image, new Matrix(0.5, 0, 0, 0.5, 0, 0), null, "normal", null, true);
			stampImage.draw(image, new Matrix(-0.5, 0, 0, 0.5, image.width, 0), null, "normal", null, true);
			stampImage.draw(image, new Matrix(0.5, 0, 0, -0.5, 0, image.height), null, "normal", null, true);
			stampImage.draw(image, new Matrix(-0.5, 0, 0, -0.5, image.width, image.height), null, "normal", null, true);
			
			rotate1 = true;
			rotate2 = true;
			rotate3 = true;
			flip = true;
			singleview = true;
			slice = new MovieClip();
			this.addChild(slice);
			slice._visible = false;
			slices = 12;
			angle = Math.PI/slices;
			nudge = 0.009;
			rotspeed1 = 0.007;
			rotspeed2 = -0.003;
			rotspeed3 = -0.005;
			sclfact = 0;
			rot = 0;
			r = 0;
			r2 = 0;
			sh1 = 0;
			sh2 = 0;
			scl = 1;
			m = new Matrix();
		}
		
		private function onEnterFrame(evt:Event): void {
			if (rotate1) {
				r += rotspeed1;
			}
			if (rotate2) {
				r2 -= rotspeed2;
			}
			if (rotate3) {
				rot += rotspeed3;
			}
			
			for (var i:int = 0; i<slices; i++) {
				m.identity();
				m.b += sh1;
				m.c += sh2;
				m.rotate(r2);
				m.translate(2*mouseX/scl, 2*mouseY/scl+i*sclfact*10);
				m.rotate(r);
				m.scale(scl, scl);
				slice.graphics.clear();
				slice.graphics.lineStyle();
				slice.graphics.moveTo(0, 0);
				slice.graphics.beginBitmapFill(stampImage, m);
				slice.graphics.lineTo(Math.cos((angle+nudge)-Math.PI/2)*diag, Math.sin((angle+nudge)-Math.PI/2)*diag);
				slice.graphics.lineTo(Math.cos(-(angle+nudge)-Math.PI/2)*diag, Math.sin(-(angle+nudge)-Math.PI/2)*diag);
				slice.graphics.lineTo(0, 0);
				slice.graphics.endFill();
				m.identity();
				if (flip && i%2 == 1) {
					m.scale(-1, 1);
				}
				m.rotate(rot+i*angle*2);
				m.translate(hsize*0.5, vsize*0.5);
				map.draw(slice, m, null, "normal", null, true);
			}
		}
		
		public function get Path():String {return _path;}
		
	}
}