$fn = 20;
plaque();

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