taille = 134;
largeurPatte = 20;
largeurGuide = 16;
epaisseur = 5;
$fn = 20;

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

//translate([taille / 4 + largeurPatte / 4, taille / 4 + largeurPatte / 4, 0]) {
//					rotate(45) {
//						translate([0, -10, 0]) cube(20);
//					}
//				}

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