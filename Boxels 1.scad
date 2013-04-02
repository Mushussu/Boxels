
epaisseur = 1;

difference() {
	union() {
		translate([-5, -5,0]) cube([10, 10, epaisseur]);
		for (i = [0 : 3]) {
			rotate(a = i * 90) {
				translate(v = [5, 5, 0]) {
					rotate(a = 45) {
						translate([-0.5, -0.5,0]) {
							cube([1, 1, epaisseur]);
						}
					}
				}
				translate(v = [15, 0, 0]) patteAccroche(3, 5, 5, epaisseur);
			}
		}
		translate([0, 0, epaisseur]) {
			renfort(2.5, 1);
		}
	}
	translate([0, 0, 1]) {
		ecrou(1);
	}
}

module ecrou(tailleEcrou) {
	union() {
		linear_extrude(height = 1, center = true, convexity = 10, twist = 0)
		polygon(points =	[ [tailleEcrou, 0], [tailleEcrou * cos(60) , tailleEcrou * sin(60)], 
						[tailleEcrou * cos(120) , tailleEcrou * sin(120)], 
						[tailleEcrou * cos(180) , tailleEcrou * sin(180)], 
						[tailleEcrou * cos(240) , tailleEcrou * sin(240)], 
						[tailleEcrou * cos(300) , tailleEcrou * sin(300)]]);
		translate(v = [0, 0, -10]) {		
			cylinder(h=20, r=tailleEcrou * (8 / 13),$fn=20);
		}
	}
}

module patteAccroche(largeur, longueur , hauteur, epaisseur) {
	translate([-longueur, - largeur / 2, 0]) rotate(a = 90) {
		union() {
			cube([largeur, longueur + 0.1, epaisseur]); // Le 0.1 sert à bien imbriquer le module
			difference() {
				cube(size = [largeur, epaisseur, hauteur]);
				translate ([largeur / 2, 0, 2 * hauteur / 3]) 
				rotate ([90,0,0]) cylinder (h = 4, r = 0.3, center = true, $fn = 20);
			}
			polyhedron(
				points =	[ [0,epaisseur,epaisseur], [0, 2 * epaisseur, epaisseur],
						[0, epaisseur, 2 * epaisseur], [largeur,epaisseur,epaisseur],
						[largeur, 2 * epaisseur, epaisseur], [largeur, epaisseur, 2 * epaisseur]  ],
				triangles = 	[ [0, 1, 2], [3, 5, 4], [0, 2, 3], [2, 5, 3], [1, 4, 5], [1, 5, 2] ,
						[1, 0, 4], [4, 0, 3] ]
			);
		}
	}
}

module renfort(diametre, epaisseur) {
	translate([0,0, epaisseur / 2]) {
		rotate_extrude(convexity = 10, $fn = 20) {
			difference() {
				union() {
					translate([(diametre - epaisseur) / 2, 0, 0]) square([diametre - epaisseur, epaisseur], true);
					translate([(diametre - epaisseur) , 0, 0]) circle(epaisseur / 2, $fn = 20);
					translate([(diametre - epaisseur), -epaisseur /2, 0]) square([epaisseur, epaisseur /2]);
				}
				translate([diametre, 0, 0]) circle(epaisseur / 2, $fn = 20);
			}
		}
	}
}