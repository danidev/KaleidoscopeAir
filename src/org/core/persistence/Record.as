package org.core.persistence
{
	import org.data.BookData;

	public class Record
	{
		public var Key:String;
		public var Value:String;
		
		public function Record(key:String,value:String)
		{
			Key = key;
			Value = value; 
		}
		
		public function CreateTxt(): String {
			return Key+":"+Value+"\n";
		}
		
		public static function Parse(txt:String): Record {
			var fields:Array = txt.split(":");
			if (fields.length==2)
				return new Record(fields[0],fields[1]);
			return null;
		}
	}
}