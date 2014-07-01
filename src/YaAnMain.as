package
{
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.geom.Point;
	
	import Json.ParseJSON;
	
	import models.HomeMD;
	
	import views.CMapView;
	
	[SWF(width="1080",height="608",frameRate="30")]
	public class YaAnMain extends Sprite
	{
		public function YaAnMain()
		{
			
			var mapView:CMapView = new CMapView(new Point(101.2,38.4),new Point(600,400),10);
			addChild(mapView);
			
			initData();
		}
		private var json:ParseJSON;
		private function initData():void
		{
			json = new ParseJSON("source/yaAn.json");
			json.addEventListener(ParseJSON.LOAD_COMPLETE,dateOkHandler);
		}
		private function dateOkHandler(event:Event):void
		{
			trace("json laad ok.");
			initHomeUI();
		}
		private function initHomeUI():void
		{
			var i:int;
			var homeArr:Vector.<HomeMD> = json.getHomeData();
			for each(var hMd:HomeMD in homeArr)
			{
				trace(i);
				i++;
			}
		}
	}
}