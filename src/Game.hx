class Game extends hxd.App {
    static var instance: Game;
    var p: Player;
    var bullets = new Array<Bullet>();
    var timer = 0.0;

    public static function getInstance() {
        if (instance == null) instance = new Game();
        return instance;
    }

    public function getScene() {
        return s2d;
    }

    public function addBullet(bullet: Bullet) {
        bullets.push(bullet);
    }

    override function new() {
        super();
    }

    override function init() {
        s2d.scale(2);
        p = new Player(s2d, 100, 100);
    }

    override function update(dt: Float) {
        timer += dt;

        if (timer > 1) {
            timer = 0;
            trace("Bullets: ", bullets.length);
            trace("s2d children: ", s2d.numChildren);
        }

        p.update(dt);
        for (b in bullets) {
            if (b.dead) {
                bullets.remove(b);
            } else {
                b.update(dt);
            }
        }
    }
}