largeurSupport = 26;
taillePlatine = 155.2;
hauteurSupport = 33;
$fn = 20;

rotate(45) union() {
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

module support() {
	difference() {
		union() {
			translate([-13, 20.1, 0]) cube([26, 2.9, hauteurSupport]);
			translate([0, 20.1, 0]) rotate(180) fleche();
			translate([10.1, 0, 0]) cube([2.9, 23, hauteurSupport]);
			translate([10.1, 10, 0]) rotate(90) fleche();
			translate([-13, 0, 0]) cube([2.9, 23, hauteurSupport]);
			translate([-10.1, 10, 0]) rotate(-90) fleche();
		}
	translate ([0, 10, 23 ]) rotate([0, 90, 0]) cylinder(h = 50, r = 2, center = true);
	}
}

module fleche() {
	linear_extrude(height = 20, center = false, convexity = 10, twist = 0)
	union() {
		translate([-2.9, 0, 0]) square([5.5, 5]);
		hull() {
			translate([5.25, 2.25, 0]) circle(0.6, true);
			translate([-5.25, 2.25, 0]) circle(0.6, true);
			translate([-2.45, 4.75, 0]) circle(0.6, true);
			translate([2.45, 4.75, 0]) circle(0.6, true);
		}
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
