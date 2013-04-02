taille = 90;
tailleGuide = 10;
epaisseur = 5;
$fn = 20;

difference() {
	union() {
		translate([-taille / 2, -taille / 2,0]) cube([taille, taille, epaisseur]);
		for (i = [0 : 3]) {
			rotate(i * 90) {
				translate([taille / 2, taille / 2, 0]) {
					rotate(45) {
						guide(tailleGuide, 2 * tailleGuide, 2* epaisseur);
					}
				}
				translate([0, -taille / 2, 0]) {
					patteAccroche(20, 20, 25, epaisseur); // Largeur, Longueur, Hauteur, Epaisseur
				}
			}
		}
		translate([0, 0, epaisseur]) {
			renfort(20, epaisseur);
		}
	}
	translate([0, 0, epaisseur]) {
		ecrou(13, 5);
	}
}

module guide(largeur, longueur, epaisseur) {
	translate([largeur / 2, largeur / 2, 0]) rotate ([90, -90, 0]) linear_extrude(height = largeur, convexity = 10) 
	polygon([[0,0],[epaisseur,0],[epaisseur, longueur / 2],[0, longueur]]);
}

module ecrou(tailleEcrou, epaisseurEcrou) {
	union() {
		linear_extrude(height = epaisseurEcrou, center = true, convexity = 10, twist = 0)
		polygon(points =	[ [tailleEcrou, 0], [tailleEcrou * cos(60) , tailleEcrou * sin(60)], 
						[tailleEcrou * cos(120) , tailleEcrou * sin(120)], 
						[tailleEcrou * cos(180) , tailleEcrou * sin(180)], 
						[tailleEcrou * cos(240) , tailleEcrou * sin(240)], 
						[tailleEcrou * cos(300) , tailleEcrou * sin(300)]]);
		translate(v = [0, 0, -10]) {		
			cylinder(h=20, r=tailleEcrou * (4 / 13));
		}
	}
}

module patteAccroche(largeur, longueur , hauteur, epaisseur) {
	translate([-largeur / 2, - longueur, 0]) {
		union() {
			cube([largeur, longueur, epaisseur]);
			difference() {
				cube(size = [largeur, epaisseur, hauteur]);
				translate ([largeur / 2, 0, 2 * hauteur / 3]) 
				rotate ([90,0,0]) cylinder (h = 20, r = 2, center = true);
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