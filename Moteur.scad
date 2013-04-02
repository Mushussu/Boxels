$fn = 20;
tailleMoteur = 40;
tailleExtremite = 10;

moteur();

module moteur() {
	color([0.8, 0.8, 0.8]) corps(tailleExtremite);
	color([0, 0, 0]) translate([0, 0, tailleExtremite]) corps(tailleMoteur - 2 * tailleExtremite);
	color([0.8, 0.8, 0.8]) translate([0, 0, tailleMoteur - tailleExtremite]) corps(tailleExtremite);
	color([0.8, 0.8, 0.8]) translate([0, 0, tailleMoteur]) cylinder(h = 2, r = 11);
	color([0.8, 0.8, 0.8]) translate([0, 0, tailleMoteur]) cylinder(h = 24, r = 2.5);
}

module corps(hauteur) {
	linear_extrude(height = hauteur, convexity = 10)
	hull() {
		for (i = [0:3]) {
			rotate(i * 90) {
				translate([19, 16.65, 0]) circle(2.15);
				translate([16.65, 19, 0]) circle(2.15);
			}
		}
	}
}