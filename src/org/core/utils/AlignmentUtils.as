package org.core.utils
{
	import flash.display.DisplayObject;

	public class AlignmentUtils
	{
		public static function AlignCenter(parent:DisplayObject,child:DisplayObject): void {
			child.x = (parent.width-child.width)/2;
			child.y = (parent.height-child.height)/2;
		}
	}
}