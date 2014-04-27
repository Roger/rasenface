package scenes;

import com.haxepunk.Scene;
import com.haxepunk.Entity;

import com.haxepunk.graphics.Image;
import com.haxepunk.graphics.Backdrop;

import com.haxepunk.tmx.TmxMap;
import com.haxepunk.tmx.TmxEntity;

import entities.Character;
import entities.TextEntity;

class MainScene extends Scene
{
    private var backdrop:Backdrop;
    public override function begin()
    {
        //backdrop = new Backdrop("graphics/level0.png", false, false);
        //addGraphic(backdrop);
        //add(new Character(10, 445, "wake"));

        //var entity:Entity = new Entity();
        //entity.setHitbox(660, 300);
        //entity.y = 565;
        //entity.type = "solid";
        //add(entity);
        loadMap();
    }

    private function loadMap()
    {
        var map = TmxMap.loadFromFile("maps/level0.tmx");
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
                 var player:Character = new Character(object.x, object.y, anim);
                 add(player);
             case "text":
                 var text:String = object.custom.resolve("text");
                 var duration:Int = null;

                 if(object.custom.resolve("duration") != null) {
                     duration = Std.parseInt(object.custom.resolve("duration"));
                 }

                 var entity:TextEntity = new TextEntity(object.x, object.y, text, duration);
                 entity.type = object.custom.resolve("etype");
                 entity.visible = object.custom.resolve("visible") != "false";
                 if(duration != null && entity.visible) entity.activate();

                 add(entity);
             default:
                 trace("unknown type: " + object.type);
          }
        }
        add(e_map);
    }
}
