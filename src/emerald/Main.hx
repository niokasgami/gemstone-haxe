package emerald;

import utils.Comment;
import macros.FnMacros;
import gemstone.engine.ParamManager;
import rm.scenes.Scene_Boot as RmScene_Boot;
import emerald.scenes.Scene_Boot;


typedef SplashParams = {
  core: {
    useMe: Bool, useColor: Bool
  },
  background: {
    filename: String, color: {
      r: Int, g: Int, b: Int
    }
  },
  Logos: Array<{
    filename: String,
    duration: Int,
    me: String
  }>
}

class Main {
  public static final pluginName: String = 'EM_SplashScreen';
  public static var params: SplashParams;

  public static function main() {
    var rawParams = ParamManager.findPlugin(pluginName);
    ParamManager.register(pluginName, rawParams);
    params = ParamManager.fetch(pluginName);

    Comment.title('Scene_Boot');
    FnMacros.jsPatch(true, RmScene_Boot, Scene_Boot);
  }
}
