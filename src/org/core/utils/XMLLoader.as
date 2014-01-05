package org.core.utils
{
	import org.core.events.GenericEvent;
	
	import flash.events.Event;
	import flash.events.EventDispatcher;
	import flash.events.IOErrorEvent;
	import flash.net.URLLoader;
	import flash.net.URLRequest;

	public class XMLLoader extends EventDispatcher {
		
		public static var XML_LOADED:String = "XML_LOADED";
		public static var XML_ERROR:String = "XML_ERROR";
		
		private var _loader:URLLoader;
		private var _xml:XML;
		
		public function XMLLoader(path:String="") {
			_xml = null;
			if (path!="") {
				Load(path);
			}
		}
		
		public function Load(path:String): void {
			_loader = new URLLoader();
			_loader.addEventListener(Event.COMPLETE, onComplete);
			_loader.addEventListener(IOErrorEvent.IO_ERROR, onError);
			_loader.load(new URLRequest(path));
		}
		
		private function onComplete(evt:Event): void {
			_xml = new XML(evt.target.data);
			dispatchEvent(new GenericEvent("XML_LOADED",_xml));
		}
		
		private function onError(evt:Event): void {
			dispatchEvent(new GenericEvent("XML_ERROR",_xml));
		}
		
		public function get Xml():XML {return _xml;}
	}
}