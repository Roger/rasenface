package entities;

import com.haxepunk.Entity;
import com.haxepunk.graphics.Text;

class TextEntity extends Entity
{


    public function new(x:Float, y:Float, width:Int, heigh:Int,
                        text:String, duration:Int=0, starts:Int=0,
                        color:Int=0x202020, size:Int=20)
    {
        super(x, y);
        //setHitbox(width, height);

        _text = new Text();
        _text.resizable = true;
        _text.color = color;
        _text.size = size;
        _text.richText = text;

        _starts = starts;
        _duration = duration;
        this._active = false;
        graphic = _text;
        visible = false;
    }

    public function activate(force:Bool=false)
    {

        if(_duration == 0 && _starts == 0) {
            visible = true;
            _active = true;
            //trace("Duration is not set!");
            return;
        }

        if(_starts != 0 && !_active) {
            _active = true;
            var startTimer = new haxe.Timer(_starts);
            startTimer.run = function() {
                activate(true);
                startTimer.stop();
            }
            return;
        }


        if(_active == false || force) {
            visible = true;
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
