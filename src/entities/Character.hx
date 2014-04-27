package entities;

import com.haxepunk.HXP;
import com.haxepunk.Entity;

import com.haxepunk.utils.Input;
import com.haxepunk.graphics.Spritemap;


class Character extends Entity
{
    public function new(x:Float, y:Float, anim:String="wake")
    {
        super(x, y);

        sprite = new Spritemap("graphics/character.png", 52, 120);
        sprite.add("idle", [0, 1, 2, 3, 4, 5], 10, true);
        sprite.add("walk", [6, 7, 8, 9, 10, 11], 15, true);
        sprite.add("wake", [12, 13, 14, 15, 16, 17], 10, false);
        sprite.add("jump", [15, 16], 10, false);
        graphic = sprite;
        sprite.play(anim);

        setHitbox(52, 120);
    }

    private function handleInput()
    {
        acceleration = 0;

        if (Input.check("right"))
        {
            acceleration = 200 * HXP.elapsed;
        }

        if (Input.check("left"))
        {
            acceleration = -200 * HXP.elapsed;
        }

        if (Input.check("up") && inJump == false) {
            inJump = true;
            jumpTime = 20;
        }
    }

    override public function moveCollideY(e:Entity)
    {
        if(e.type == "solid") {
            if(jumpTime == 0) {
                inJump = false;
            }
            jumpTime = 0;
         } else if(e.type == "help") {
             //e.visible = true;
             cast(e, TextEntity).activate();
             return false;
         }
         return true;
     }

    override public function moveCollideX(e:Entity)
    {
        if(e.type == "solid") {
            if(jumpTime == 0) {
                inJump = false;
            }
            jumpTime = 0;
         } else if(e.type == "help") {
             //e.visible = true;
             cast(e, TextEntity).activate();
             return false;
         }
         return true;
    }


    public override function update()
    {
        if(sprite.currentAnim == "wake" && !sprite.complete) {
            return;
        }

        handleInput();

        var ySpeed:Float = 4;
        if(inJump == true && jumpTime > 0) {
            ySpeed *= -0.9;
            jumpTime -= 1;
        }


        this.moveBy(acceleration, ySpeed, ["solid", "help"]);
        updateAnimation();
    }

    private function updateAnimation()
    {
        if(sprite.currentAnim == "jump" && inJump) {
            if(acceleration < 0) {
                sprite.flipped = true;
            } else if(acceleration < 0) {
                sprite.flipped = true;
            }
            return;
        }

        if(acceleration < 0) {
            sprite.flipped = true;
            sprite.play("walk");
        } else if(acceleration > 0) {
            sprite.flipped = false;
            sprite.play("walk");
        } else if(acceleration == 0) {
            sprite.play("idle");
        }

        if(inJump) {
            sprite.play("jump");
        }
    }


    private var sprite:Spritemap;
    private var acceleration:Float;
    private var inJump:Bool;
    private var jumpTime:Int = 0;
}

