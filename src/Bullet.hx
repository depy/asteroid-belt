import h2d.Bitmap;
import h2d.Tile;
import h2d.Object;
import h3d.Vector;
import hxd.BitmapData;

class Bullet {
    public var dead = false;
    var parentObject: Object;
    var bmp: Bitmap;
    var tile: Tile;
    var dir: Vector;
    var timer = 0.0;

    public function new(parentObject: Object, x: Float, y: Float, dir: Vector) {
        dir.scale(3);
        this.dir = dir;
        this.parentObject = parentObject;
        draw(x, y);
    }

    function draw(x: Float, y: Float) {
        var bmpData = new BitmapData(4, 4);
        bmpData.line(0,0, 3,0, 0xFF00FFFF);
        bmpData.line(0,0, 0,3, 0xFF00FFFF);
        bmpData.line(3,3, 0,3, 0xFF00FFFF);
        bmpData.line(3,3, 3,0, 0xFF00FFFF);

        this.tile = Tile.fromBitmap(bmpData);
        this.tile.setCenterRatio(0.5, 0.5);
        this.bmp = new Bitmap(tile, this.parentObject);
        bmp.setPosition(x, y);
    }

    public function update(dt: Float) {
        timer += dt;
        if (timer > 2) this.bmp.alpha -= 4 * dt;
        if (timer > 3) {
            this.dead = true;
            this.tile.dispose();
            this.parentObject.removeChild(this.bmp);
        } else {
            this.bmp.setPosition(this.bmp.x + dir.x, this.bmp.y + dir.y);

            if (this.bmp.x < -32) this.bmp.x = 832;
            if (this.bmp.y < -32) this.bmp.y = 632;
            
            if (this.bmp.x > 832) this.bmp.x = -32;
            if (this.bmp.y > 632) this.bmp.y = -32;
        }
    }
}