package
{
	import flash.display.Sprite;
	import flash.geom.Point;
	
	import views.CMapView;
	
	public class YaAnMain extends Sprite
	{
		public function YaAnMain()
		{
			
			var mapView:CMapView = new CMapView(new Point(101.2,38.4),new Point(600,400),10);
			addChild(mapView);
		}
	}
}