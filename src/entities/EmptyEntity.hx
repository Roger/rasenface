package entities;

import com.haxepunk.Entity;


class EmptyEntity extends Entity
{
    public function new(x:Float, y:Float, width:Int, height:Int, type:String)
    {
        super(x, y);
        setHitbox(width, height);
        this.type = type;
        data = new Map<String,Dynamic>();
    }

    public var data:Map<String,Dynamic>;
}
