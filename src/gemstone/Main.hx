package gemstone;
import rm.managers.SceneManager;
import utils.Comment;
import gemstone.engine.ParamManager;

typedef Gem_Params = {
  core: {
    openConsole: Bool
  }
}
class Main {
  public static final pluginName: String = 'Gem_CoreEngine';
  public static var params: Gem_Params;

  public static function main() {
    
    var rawParams = ParamManager.findPlugin(pluginName);
    ParamManager.register(pluginName, rawParams);
    params = ParamManager.fetch(pluginName);

  }

  public static function OpenDevTool(){
    SceneManager.showDevTools();
  }
}

