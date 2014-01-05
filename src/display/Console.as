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
package display
{
	import flash.display.Sprite;
	import flash.text.AntiAliasType;
	import flash.text.GridFitType;
	import flash.text.TextField;
	import flash.text.TextFieldAutoSize;
	import flash.text.TextFormat;
	
	import utils.Drawings;
	
	public class Console extends Sprite
	{
		private var _sprite:Sprite;
		private var _tf:TextField;
		
		public function Console()
		{
			super();
			
			_sprite = new Sprite();
			this.addChild(_sprite);
			
			//Creating the textfield object and naming it "myTextField"  
			_tf = new TextField();  
			
			//Here we add the new textfield instance to the stage with addchild()  
			this.addChild(_tf);  
			
			//Here we define some properties for our text field, starting with giving it some text to contain.  
			//A width, x and y coordinates.  
			_tf.text = "some text here!";  
			_tf.width = 250;  
			_tf.x = 25;  
			_tf.y = 25;  
			
			//Here are some great properties to define, first one is to make sure the text is not selectable, then adding a border.  
			_tf.selectable = false;  
			_tf.border = true;  
			
			//This last property for our textfield is to make it autosize with the text, aligning to the left.  
			_tf.autoSize = TextFieldAutoSize.LEFT;  
			
			//This is the section for our text styling, first we create a TextFormat instance naming it myFormat  
			var myFormat:TextFormat = new TextFormat();  
			
			//Giving the format a hex decimal color code  
			myFormat.color = 0xAA0000;   
			
			//Adding some bigger text size  
			myFormat.size = 24;  
			
			//Last text style is to make it italic.  
			//myFormat.italic = true;  
			
			//Now the most important thing for the textformat, we need to add it to the myTextField with setTextFormat.  
			_tf.setTextFormat(myFormat); 
		}
		
		public function SetText(str:String): void {
			var tf:TextFormat = _tf.getTextFormat();
			_tf.text = str;
			_tf.setTextFormat(tf);
			
			_sprite.x =_tf.x;
			_sprite.y = _tf.y;
			
			_sprite.graphics.clear();
			Drawings.FilledRect(_sprite.graphics,0,0,_tf.width,_tf.height,0xFFFFFF);
		}
	}
}