largeurSupport = 26;
taillePlatine = 155.2;
hauteurSupport = 33;
taille = 134;
largeurPatte = 20;
largeurGuide = 16;
epaisseur = 5;
$fn = 20;

rotate(45) union() {
	for (i = [0 : 3]) {
		rotate([0, 0, i * 90]) {
			translate([0, 54.6,0]) support();
		}
	}
	difference() {
		platine();
		for (i = [0 : 3]) {
			rotate([0, 0, i * 90]) translate([40, 40,0]) trouDeVis();
		}
	}
	supportMoteur();
}
	for (i = [0 : 3]) {
		rotate([0, 0, i * 90 + 45]) {
			translate([0, 64.6,3]) color([0.8, 0.8, 0.8]) profile();
		}
	}
translate([0, 0, 306]) rotate([180, 0, 45]) union() {
	for (i = [0 : 3]) {
		rotate([0, 0, i * 90]) {
			translate([0, 54.6,0]) support();
		}
	}
	difference() {
		platine();
		cylinder(h = 20, r = 4.2, center = true);
	}
}

translate([0, 0, 3]) moteur();
translate([0, 0, 41]) plaque();
translate([0, 0, 150]) color([1, 0, 0])
difference() {
	union() {
		plateForme(taille, largeurPatte);
		for (i = [0 : 3]) {
			rotate(i * 90) {
				translate([taille / 4 + largeurPatte / 4, taille / 4 + largeurPatte / 4, 0]) {
					rotate(45) {
						guide(largeurGuide, epaisseur);
					}
				}
				translate([0, -taille / 2 - 0.01, 0]) { // 
					patteAccroche(20, 25, epaisseur); // Largeur, Hauteur, Epaisseur
				}
			}
		}
		translate([0, 0, epaisseur]) {
			renfortEcrou(20, epaisseur);
		}
	}
	translate([0, 0, epaisseur]) {
		ecrou(13, 5);
	}
}

translate([0, 0, 62]) color([0.8, 0.8, 0.8]) cylinder(h = 245, r = 4);
translate([0, 0, 62]) color([0, 0, 0]) cylinder(h = 20, r = 7, center = true);

module plateForme(taille, largeurPatte) {
	linear_extrude(height = epaisseur, center = false, convexity = 10, twist = 0)
	polygon([	[-taille / 2, largeurPatte / 2], [-largeurPatte / 2, taille / 2],
				[largeurPatte / 2, taille / 2], [taille / 2, largeurPatte / 2],
				[taille / 2, -largeurPatte / 2], [largeurPatte / 2, -taille / 2],
				[-largeurPatte / 2, -taille / 2], [-taille / 2, -largeurPatte / 2]
	]);
}

module guide(largeur, epaisseur) {
	translate([-epaisseur, -largeur / 2, 0]) cube([epaisseur, largeur, 15]);
	translate([0, -2.9, 0]) cube([5.3, 5.8, 15]);
}

module ecrou(tailleEcrou, epaisseurEcrou) {
	union() {
		linear_extrude(height = epaisseurEcrou, center = true, convexity = 10, twist = 0)
		polygon(points =	[ [tailleEcrou, 0], 
						[tailleEcrou * cos(60), tailleEcrou * sin(60)], 
						[tailleEcrou * cos(120), tailleEcrou * sin(120)], 
						[tailleEcrou * cos(180), tailleEcrou * sin(180)], 
						[tailleEcrou * cos(240), tailleEcrou * sin(240)], 
						[tailleEcrou * cos(300), tailleEcrou * sin(300)]]);
		translate(v = [0, 0, -10]) {		
			cylinder(h=20, r=tailleEcrou * (4 / 13));
		}
	}
}

module patteAccroche(largeur, hauteur, epaisseur) {
	difference() {
		translate([-largeur / 2, , 00]) 		
		rotate([90, 0, 90]) 
		linear_extrude(height = largeur, center = false, convexity = 10, twist = 0)
		polygon([	[0, 0], [2 * epaisseur, 0],
					[2 * epaisseur, epaisseur], [epaisseur, 2 * epaisseur],
					[epaisseur, hauteur], [0, hauteur]
		]);
		translate ([0, 0, 2 * hauteur / 3]) 
		rotate ([90,0,0]) cylinder (h = 20, r = 2, center = true);
	}
}

