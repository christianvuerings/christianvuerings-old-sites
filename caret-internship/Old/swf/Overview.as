package{
	import flash.display.Shape;
	import flash.display.Loader;
	import flash.display.LoaderInfo;
	import flash.display.Sprite;
	import flash.text.TextField;
	import flash.events.Event;
	import flash.events.IOErrorEvent
	import flash.events.MouseEvent;
	import flash.events.TimerEvent;
	import flash.net.navigateToURL;
	import flash.net.URLLoader;
	import flash.net.URLRequest;
	import flash.utils.Timer;
	//import caurina.transitions.Tweener;
	//
	public class Overview extends Sprite{
		
		private var path_url:String = "";
		private var path_image:String = "";
		private var color:String = "";
		private var loader_image:Loader;
		
		private var sprite_image:Sprite;
		//
		public function Overview():void {
			var flashvarObj:Object = LoaderInfo(this.root.loaderInfo).parameters;
			
			
			//Test if the the object contains the necessary flashvars
			if (flashvarObj["url"] && flashvarObj["image"] && flashvarObj["color"]) {
				loader_image = new Loader();
				sprite_image = new Sprite();
				
				//stage.addEventListener(MouseEvent.MOUSE_MOVE, mouseMove);
				sprite_image.addEventListener(Event.ENTER_FRAME,mouseMove);

				path_url = flashvarObj["url"];
				path_image = flashvarObj["image"];
				color = flashvarObj["color"];
				
				var rect:Shape = new Shape();
				var coloru:uint = uint(color);
				rect.graphics.beginFill(coloru, 1);
				rect.graphics.drawRect(0, 0, stage.stageWidth, stage.stageHeight);
				addChild(rect);
				
				addChild(sprite_image);
				LoadImage();
			} else {
				error_txt.appendText("Could not recieve the flashvars.\n");
				error_txt.appendText("Flashvar url: " + flashvarObj["url"] + "\n");
				error_txt.appendText("Flashvar image: " + flashvarObj["image"] + "\n");
			}
		}
		//Load the image if the flashvars are correct
		private function LoadImage():void {
			loader_image.load(new URLRequest(path_image));
			loader_image.contentLoaderInfo.addEventListener(Event.COMPLETE, onLoadComplete);
			loader_image.contentLoaderInfo.addEventListener(IOErrorEvent.IO_ERROR , onLoadError);
		}
		//
		private function onLoadComplete(event:Event):void {
			sprite_image.addChild(loader_image);
			sprite_image.buttonMode = true;
			sprite_image.addEventListener(MouseEvent.CLICK, gotoUrl);
		}
		//
		private function gotoUrl(event:MouseEvent):void {
			var request_url:URLRequest = new URLRequest(path_url);
			navigateToURL(request_url, '_blank');
		}
		//
		private function onLoadError(e:Event):void {
			error_txt.appendText(this + " .ERROR loading " + path_image + "\n");
		}
		//
		private function mouseMove(evt:Event){			
            var dx:Number=-mouseX*((evt.currentTarget.width-stage.stageWidth+20)/stage.stageWidth)+10-evt.currentTarget.x;
            var ax:Number=dx*.1;
            evt.currentTarget.x += ax;
            sprite_image.x+=ax;
			
			var dy:Number=-mouseY*((evt.currentTarget.height-stage.stageHeight+20)/stage.stageHeight)+10-evt.currentTarget.y;
            var ay:Number=dy*.2;
            evt.currentTarget.y += ay;
            sprite_image.y+=ay;
		}
	}
}