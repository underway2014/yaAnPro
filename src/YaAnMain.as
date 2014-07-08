package
{
	import flash.display.Shape;
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.events.MouseEvent;
	import flash.geom.Point;
	import flash.text.TextField;
	import flash.text.TextFormat;
	
	import Json.ParseJSON;
	
	import core.baseComponent.CButton;
	import core.baseComponent.CImage;
	import core.baseComponent.CSprite;
	
	import models.HomeMD;
	import models.YAConst;
	
	import pages.HomePage;
	import pages.KmjPage;
	import pages.LinePage;
	
	import views.CMapView;
	
	[SWF(width="1494",height="700",frameRate="30")]
	public class YaAnMain extends Sprite
	{
		public function YaAnMain()
		{
			
			
//			
			initData();
//			var str:String = "天下第一关解说打开";
//			var sptName:SpotNameView = new SpotNameView(str);
//			addChild(sptName);
//			sptName.y = 20;
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
//			btnContain.y = 15;
			btnContain.graphics.beginFill(0x0,.2);
			btnContain.graphics.drawRect(0,0,YAConst.SCREEN_WIDTH,60);
			btnContain.graphics.endFill();
			 var hline:Shape = new Shape();
			 hline.graphics.beginFill(0xffc125,.8);
			 hline.graphics.drawRect(0,56,YAConst.SCREEN_WIDTH,4);
			 hline.graphics.endFill();
			 btnContain.addChild(hline);
			
			addChild(btnContain);
//			initGuideButton();
			initNavigation();
		}
		private var btnContain:Sprite;
		private var btnNameArr:Array = ["看美景","好吃客","玩乐地","好线路","查地图","贴士"];
		private var homeBtnArr:Array = ["1.png","2.png","3.png","4.png","5.png","6.png"];
		private function initNavigation():void
		{
			var btn:CButton;
			var mainPath:String = "source/home/btn/";
			var benginX:int = 100;
			var i:int = 0;
			var lineImg:CImage;
			for each(var str:String in homeBtnArr)
			{
				btn = new CButton([mainPath + str,mainPath + str],false);
				btnContain.addChild(btn);
				btn.x = benginX + i * 175;
				btn.y = 15;
				btn.data = i;
				btn.addEventListener(MouseEvent.CLICK,clickHandler);
				lineImg = new CImage(1,40,false,false);
				lineImg.url = mainPath + "line.png";
				btnContain.addChild(lineImg);
				i++;
				lineImg.x = benginX + i * 175 - 10;
				lineImg.y = 12;
			}
		}
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
		private var linePage:LinePage;
		private var kmjPage:KmjPage;
		private var mapView:CMapView;
//		private var
		private function clickHandler(event:MouseEvent):void
		{
			var t:CButton = event.currentTarget as CButton;
			trace(t.data);
			switch(t.data)
			{
				case 0:
					if(!kmjPage)
					{
						kmjPage = new KmjPage(json.getKmjData());
						addChild(kmjPage);
					}
					kmjPage.visible = true;
					break;
				case 1:
					break;
				case 2:
					break;
				case 3:
					if(!linePage)
					{
						linePage = new LinePage(json.getLineData());
						addChild(linePage);
					}
					linePage.visible = true;
					break;
				case 4:
					if(!mapView)
					{
						mapView = new CMapView(new Point(103.0119,29.9848),new Point(YAConst.SCREEN_WIDTH,YAConst.SCREEN_HEIGHT),14);
						addChild(mapView);
					}
					mapView.visible = true;
					break;
			}
		}
	}
}