package;

import nme.Assets;
import nme.display.Bitmap;
import nme.display.Sprite;
import nme.events.Event;
import nme.events.MouseEvent;
import nme.events.KeyboardEvent;
import nme.Lib;
import nme.ui.Keyboard;
import nme.ui.Mouse;

class Main extends Sprite
{
		

	private var kodok:Bitmap;	
	private var score:Int;
	private static var kecepatan:Int = 10;
	private static var kecepatan2:Int = 10;
	private static var kecepatanKodok:Int = 50;

	private var mobil:Bitmap;
	private var mobil2:Bitmap;
	private var finish:Bitmap;
	private var winText:Bitmap;
	private var loseText:Bitmap;
	private var play:Bool = true;
	private var againBtn:Bitmap;
	private var endState:Bool = false;

	//posisi kodok
	private var kodokX:Float = 250;
	private var kodokY:Float = 400;

	public static function main ()
	{
		Lib.current.addChild(new Main());
	}

	//konstruktor
	public function new ()
	{
		super();
		initialize();
		startGame();
	}

	private function initialize()
	{
		addSprite();
	}

	private function startGame ()
	{
		score = 0;
		Lib.current.stage.addEventListener(KeyboardEvent.KEY_DOWN, move);
		mobil.addEventListener(Event.ENTER_FRAME, moveCar);
		
		Lib.current.stage.addEventListener(MouseEvent.MOUSE_DOWN, again);
	}

	//menaruh kodok di halaman
	public function addSprite()
	{
		//tambah kodok
		kodok = new Bitmap(Assets.getBitmapData("images/kodok.png"));
		kodok.width = 46;
		kodok.height = 42;
		kodok.x = kodokX;
		kodok.y = kodokY + 50;

		//tambah movile
		mobil = new Bitmap(Assets.getBitmapData("images/mobil.png"));
		mobil.width = 50;
		mobil.height = 30;
		mobil.y = 240;

		//tambah movile2
		mobil2 = new Bitmap(Assets.getBitmapData("images/mobil.png"));
		mobil2.width = 50;
		mobil2.height = 30;
		mobil2.y = 100;

		//tambah finish
		finish = new Bitmap(Assets.getBitmapData("images/finisih.png"));
		finish.width=50;
		finish.height=50;
		finish.x = kodokX;
		finish.y = 0;

		//tambah tulisan win
		winText = new Bitmap(Assets.getBitmapData("images/yay.png"));
		winText.x = 20;
		winText.y = 100;
		winText.alpha = 0;

		//tambah tulisan lose
		loseText = new Bitmap(Assets.getBitmapData("images/gyaa.png"));
		loseText.x = 20;
		loseText.y = 100;
		loseText.alpha = 0;

		//tambah tombol again
		againBtn = new Bitmap(Assets.getBitmapData("images/again_btn.png"));
		againBtn.x = 250;
		againBtn.y = 350;
		againBtn.alpha = 0;

		addChild(finish);
		addChild(kodok);
		addChild(mobil);
		addChild(mobil2);
		addChild(winText);
		addChild(loseText);
		addChild(againBtn);
	}

	public function moveCar(evt:Event){

		if (play) {
			if (mobil.x > x-mobil.width) {
				mobil.x -= kecepatan;
			}else{
				mobil.x = 500+mobil.width;
			}

			if (mobil2.x < 500+mobil2.width) {
				mobil2.x += kecepatan2;
			}else{
				mobil2.x = 0;
			}


			kodok.x = kodok.x-(kodok.x-kodokX)/10;
			kodok.y = kodok.y-(kodok.y-kodokY)/10;

			if (kodok.hitTestObject(finish)) {
				againBtn.alpha = 1;
				winText.alpha = 1;
				endState = true;
				play = false;
			}else if (kodok.hitTestObject(mobil2) ||
				kodok.hitTestObject(mobil)) {
				againBtn.alpha = 1;
				loseText.alpha = 1;
				play = false;
				endState = true;
			}


			//batasan
			if (kodokX < 0) {
				kodokX = 0;
			}

			if (kodokX+kodok.width > 500) {
				kodokX = 500-kodok.width;
			}

			if (kodokY+kodok.height > 450) {
				kodokY = 450-kodok.height;
			}

			if (kodokY < 0) {
				kodokY = 0;
			}

		}
		
		
		
	}

	public function again(evt:MouseEvent):Void{

		//ngedapetin posisi kursor
		//nggak tahu kenapa si tombol (againBtn) nggak ngefek
		//diberi addEventListener
		if (evt.localX >= againBtn.x &&
			evt.localY >= againBtn.y &&
			evt.localX <= againBtn.x + againBtn.width &&
			evt.localY <= againBtn.y + againBtn.height &&
			endState == true) {
			endState = false;
			play = true;
			kodokX = 250;
			kodokY = 400;
			kodok.x = 250;
			kodok.y = 400;
			winText.alpha = 0;
			loseText.alpha = 0;
			againBtn.alpha = 0;
			againBtn.alpha = 0;

			var finishRand:Float = Math.random();

			finish.x = Math.random() * (500-finish.width);
			finish.y = Math.random() * (450-finish.height);

			finish.width = (finishRand*50)+5;
			finish.height = (finishRand*50)+5;

			var mobiran:Float = Math.random();
			mobil.width = (mobiran * 50)+5;
			mobil.height = (mobiran * 30)+5;

			var mobiran2:Float = Math.random();
			mobil2.width = (mobiran2 * 50)+5;
			mobil2.height = (mobiran2 * 30)+5;

			kecepatan = Std.int(Math.random()*10)+10;
			kecepatan2 = Std.int(Math.random()*20)+10;
			kecepatanKodok = Std.int(Math.random() * 70)+10;

			mobil.x = -mobil.width;
			mobil2.x = -mobil2.width;

			mobil.y = Math.random() * (450-mobil.height);
			mobil2.y = Math.random() * (450-mobil2.height);

			var reverse:Float = Math.random()*100;
			//dibalik
			if (reverse < 50)
			{
				kecepatanKodok = -kecepatanKodok;
				kodok.rotation = 180;
			}else{
				kodok.rotation = 0;
			}
		}

		
	}

	public function move(evt:KeyboardEvent)
	{

			if (evt.keyCode == Keyboard.UP) {
				kodokY -= kecepatanKodok;
			}

			if (evt.keyCode == Keyboard.LEFT) {
				kodokX -= kecepatanKodok;
			}

			if (evt.keyCode == Keyboard.RIGHT) {
				kodokX += kecepatanKodok;
			}

			if (evt.keyCode == Keyboard.DOWN) {
				kodokY += kecepatanKodok;
			}
	}	
}