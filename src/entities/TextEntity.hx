package entities;

import com.haxepunk.Entity;
import com.haxepunk.graphics.Text;

class TextEntity extends Entity
{


    public function new(x:Float, y:Float, text:String, duration:Int=null,
                        starts:Int=null, color:Int=0x202020, size:Int=20)
    {
        super(x, y);

        _text = new Text();
        _text.resizable = true;
        _text.color = color;
        _text.size = size;
        _text.richText = text;

        _starts = starts;
        _duration = duration;
        this._active = false;

        graphic = _text;
    }

    public function activate()
    {

        if(_duration == null) {
            visible = true;
            _active = true;
            //trace("Duration is not set!");
            return;
        }

        if(_active == false) {
            visible = true;
            trace("HAI!" + _duration);
            _active = true;
            var timer = new haxe.Timer(_duration);
            timer.run = function() {
                visible = false;
                timer.stop();
            }
        }
    }

    private var _text:Text;
    private var _duration:Int;
    private var _starts:Int;
    private var _active:Bool;
}
