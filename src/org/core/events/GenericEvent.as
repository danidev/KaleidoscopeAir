package org.core.events
{
	import flash.events.Event;
	
	public class GenericEvent extends Event
	{
		public var Data:Object;
		
		public function GenericEvent(type:String,data:Object)
		{
			Data = data;
			super(type);
		}
	}
}