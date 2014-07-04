package pages
{
	import flash.display.Sprite;
	
	import core.baseComponent.CImage;
	import core.baseComponent.LoopAtlas;
	
	import models.HomeMD;
	import models.YAConst;
	
	public class HomePage extends Sprite
	{
		private var contentSprite:Sprite;
		public function HomePage(arr:Vector.<HomeMD>)
		{
			super();
			
			contentSprite = new Sprite();
//			addChild(contentSprite);
			initContent(arr);
		}
		private function initContent(dataArr:Vector.<HomeMD>):void
		{
			var i:int = 0;
			var img:CImage;
			imgArr = new Array();
			for each(var md:HomeMD in dataArr)
			{
				img = new CImage(YAConst.SCREEN_WIDTH,YAConst.SCREEN_HEIGHT,false,false);
				img.url = md.picArr[0];
				img.data = md.type;
//				img.x = i * YAConst.SCREEN_WIDTH;
//				contentSprite.addChild(img);
				imgArr.push(img);
				i++;
			}
			var loopAtlas:LoopAtlas = new LoopAtlas(imgArr);
			addChild(loopAtlas);
		}
		private var imgArr:Array;
		private function next():void
		{
			
			
		}
	}
}