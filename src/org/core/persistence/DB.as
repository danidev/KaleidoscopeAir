package org.core.persistence
{
	import flash.events.Event;
	import flash.events.EventDispatcher;
	import flash.events.IOErrorEvent;
	import flash.filesystem.File;
	import flash.filesystem.FileMode;
	import flash.filesystem.FileStream;
	import flash.net.FileReference;

	public class DB extends EventDispatcher
	{
		//SINGLETON
		private static var _instance:DB;
		
		public static function GetInstance():DB {
			if (_instance==null) {
				_instance = new DB();
			}
			return _instance;
		}
		
		public function DB(){}
		//END SINGLETON
		
		private var _file:File;
		private var _stream:FileStream;
		private var _records:Array;
		
		public function Init(): void {
			_file =  File.applicationStorageDirectory.resolvePath("saves.txt");
			//trace("file::: "+_file.nativePath);
			
			if (!_file.exists) {
				var stream:FileStream = new FileStream();
				stream.open(_file,FileMode.WRITE);
				stream.close();
			}
			
			
		}
		
		public function Load(): void {
			_stream = new FileStream();
			_stream.openAsync(_file, FileMode.READ);
			_stream.addEventListener(Event.COMPLETE, streamComplete);
			_stream.addEventListener(IOErrorEvent.IO_ERROR, streamError);
		}
		
		public function AddField(key:String,value:String): void {
			SetValue(key,value);
		}
		
		public function GetValue(key:String): String {
			
			for each (var field:Record in _records) {
				if (field.Key==key) {
					//trace("[DB] GetValue "+key+": "+field.Value);
					return field.Value;
				} 
			}
			//trace("[DB] GetValue "+key+": not found");
			return "";
		}
		
		public function SetValue(key:String,value:String): void {
			//trace("[DB] SetValue "+key+": "+value);
			var found:Boolean = false;
			for each (var record:Record in _records) {
				if (record.Key==key) {
					record.Value = value;
					found = true;
					break;
				}
			}
			
			if (!found) {
				_records.push(new Record(key,value));
			}
		}
		
		public function RemoveField(key:String): void {
			var newFields:Array = new Array();
			
			for each (var field:Record in _records) {
				if (field.Key!=key) newFields.push(field);
			}
			
			_records = newFields;
		}
		
		public function get Records(): Array {return _records;} 
		
		public function Save(): void {
			var stream:FileStream = new FileStream();
			stream.open(_file,FileMode.WRITE);
			
			var output:String = "";
			for each(var r:Record in _records) {
				output += r.CreateTxt();
			}
			
			stream.writeUTFBytes(output);
			
			stream.close();
		}
		
		public function Drop(): void {
			_records = new Array();
			Save();
		}
		
		private function streamComplete(event:Event):void 
		{
			var str:String = _stream.readUTFBytes(_stream.bytesAvailable);
			_stream.close();
			var lineEndPattern:RegExp = new RegExp(File.lineEnding, "g");
			str = str.replace(lineEndPattern, "\n");
			
			_records = new Array();
			var lines:Array = new Array();
			lines = str.split("\n");
			for each (var line:String in lines) {
				var r:Record = Record.Parse(line);
				if (r!=null) _records.push(r);
			}
			
			dispatchEvent(new Event("LOAD_COMPLETE"));
		}
		
		private function streamError(event:Event):void {
			trace(event);
		}
		
		private function writeIOErrorHandler(event:Event):void {
		}
		
		public function Debug(): void {
			trace("---DB DEBUG---");
			for each (var field:Record in _records) {
				trace(field.Key+"\t"+field.Value);
			}
			trace("---END DB DEBUG---");
		}
		
		
	}
}