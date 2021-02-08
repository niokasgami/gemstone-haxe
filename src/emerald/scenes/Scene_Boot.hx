package emerald.scenes;

import rm.managers.SceneManager;
import rm.scenes.Scene_Boot as RmScene_Boot;
import emerald.scenes.Scene_SplashScreen;

class Scene_Boot extends RmScene_Boot {
    
  // no alias as it's not necessary in this context.
  public override function startNormalGame() {
    SceneManager.goto(Scene_SplashScreen);
  }
}
