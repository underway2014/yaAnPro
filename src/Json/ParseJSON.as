package Json
{
	import flash.events.Event;
	import flash.events.EventDispatcher;
	import flash.events.IOErrorEvent;
	import flash.geom.Point;
	import flash.net.URLLoader;
	import flash.net.URLRequest;
	
	import models.AtlaMd;
	import models.HomeMD;
	import models.LineMd;
	import models.PointMd;
	import models.RouteMd;
	import models.WldMd;

	public class ParseJSON extends EventDispatcher
	{
		
		public static const LOAD_COMPLETE:String = "load_complete";
		
		private const HOME:String = "HOME";
		private const KMJ:String = "KMJ";
		private const WLD:String = "WLD";
		private const ROUTE:String = "ROUTE";
		private const MAP:String = "MAP";
		private var type:int;
		/**
		 * 
		 * @param path
		 * @param _type !0 parseInfo else  
		 * 
		 */		
		public function ParseJSON(path:String,_type:int = 0)
		{
			type = _type;
			loadJson(path);
		}
		public function loadJson(path:String):void
		{
			var loader:URLLoader = new URLLoader();
			loader.load(new URLRequest(path));
			loader.addEventListener(Event.COMPLETE,jsonLoadOkHandler);
			loader.addEventListener(IOErrorEvent.IO_ERROR,errorHandler);
		}
		private function jsonLoadOkHandler(event:Event):void
		{
			var obj:Object = JSON.parse(URLLoader(event.target).data);
			parseSource(obj);
		}
		private var homeDataArr:Vector.<HomeMD> = new Vector.<HomeMD>;
		private var lineMd:LineMd;
		private var wldMd:WldMd;
		private function parseSource(data):void
		{
			//首页
			var homeMd:HomeMD;
			for each(var hObj:Object in data.HOME)
			{
				homeMd = new HomeMD();
				homeMd.name = hObj.name;
				homeMd.type = hObj.type;
				homeMd.picArr = hObj.pictures;
				homeDataArr.push(homeMd);
			}
			
			//好线路
			lineMd = new LineMd();
			var lineData:Object = data.LINE;
			lineMd.colorMap = lineData.colorMap;
			lineMd.routesArr = new Array();
			var routeMd:RouteMd;
			for each(var obj:Object in lineData.routes)
			{
				routeMd = new RouteMd();
				routeMd.name = obj.name;
				routeMd.lineMap = obj.lineMap;
				routeMd.desc = obj.desc;
				routeMd.pointsArr = new Array();
				var pointMd:PointMd;
				for each(var o:Object in obj.points)
				{
					pointMd = new PointMd();
					pointMd.name = o.name;
					pointMd.pointXY = new Point(o.coordX,o.coordY);
					pointMd.audioUrl = o.audio;
					pointMd.background = o.background;
					pointMd.desc = o.desc;
					pointMd.atlasArr = new Array();
					var altMd:AtlaMd;
					for each(var oo:Object in o.atlas)
					{
						altMd = new AtlaMd();
						altMd.name = oo.name;
						altMd.desc = oo.url;
						pointMd.atlasArr.push(altMd);
					}
					routeMd.pointsArr.push(pointMd);
				}
				lineMd.routesArr.push(routeMd);
			}
			
			///玩乐地
			wldMd = new WldMd();
			var wldData:Object = data.WLD;
			wldMd.name = wldData.name;
			wldMd.background = wldData.background;
			wldMd.pointsArr = new Array();
			var pointMD:PointMd;
			for each(var po:Object in wldData.points)
			{
				pointMD = new PointMd();
				pointMD.name = po.name;
				pointMD.pointXY = new Point(po.coordX,po.coordY);
				pointMD.btnSkinArr = new Array(po.btnNormal,po.btnDown);
				pointMD.atlasArr = new Array();
				var atMD:AtlaMd;
				for each(var ao:Object in po.atlas)
				{
					atMD = new AtlaMd();
					atMD.name = ao.name;
					atMD.url = ao.url;
					atMD.desc = ao.desc;
					pointMD.atlasArr.push(atMD);
				}
				wldMd.pointsArr.push(pointMD);
			}
			
			
			dispatchEvent(new Event(LOAD_COMPLETE));
		}
		private function errorHandler(event:IOErrorEvent):void
		{
			trace("json load wrong!");
		}
		public function getHomeData():Vector.<HomeMD>
		{
			return homeDataArr;
		}
		public function getLineData():LineMd
		{
			return lineMd;
		}
		public function getWldData():WldMd
		{
			return wldMd;
		}
	}
}