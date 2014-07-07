package pages
{
	import flash.display.Sprite;
	import flash.events.MouseEvent;
	
	import core.baseComponent.CButton;
	import core.baseComponent.CImage;
	
	import models.KmjMd;
	import models.KmjPointMd;
	import models.YAConst;
	
	public class KmjPage extends Sprite
	{
		private var kmjMd:KmjMd;
		public function KmjPage(_md:KmjMd)
		{
			super();
			
			kmjMd = _md;
			
			var bgImg:CImage = new CImage(YAConst.SCREEN_WIDTH,YAConst.SCREEN_HEIGHT,false,false);
			bgImg.url = kmjMd.background;
			addChild(bgImg);
			
			btnContain = new Sprite();
			addChild(btnContain);
			
			var arr:Array = ["source/back_up.png","source/back_up.png"];
			var backBtn:CButton = new CButton(arr,false);
			backBtn.addEventListener(MouseEvent.CLICK,backHandler);
			addChild(backBtn);
			backBtn.x = 700;
			
			initSpotButton();
		}
		private function backHandler(event:MouseEvent):void
		{
			if(this.parent)
			{
				this.parent.removeChild(this);
			}
		}
		private var btnContain:Sprite;
		private function initSpotButton():void
		{
			var btn:CButton;
			for each(var kmd:KmjPointMd in kmjMd.pointArr)
			{
				btn = new CButton(kmd.skinArr,false);
				btn.x = kmd.pointXY.x;
				btn.y = kmd.pointXY.y;
				btn.data = kmd.spotMd;
				btnContain.addChild(btn);
				btn.addEventListener(MouseEvent.CLICK,clickHandler);
			}
		}
		private function clickHandler(event:MouseEvent):void
		{
			var cb:CButton = event.currentTarget as CButton;
			var atlasPage:AtlasPage = new AtlasPage(cb.data);
			addChild(atlasPage);
		}
	}
}