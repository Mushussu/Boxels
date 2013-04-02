$fn = 20;

difference() {
	translate([-21, -13]) cube([42, 26, 13.5]);
	translate([0, 0, 9.25]) ecrou(16, 8.5, 10);
	translate([15, 0, -20]) cylinder(h = 40, r = 2);
	translate([-15, 0, -20]) cylinder(h = 40, r = 2);

}

module ecrou(tailleEcrou, epaisseurEcrou, diametreTige) {
	r = tailleEcrou / (2 * sin(60));
	union() {
		linear_extrude(height = epaisseurEcrou, center = true, convexity = 10, twist = 0)
		polygon(points =	[ [r, 0], 
						[r * cos(60), r * sin(60)], 
						[r * cos(120), r * sin(120)], 
						[r * cos(180), r * sin(180)], 
						[r * cos(240), r * sin(240)], 
						[r * cos(300), r * sin(300)]]);
		translate(v = [0, 0, -10]) {		
			cylinder(h = 100, r = diametreTige / 2);
		}
	}
}