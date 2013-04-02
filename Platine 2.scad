largeurSupport = 26;
taillePlatine = 155.2;
hauteurSupport = 30;
$fn = 5;

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