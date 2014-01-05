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
			//trace("CreateLoader "+url);
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