module renfortEcrou(diametre, epaisseur) {
	translate([0,0, epaisseur / 2]) {
		rotate_extrude(convexity = 10) {
			difference() {
				union() {
					translate([(diametre - epaisseur) / 2, 0, 0]) square([diametre - epaisseur, epaisseur], true);
					translate([(diametre - epaisseur) , 0, 0]) circle(epaisseur / 2);
					translate([(diametre - epaisseur), -epaisseur /2, 0]) square([epaisseur, epaisseur /2]);
				}
				translate([diametre, 0, 0]) circle(epaisseur / 2);
			}
		}
	}
}

module plaque() {
	union() {
		difference() {
			translate([-24.5, -24.5, 0]) cube([49, 49, 3]);
			cylinder(h = 10, r = 11.1, center = true);
		}
		for (i = [1 : 3]) {
			rotate([0, 0, i * 90]) translate([-5, 24, 0]) {
				difference() {
					cube([10, 10, 3]);
					translate([5, 5, 0]) cylinder(h = 20, r = 2, center = true); 
				}
			}
		}
	}
}

module moteur() {
	color([0, 0, 0])
	linear_extrude(height = 38, convexity = 10)
	hull() {
		for (i = [0:3]) {
			rotate(i * 90) {
				translate([19, 16.65, 0]) circle(2.15);
				translate([16.65, 19, 0]) circle(2.15);
			}
		}
	}
	color([0.8, 0.8, 0.8]) translate([0, 0, 38]) cylinder(h = 2, r = 11);
	color([0.8, 0.8, 0.8]) translate([0, 0, 38]) cylinder(h = 24, r = 2.5);
}

module profile() {
	linear_extrude(height = 300, convexity = 10)
	difference() {
		translate([-8.5, -8.5, 0]) {
			minkowski() {
				square([17, 17]);
				circle(1.5);
			}
		}
		for (i = [0:3]) {
			rotate(i * 90)
			polygon([	[-3, -10], [-3, -8.5], [-6, -8.5], [-6, -7], [-3.5, -4.5], 
						[3.5, -4.5], [6, -7], [6, -8.5], [3, -8.5], [3, -10]	]);
		}
		circle(2.75);
	}
}

module support() {
	union() {
		translate([-13, 20, 0]) cube([26, 3, hauteurSupport]);
		translate([0, 20, 0]) rotate(180) fleche();
		translate([10, 0, 0]) cube([3, 23, hauteurSupport]);
		translate([10, 10, 0]) rotate(90) fleche();
		translate([-13, 0, 0]) cube([3, 23, hauteurSupport]);
		translate([-10, 10, 0]) rotate(-90) fleche();
	}
}

module platine() {
	linear_extrude(height = 3, center = false, convexity = 10, twist = 0)
	polygon([	[-taillePlatine / 2, largeurSupport / 2], [-largeurSupport / 2, taillePlatine / 2],
				[largeurSupport / 2, taillePlatine / 2], [taillePlatine / 2, largeurSupport / 2],
				[taillePlatine / 2, -largeurSupport / 2], [largeurSupport / 2, -taillePlatine / 2],
				[-largeurSupport / 2, -taillePlatine / 2], [-taillePlatine / 2, -largeurSupport / 2]
	]);
}

module fleche() {
	linear_extrude(height = 20, center = false, convexity = 10, twist = 0)
	union() {
		translate([-2.9, 0, 0]) square([5.8, 5]);
		hull() {
			translate([5.25, 2.25, 0]) circle(0.7, true);
			translate([-5.25, 2.25, 0]) circle(0.7, true);
			translate([-2.25, 4.75, 0]) circle(0.7, true);
			translate([2.25, 4.75, 0]) circle(0.7, true);
		}
	}
}

module trouDeVis() {
	cylinder(h = 20, r = 2, center = true);
}

module supportMoteur() {
	rotate(-45) union() {
		difference() {
			translate([-24.5, -24.5, 0]) cube([49, 49, 41]);
			translate([-21.25, -21.25, -10]) cube([42.5, 42.5, 60]);
			translate([-5, 20, -10])cube([10, 10, 60]);
		}
		for (i = [1 : 3]) {
			rotate([0, 0, i * 90]) translate([-5, 24, 0]) {
				difference() {
					cube([10, 10, 41]);
					translate([5, 5, 41]) cylinder(h = 20, r = 1.5, center = true); 
				}
			}
		}
		
	}
}