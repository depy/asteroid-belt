import h2d.Bitmap;
import h2d.Tile;
import h2d.Object;
import h3d.Vector;
import hxd.BitmapData;

class Asteroid {
    public var dead = false;
    var parentObject: Object;
    var bmp: Bitmap;
    var tile: Tile;
    var dir: Vector;
    var rot: Float;
    var timer = 0.0;

    public function new(parentObject: Object, x: Float, y: Float) {
        this.rot = 0.005;
        if (Math.random() > 0.5) this.rot = 0.025;
        if (Math.random() > 0.5) this.rot *= -1;

        this.dir = new Vector(Math.random(), Math.random(), 0);
        dir.scale(1);
        this.parentObject = parentObject;
        draw(x, y);
    }

    function draw(x: Float, y: Float) {
        var bmpData = new BitmapData(64, 64);
        var center = {x: 31, y: 31};
        var angle = 0.0;
        var r = 26;

        var px = Math.cos(angle) * r;
        var py = Math.sin(angle) * r;
        var pv = new Vector(px, py, 0);

        for (i in 0...8) {
            angle += Math.PI / 4;
            var x = Math.cos(angle) * r;
            var y = Math.sin(angle) * r;
            var v = new Vector(x, y, 0);
            bmpData.line(Std.int(pv.x)+31, Std.int(pv.y)+31, Std.int(v.x)+31, Std.int(y)+31, 0xFFFF00FF);
            px = x;
            py = y;
            pv = v;
        }

        bmpData.line(0, 0, 63, 0, 0xFF666666);
        bmpData.line(63, 0, 63, 63, 0xFF666666);
        bmpData.line(63, 63, 0, 63, 0xFF666666);
        bmpData.line(0, 63, 0, 0, 0xFF666666);

        this.tile = Tile.fromBitmap(bmpData);
        this.tile.setCenterRatio(0.5, 0.5);
        this.bmp = new Bitmap(tile, this.parentObject);
        bmp.setPosition(x, y);
    }

    public function update(dt: Float) {
        timer += dt;
        
        if (this.dead) {
            this.tile.dispose();
            this.parentObject.removeChild(this.bmp);
        } else {
            this.bmp.rotate(this.rot);
            this.bmp.setPosition(this.bmp.x + dir.x, this.bmp.y + dir.y);

            if (this.bmp.x < -64) this.bmp.x = 864;
            if (this.bmp.y < -64) this.bmp.y = 664;
            
            if (this.bmp.x > 864) this.bmp.x = -64;
            if (this.bmp.y > 664) this.bmp.y = -64;
        }
    }
}