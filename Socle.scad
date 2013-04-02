$fn = 20;
epaisseurPlatine = 3;
tailleMoteur = 43;
hauteurMoteur = 40;

diametreTubeExt = 15.7;
diametreTige = 10.4;

translate([-40.68, -40.68, 0]) cube([87.35, 87.35, 5]);

rotate(45) {
	difference() {
		translate([-38, -11.5,0]) cube([76, 23, 35]);
		translate([25, 0,0]) rotate(-45) cube([20, 20, 35]);
		translate([-25, 0,0]) rotate(135) cube([20, 20, 35]);
		translate([-tailleMoteur / 2, -tailleMoteur / 2, -10]) cube([tailleMoteur, tailleMoteur, 60]);
	}
	translate([25, 0,0]) rotate(-45) extremite();
	translate([-25, 0,0]) rotate(135) extremite();
}

supportMoteur();

module extremite() {
	cube([21, 3, 35]);
	cube([3, 21, 35]);
	translate([10.1, 3, 0]) cube([5.8, 4.5, 35]);
	translate([3, 10.1, 0]) cube([4.5, 5.8, 35]);
}

module supportMoteur() {
	 rotate(45) union() {
		difference() {
			translate([-(tailleMoteur + 6) / 2, -(tailleMoteur + 6) / 2, 0]) 
				cube([tailleMoteur + 6, tailleMoteur + 6, hauteurMoteur + epaisseurPlatine]);
			translate([-tailleMoteur / 2, -tailleMoteur / 2, -10]) cube([tailleMoteur, tailleMoteur, 60]);
			translate([-5, 20, -10])cube([10, 10, 60]);
		}
		// Supports de vis
		translate([-5, -(tailleMoteur + 6) / 2 - 10, 0]) {
			difference() {
				cube([10, 10, hauteurMoteur + epaisseurPlatine]);
				translate([5, 5, hauteurMoteur + epaisseurPlatine]) cylinder(h = 20, r = 1.5, center = true); 
			}
		}
		translate([(tailleMoteur + 6) / 2, (tailleMoteur + 6) / 2 - 13, 0]) {
			difference() {
				cube([10, 10, hauteurMoteur + epaisseurPlatine]);
				translate([5, 5, hauteurMoteur + epaisseurPlatine]) cylinder(h = 20, r = 1.5, center = true); 
			}
		}
		translate([-(tailleMoteur + 6) / 2 - 10, (tailleMoteur + 6) / 2 - 13, 0]) {
			difference() {
				cube([10, 10, hauteurMoteur + epaisseurPlatine]);
				translate([5, 5, hauteurMoteur + epaisseurPlatine]) cylinder(h = 20, r = 1.5, center = true); 
			}
		}
	}
}