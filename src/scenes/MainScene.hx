package scenes;

import com.haxepunk.Scene;
import com.haxepunk.Entity;

import com.haxepunk.graphics.Image;
import com.haxepunk.graphics.Backdrop;

import com.haxepunk.tmx.TmxMap;
import com.haxepunk.tmx.TmxEntity;

import entities.Character;
import entities.TextEntity;
import entities.EmptyEntity;

using StringTools;

class MainScene extends Scene
{
    private var backdrop:Backdrop;
    public override function begin()
    {
        loadMap();
    }

    public function loadMap()
    {
        removeAll();
        var map = TmxMap.loadFromFile("maps/"+currentMap+".tmx");
        var e_map = new TmxEntity(map);

        //e_map.loadImageLayer("background");

        backdrop = new Backdrop(map.imageLayers.get("background"), false, false);
        addGraphic(backdrop);

        e_map.loadGraphic("graphics/tileset.png", ["layer"]);
        e_map.loadMask("collision", "solid");

        for(object in map.getObjectGroup("objects").objects)
        {
          switch(object.type)
          {
             case "player":
                 var anim:String = object.custom.resolve("animation");
                 var flipped:Bool = object.custom.resolve("flipped") == "true";
                 var player:Character = new Character(object.x, object.y, anim, flipped);
                 add(player);
             case "text":
                 var text:String = object.custom.resolve("text");
                 text = text.replace("\\n", "\n");
                 var duration:Int = 0;
                 var starts:Int = 0;

                 if(object.custom.resolve("duration") != null) {
                     duration = Std.parseInt(object.custom.resolve("duration"));
                 }

                 if(object.custom.resolve("starts") != null) {
                     starts = Std.parseInt(object.custom.resolve("starts"));
                 }

                 var etype = object.custom.resolve("etype");
                 var entity:TextEntity = new TextEntity(object.x, object.y,object.width, object.height,
                                                        text, duration, starts);
                 entity.type = etype;
                 var visible:Bool = object.custom.resolve("visible") != "false";
                 if(visible) entity.activate();
                 entity.setHitbox(object.width, object.height);

                 add(entity);
             case "stairs":
                 var entity:Entity = new Entity(object.x, object.y);
                 entity.setHitbox(object.width, object.height);
                 entity.type = "stairs";
                 add(entity);
             case "dead":
                 var entity:EmptyEntity = new EmptyEntity(object.x, object.y, object.width, object.height, "dead");
                 add(entity);
             case "gate":
                 var entity:EmptyEntity = new EmptyEntity(object.x, object.y, object.width, object.height, "gate");
                 var goto:String = object.custom.resolve("goto");
                 entity.data.set("goto", goto);
                 add(entity);
             default:
                 trace("unknown type: " + object.type);
          }
        }
        add(e_map);
    }
    public var currentMap:String = "level0";
}
