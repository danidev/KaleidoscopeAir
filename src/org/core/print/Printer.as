package org.core.print
{
	import flash.display.BitmapData;
	import flash.display.DisplayObject;
	import flash.display.NativeWindowType;
	import flash.display.Sprite;
	import flash.display.Stage;
	import flash.display.StageDisplayState;
	import flash.geom.Matrix;
	import flash.printing.PrintJob;
	import flash.printing.PrintJobOptions;
	
	import org.core.utils.Drawings;

	public class Printer {
		
		//SINGLETON
		private static var _instance:Printer = null;
		
		public static function GetInstance(): Printer {
			if (_instance==null) {
				_instance = new Printer();
			}
			return _instance;
		}
		
		public function Printer() {
			
		}
		//END SINGLETON
		
		private var _stage:Stage;
		
		public function Initialize(stage:Stage): void {
			_stage = stage;
		}
		
		public function PrintMovie(target:Sprite,header:Sprite): void {
			
			var printHeader:Sprite = flatSprite(header);
			var printTarget:Sprite = flatSprite(target);
			
			var printPage:Sprite = new Sprite();
			printPage.addChild(printHeader);
			printPage.addChild(printTarget);
			printTarget.y = printHeader.height;
			
			var printer:PrintJob = new PrintJob();
			var opt:PrintJobOptions = new PrintJobOptions(false);
			
			var printerStarted:Boolean = printer.start();
			if (printerStarted) {
				if (printPage.width>printer.printableArea.width) {
					var scale:Number = printer.pageWidth/printPage.width;
					printPage.scaleX = scale;
					printPage.scaleY = scale;
				}
				printer.addPage(printPage, null, opt);
				printer.send();
				target.scaleX = 1;
				target.scaleY = 1;
			}
	
			printer = null;
		}
		
		private function toBitmapData(target:Sprite): BitmapData {
			var bd:BitmapData = new BitmapData(target.width,target.height,true,0xFFFFFF);
			bd.draw(target);
			return bd;
		}
		
		private function toSprite(target:BitmapData): Sprite {
			var sprite:Sprite = new Sprite();
			sprite.graphics.clear();
			sprite.graphics.beginBitmapFill(target);
			sprite.graphics.drawRect(0,0,target.width,target.height);
			sprite.graphics.endFill();
			return sprite;
		}
		
		private function flatSprite(target:Sprite): Sprite {
			return toSprite(toBitmapData(target));
		}
	}
}