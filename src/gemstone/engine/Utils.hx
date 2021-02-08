package gemstone.engine;

import rm.core.Bitmap;
import rm.managers.ImageManager;
import js.lib.Error;

typedef StringArrayIndex = {
  id: String
};

typedef MapArray = {
  key: String,
  value: Any
}

class Utils {
  public function new() {
    throw new Error("This is a static class");
  }

  /**
   * Function who find the index by the id inside the array structure
   * @param name - the id name
   * @param array - the array to search from
   * @return Int
   */
  public static function findIndexByID(name: String, array: Array<StringArrayIndex>): Int {
    var index = 0;
    for (i in 0...array.length + 1) {
      if (array[i].id == name) {
        index = i;
        break;
      }
    }
    return index;
  }

  public static function convertArrayToMap(array: Array<MapArray>): Any {
    var map: Map<String, Dynamic>;
    for (param in array) {
      map.set(param.key, param.value);
    }
    return map;
  }

  public static function convertToRGB(r: Int, g: Int, b: Int): String {
    return 'rgb(${r},${g},${b})';
  }

  /**
   * Load a custom directory for sprites.
   * @param directory - the directory to load
   * @param filename  - the filename to load
   * @param hue - the hue
   * @param smooth - whether or not to apply a smooth on the sprite
   * @return Bitmap
   */
  public static function LoadDirectory(directory: String, filename: String, ?hue: Int, smooth: Bool = false): Bitmap {
    return ImageManager.loadBitmap("img/" + directory + "/", filename, hue, smooth);
  }
}
