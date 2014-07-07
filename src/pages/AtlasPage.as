package pages
{
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.events.MouseEvent;
	import flash.geom.Rectangle;
	
	import core.baseComponent.CButton;
	import core.baseComponent.CImage;
	import core.baseComponent.LoopAtlas;
	import core.baseComponent.MusicPlayer;
	import core.filter.CFilter;
	import core.tween.TweenLite;
	
	import models.AtlaMd;
	import models.PointMd;
	import models.YAConst;
	
	public class AtlasPage extends Sprite
	{
		private var pointMd:PointMd;
		private var contentContain:Sprite;
		public function AtlasPage(_pointMd:PointMd)
		{
			super();
			
			pointMd = _pointMd;
			
			var bgImg:CImage = new CImage(YAConst.SCREEN_WIDTH,YAConst.SCREEN_HEIGHT,false,false);
			bgImg.url = "source/allSpots/bg/bg1.jpg";
//			bgImg.url = pointMd.background;
			addChild(bgImg);
			
//			return;
			contentContain = new Sprite();
			contentContain.y = 150;
			addChild(contentContain);
			
			music = new MusicPlayer(pointMd.audioUrl,false,false);
			music.addEventListener(MusicPlayer.PLAY_OVER,musicOverHandler);
			var sArr:Array = ["source/atlas/play.png","source/atlas/pause.png"];
			audioButton = new CButton(sArr,false,true,true);
			audioButton.addEventListener(MouseEvent.CLICK,playMusicHandler);
			this.addChild(audioButton);
			audioButton.x = 600;
			audioButton.y = 100;
			
			var arr:Array = ["source/back_up.png","source/back_up.png"];
			var backBtn:CButton = new CButton(arr,false);
			backBtn.addEventListener(MouseEvent.CLICK,backHandler);
			addChild(backBtn);
			backBtn.x = 700;
			
			initContent();
		}
		private function backHandler(event:MouseEvent):void
		{
			if(this.parent)
			{
				this.parent.removeChild(this);
			}
		}
		private var audioButton:CButton;
		private var music:MusicPlayer;
		private function playMusicHandler(event:MouseEvent):void
		{
			if(music.isPause)
			{
				music.play();
			}else{
				music.pause();
			}
		}
		private function musicOverHandler(event:Event):void
		{
			audioButton.select(false);
		}
		private function initContent():void
		{
			var atlasArr:Array = pointMd.atlasArr;
			
			var imgArr:Array = [];
			var img:CImage;
			var i:int = 0;
			for each(var md:AtlaMd in atlasArr)
			{
				img = new CImage(900,460,false,false);
				img.url = md.url;
				imgArr.push(img);
				img.x = i * (900 + 4);
				img.filters = CFilter.whiteFilter;
				contentContain.addChild(img);
				i++;
			}
//			var loopAtlas:LoopAtlas = new LoopAtlas(imgArr);
//			contentContain.addChild(loopAtlas);
			contentContain.addEventListener(MouseEvent.MOUSE_DOWN,mouseDonwnHandler);
			contentContain.addEventListener(MouseEvent.MOUSE_UP,stopDrayHandler);
			contentContain.addEventListener(MouseEvent.MOUSE_OUT,stopDrayHandler);
		}
		private var beginX:int;
		private var dis:int = 15;
		private var disTime:Number = 300;
		private var beginTime:Number;
		private var atoDis:int = 900;
		private function mouseDonwnHandler(event:MouseEvent):void
		{
			beginX = this.mouseX;
			var dData:Date = new Date();
			beginTime = dData.getTime();
			contentContain.startDrag(false,new Rectangle(YAConst.SCREEN_WIDTH - contentContain.width,150,contentContain.width - YAConst.SCREEN_WIDTH,0));
//			contentContain.addEventListener(MouseEvent.MOUSE_MOVE,mouseMoveHandler);
		}
		private function mouseMoveHandler(event:MouseEvent):void
		{
			
		}
		private function stopDrayHandler(event:MouseEvent):void
		{
			var ed:Date = new Date();
			if(ed.getTime() - beginTime < disTime && Math.abs(beginX - this.mouseX) > dis)
			{
				var dir:int = 1;
				if(beginX > this.mouseX)
				{
					dir = -1;
				}
				var endX:int = contentContain.x + atoDis * dir;
				if(endX > 0)
				{
					endX = 0;
				}
				if(endX < -contentContain.width + YAConst.SCREEN_WIDTH)
				{
					endX = -contentContain.width + YAConst.SCREEN_WIDTH
				}
				TweenLite.to(contentContain,.3,{x:endX});
			}
			contentContain.stopDrag();
		}
	}
}