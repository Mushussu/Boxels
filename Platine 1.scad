largeurSupport = 26;
taillePlatine = 155.2;
hauteurSupport = 30;

for (i = [0 : 3]) {
	rotate([0, 0, i * 90]) {
		translate([0, 54.6,0])
	support();
	}
}
platine();

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