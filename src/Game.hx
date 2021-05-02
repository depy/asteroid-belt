class Game extends hxd.App {
    var p: Player;

    override function init() {
        s2d.scale(2);
        p = new Player(s2d, 100, 100);
    }

    override function update(dt: Float) {
        p.update(dt);
    }
}