package org.core.utils
{
	
	import flash.text.TextField;
	import flash.text.TextFieldAutoSize;
	import flash.text.TextFormat;

	public class TextUtils {
		public static var COLOR_BLUE:Number 		= 0x002245;
		public static var COLOR_WHITE:Number 		= 0xFFFFFF;
		public static var COLOR_LIGHT_BLUE:Number 	= 0x445D77;
		
		public static var COLOR_YELLOW:Number 		= 0xFDCA00;
		public static var COLOR_BLACK:Number		= 0x000000;
		public static var COLOR_RED:Number			= 0xDE0E04;
		
		
		public static function SetTextFormatBlue(tb:TextField): void {
			var tf:TextFormat = new TextFormat();
			tf.color = COLOR_BLUE;
			tb.setTextFormat(tf);
		}
		
		public static function SetTextFormatWhite(tb:TextField): void {
			var tf:TextFormat = new TextFormat();
			tf.color = COLOR_WHITE;
			tb.setTextFormat(tf);
		}
		
		public static function SetTextFormatLightBlue(tb:TextField): void {
			var tf:TextFormat = new TextFormat();
			tf.color = COLOR_LIGHT_BLUE;
			tb.setTextFormat(tf);
		}
		
		public static function SetTextFormatYellow(tb:TextField): void {
			var tf:TextFormat = new TextFormat();
			tf.color = COLOR_YELLOW;
			tb.setTextFormat(tf);
		}
		
		public static function SetTextFormatBlack(tb:TextField): void {
			var tf:TextFormat = new TextFormat();
			tf.color = COLOR_BLACK;
			tb.setTextFormat(tf);
		}
		
		public static function SetTextFormatRed(tb:TextField): void {
			var tf:TextFormat = new TextFormat();
			tf.color = COLOR_RED;
			tb.setTextFormat(tf);
		}
	}
}