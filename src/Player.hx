import h3d.Vector;
import h2d.Tile;
import h2d.Bitmap;
import h2d.Object;
import hxd.BitmapData;
import hxd.Key in K;

class Player {
    static final MAX_SPEED = 0.1;
    static final SPEED_INCREMENT = 0.02;
    static final SPEED_DECREMENT = 0.01;
    static final DEBUG = true;

    var elapsedTime: Float;

    var parentObj: Object;
    var obj: Object;
    var ship: Bitmap;
    var fire: Bitmap;

    var speed: Float;
    var mspeed: Float;
    var dir = new Vector(0, 0, 0);
    var timer = 0.0;

    public function new(parentObject: h2d.Object, x: Int, y: Int) {
        this.speed = 0;

        this.parentObj = parentObject;
        this.obj = new Object(parentObject);
        this.obj.setPosition(x, y);
        
        draw(this.obj, x, y);
    }

    public function update(dt :Float) {
        timer += dt;

        decreaseSpeed();
        move();
        handleInput();
    }

    public function setPotision(x, y) {
        this.ship.setPosition(x, y);
    }

    public function getPosition() {
        return {x: this.obj.x, y: this.obj.y};
    }

    public function handleInput() {
        var left = K.isDown(K.LEFT);
		var right = K.isDown(K.RIGHT);
		var up = K.isDown(K.UP);
        var spc = K.isDown(K.SPACE);

        if (spc) shoot();

        if (left) this.obj.rotate(-Math.PI/48);
        else if (right) this.obj.rotate(Math.PI/48);

        if (up) {
            drawFire();
            increaseSpeed();
        } else {
            removeFire();
            this.speed = 0;
        }
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
        tile.setCenterRatio(0.5, 0.5);
        this.ship = new Bitmap(tile, parentObject);
        parentObject.setPosition(x, y);

        var bmpData2 = new BitmapData(8, 8);
        bmpData2.line(0,3, 7,0, 0xFFFF0000);
        bmpData2.line(0,4, 7,7, 0xFFFF0000);

        var tile2 = Tile.fromBitmap(bmpData2);
        this.fire = new Bitmap(tile2, this.obj);
        this.fire.setPosition(-16, -4);
        this.fire.alpha = 0;
    }

    function drawFire() {
        this.fire.alpha = 1;
    }

    function removeFire() {
        this.fire.alpha = 0;
    }

    function move() {
        var xd = Math.cos(this.obj.rotation);
        var yd = Math.sin(this.obj.rotation);
        var vec = new Vector(xd * speed, yd * speed, 0);
        this.dir = dir.add(vec);

        if (this.dir.length() > 5) {
            this.dir.normalize();
            this.dir.scale(5);
        }

        this.obj.setPosition(this.obj.x + this.dir.x, this.obj.y + this.dir.y);

        if (this.obj.x < -16) this.obj.x = 816;
        if (this.obj.y < -16) this.obj.y = 616;
        
        if (this.obj.x > 816) this.obj.x = -16;
        if (this.obj.y > 616) this.obj.y = -16;
    }

    function shoot() {
        if (timer > 0.5) {
            timer = 0;
            var xd = Math.cos(this.obj.rotation);
            var yd = Math.sin(this.obj.rotation);
            var vec = new Vector(xd, yd, 0);
            var b = new Bullet(this.obj.parent, this.obj.x + 6*xd, this.obj.y + 6*yd, vec);
            Game.getInstance().addBullet(b);
        }
    }
}