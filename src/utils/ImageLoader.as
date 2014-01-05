/**
 * KaleidoscopeAir - a visual application for the music performances of 
 * Space Aliens From Outer Space
 * Copyright (C) 2012 by Daniele Pagliero
 * 
 * This program is free software: you can redistribute it and/or modify
 * it under the terms of the GNU General Public License as published by
 * the Free Software Foundation, either version 3 of the License, or
 * (at your option) any later version.
 * 
 * This program is distributed in the hope that it will be useful,
 * but WITHOUT ANY WARRANTY; without even the implied warranty of
 * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
 * GNU General Public License for more details.
 * 
 * You should have received a copy of the GNU General Public License
 * along with this program.  If not, see <http://www.gnu.org/licenses/>.
 * 
 * */
package utils
{
	import flash.display.Loader;
	import flash.events.Event;
	import flash.events.IOErrorEvent;
	import flash.net.URLRequest;
	import flash.system.LoaderContext;

	public class ImageLoader
	{
		public static function CreateLoader(url:String,complete:Function,error:Function): Loader {
			var context:LoaderContext = new LoaderContext();
			context.checkPolicyFile = true;
			
			var loader:Loader = new Loader();
			loader.contentLoaderInfo.addEventListener(Event.COMPLETE, complete);
			loader.contentLoaderInfo.addEventListener(IOErrorEvent.IO_ERROR,error);
			loader.load(new URLRequest(url),context);
			return loader;
		}
		
		public static function RemoveHandlers(loader:Loader,complete:Function): void {
			loader.contentLoaderInfo.removeEventListener(Event.COMPLETE, complete);
		}
	}
}