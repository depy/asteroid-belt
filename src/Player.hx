import h2d.Tile;
import h2d.Bitmap;
import h2d.Object;
import hxd.BitmapData;
import hxd.Key in K;

class Player {
    static final MAX_SPEED = 4;
    static final SPEED_INCREMENT = 0.1;
    static final SPEED_DECREMENT = 0.01;
    static final DEBUG = true;

    var elapsedTime: Float;

    var obj: Object;
    var bmp: Bitmap;
    var speed: Float;

    public function new(parentObject: h2d.Object, x: Int, y: Int) {
        this.speed = 0;
        this.obj = new Object(parentObject);
        draw(this.obj, x, y);
        this.obj.setPosition(x, y);
    }

    public function update(dt :Float) {
        decreaseSpeed();
        move();
        handleInput();
    }

    public function setPotision(x, y) {
        this.bmp.setPosition(x, y);
    }

    public function getPosition() {
        return {x: this.bmp.x, y: this.bmp.y};
    }

    public function handleInput() {
        var left = K.isDown(K.LEFT);
		var right = K.isDown(K.RIGHT);
		var up = K.isDown(K.UP);
        var spc = K.isDown(K.SPACE);

        if (left) this.obj.rotate(-Math.PI/32);
        else if (right) this.obj.rotate(Math.PI/32);

        if (up) increaseSpeed();
    }

    function increaseSpeed() {
        this.speed += SPEED_INCREMENT;
        if (this.speed >= MAX_SPEED) this.speed = MAX_SPEED;
    }

    function decreaseSpeed() {
        this.speed -= SPEED_DECREMENT;
        if (this.speed <= 0) this.speed = 0;
    }

    function draw(parentObject, x: Int, y: Int) {
        var bmpData = new BitmapData(16, 16);
        bmpData.line(0,0, 15,7, 0xFFFFFFFF);
        bmpData.line(15,8, 0,15, 0xFFFFFFFF);
        bmpData.line(0,0, 0,15, 0xFFFFFFFF);

        var tile = Tile.fromBitmap(bmpData);
        tile.setCenterRatio(0.5, 0.6);
        this.bmp = new Bitmap(tile, parentObject);
        parentObject.setPosition(x, y);
    }

    function move() {
        this.obj.move(this.speed, this.speed);
    }
}