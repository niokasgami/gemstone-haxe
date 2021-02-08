package emerald.scenes;

import js.lib.Error;
import rm.Globals;
import rm.windows.Window_TitleCommand;
import rm.managers.DataManager;
import rm.managers.SceneManager;
import rm.scenes.Scene_Title;
import rm.types.RM.AudioParameters;
import rm.managers.AudioManager;
import emerald.engine.Utils;
import rm.core.Sprite;
import rm.core.Graphics;
import rm.core.Bitmap;
import rm.scenes.Scene_Base;
/**
 * The scene who handle the display of splash logo
 */
class Scene_SplashScreen extends Scene_Base {
  private var _backgroundSprite: Sprite;
  
  private var _backgroundBitmap: Bitmap;
  private var _logos: Array<Sprite>;
  private var _index: Int;
  private var _params: Main.SplashParams;
  private var _dir: String;
  private var _timer: Int;
  private var _switching: Bool;

  public function new() {
    super();
  }

  public override function initialize(): Void {
    super.initialize();
    this._params = Main.params;
    this._dir = "splashScreen";
    this._index = 0;
    this._timer = 0;
    this._switching = false;
  }

  public override function start() {
    super.start();

    this.executeLogos();
    if (this._params.core.useMe) {
      this.playMe();
    }
    this.startFadeIn(this.fadeSpeed(), false);
  }

  public override function update() {
    super.update();
    if (this.isReady() && !this._switching) {
      this._timer++;
    }
    if (this._timer >= this._params.Logos[this._index].duration && this.isReady()) {
      this.startFadeOut(this.fadeSpeed(), false);
      this._switching = true;
    }
    if (!this.isFading() && this._switching) {
      this.switchLogo();
      this.startFadeIn(this.fadeSpeed(), false);
    }
  }

  public function executeLogos() {
    this._logos[this._index].visible = true;
  }

  public function switchLogo() {
    this._logos[this._index].visible = false;
    if (this._index < this._logos.length) {
      this._index++;
      this._logos[this._index].visible = true;
      this._timer = 0;
      this._switching = false;
      if (this._params.core.useMe) {
        this.playMe();
      }
    } else {
      this.gotoTitleScreen();
    }
  }

  public function playMe() {
    var audio: AudioParameters;
    audio.name = this._params.Logos[this._index].me;
    audio.volume = 100;
    audio.pan = 0;
    audio.pitch = 100;
    audio.pos = 0;
    AudioManager.stopAll();
    AudioManager.playMe(audio);
  }

  public override function create(): Void {
    super.create();
    this.createBackground();
    this.createLogos();
  }

  public function createBackground(): Void {
    this.createBitmap();
    this._backgroundSprite = new Sprite(this._backgroundBitmap);
    this.centerSprite(this._backgroundSprite);
    this.addChild(this._backgroundSprite);
  }

  public function createBitmap(): Void {
    if (this._params.core.useColor) {
      this._backgroundBitmap = new Bitmap(Graphics.width, Graphics.height);
      var color = this._params.background.color;
      var rgb = Utils.convertToRGB(color.r, color.g, color.b);
      this._backgroundBitmap.fillAll(rgb);
    } else {
      this._backgroundBitmap = Utils.LoadDirectory(this._dir, this._params.background.filename);
    }
  }

  public function createLogos(): Void {
    this._logos = [];
    var param = this._params.Logos;
    for (i in 0...this._params.Logos.length + 1) {
      var bitmap = Utils.LoadDirectory(this._dir, param[i].filename);
      this._logos[i] = new Sprite(bitmap);
      this._logos[i].visible = false;
      this.centerSprite(this._logos[i]);
      this.addChild(this._logos[i]);
    }
  }

  public function gotoTitleScreen(): Void {
    this.checkPlayerLocation();
    DataManager.setupNewGame();
    SceneManager.goto(Scene_Title);
    Window_TitleCommand.initCommandPosition();
  }

  public function checkPlayerLocation(): Void {
    if (Globals.DataSystem.startMapId == 0) {
      throw new Error("Player's starting position is not set");
    }
  }
}
