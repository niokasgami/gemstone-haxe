package emerald.innManager;

import haxe.macro.Expr.Function;


class Something {

    public static function Action(name: String, arg: String){
        var something = 10;
    }
}


class Actions {

    public static function main(){
        Something.Action("","",function(){

        })
    }
}