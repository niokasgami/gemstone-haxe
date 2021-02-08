package gemstone.engine;

import haxe.DynamicAccess;
import rm.types.RM.PluginSettings;
import rm.Globals;
import utils.Parse;
import js.lib.Error;

using Lambda;
using StringTools;

/**
 * The class who handle Params and store them
 * @author Nio Kasgami
 */
class ParamManager {
  private static var parameters: Map<String, Dynamic>;

  public function new() {
    throw new Error("This is a static class");
  }

  /**
   * register a plugin to the ParamManager
   * @param namespace 
   * @param rawParams 
   */
  public static function register(namespace: String, rawParams: Any): Void {
    var self = ParamManager;
    if (!self.parameters.exists(namespace)) {
      throw new Error("The plugin namespace " + namespace + " already exist in this context!");
    }
    var params = Parse.parseParameters(cast rawParams);
    self.parameters[namespace] = params;
  }

  /**
   * Fetch the parameters from the specific class
   * @param namespace the plugin namespace
   * @return Any
   */
  public static function fetch(namespace: String): Any {
    var self = ParamManager;
    if (!self.parameters.exists(namespace)) {
      throw new Error("The plugin namespace " + namespace + " doesnt exist in this context!");
    }
    return self.parameters[namespace];
  }

  /**
   * Find the plugin through the description
   * @param pluginName 
   * @return DynamicAccess<Dynamic>
   */
  public static function findPlugin(pluginName: String): DynamicAccess<Dynamic>{
    return Globals.Plugins.find((p: PluginSettings) -> p.description.contains("<" + pluginName + ">")).parameters;
  }
}

