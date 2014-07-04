package
{
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.events.MouseEvent;
	import flash.geom.Point;
	import flash.text.TextField;
	import flash.text.TextFormat;
	
	import Json.ParseJSON;
	
	import core.baseComponent.CSprite;
	
	import models.HomeMD;
	
	import pages.HomePage;
	
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
			var homeArr:Vector.<HomeMD> = json.getHomeData();
			var home:HomePage = new HomePage(homeArr);
			addChild(home);
			btnContain = new Sprite();
			addChild(btnContain);
			initGuideButton();
		}
		private var btnContain:Sprite;
		private var btnNameArr:Array = ["首页","好线路","看美景","地图","贴士"];
		private function initGuideButton():void
		{
			var txt:TextField;
			var i:int = 0;
			var tContain:CSprite;
			var format:TextFormat = new TextFormat(null,20,0xffffff,true);
			for each(var str:String in btnNameArr)
			{
				tContain = new CSprite();
				tContain.data = i;
				txt = new TextField();
				txt.mouseEnabled = txt.selectable = false;
				txt.text = str;
				txt.setTextFormat(format);
				tContain.x = i * 80 + 100;
				tContain.addEventListener(MouseEvent.CLICK,clickHandler);
				tContain.addChild(txt);
				btnContain.addChild(tContain);
				i++;
			}
		}
		private function clickHandler(event:MouseEvent):void
		{
			var t:CSprite = event.currentTarget as CSprite;
			trace(t.data);
		}
	}
}