class Game extends hxd.App {
    var p: Player;

    override function init() {
        s2d.scale(2);
        p = new Player(s2d, 50, 50);
    }

    override function update(dt: Float) {
        p.update();
    }
}