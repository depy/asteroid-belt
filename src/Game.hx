class Game extends hxd.App {
    static final WIN_WIDTH = 800;
    static final WIN_HEIGHT = 600;
    static var instance: Game;
    var p: Player;
    var bullets = new Array<Bullet>();
    var asteroids = new Array<Asteroid>();
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

        for (i in 0...5) {
            asteroids.push(new Asteroid(s2d, Math.random() * WIN_WIDTH, Math.random() * WIN_HEIGHT));
        }
    }

    override function update(dt: Float) {
        timer += dt;

        if (timer > 1) {
            timer = 0;
            trace('Bullets: ${bullets.length} :: Scene children ${s2d.numChildren}');
        }

        p.update(dt);
        
        for (b in bullets) {
            if (b.dead) bullets.remove(b);
            else b.update(dt);
        }

        for (a in asteroids) {
            if (a.dead) asteroids.remove(a);
            else a.update(dt);
        }
    }
}