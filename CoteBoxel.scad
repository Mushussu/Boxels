$fn = 50;

boxel();
//cote();
//top();

module top() {
	difference() {
		union() {
			square([137,35]);
			translate([3, 35, 0]) square([137,35]);
			translate([0, 70, 0]) square([137,35]);
			translate([3, 105, 0]) square([137,35]);
		}
		translate([35, 137, 0]) square([35, 20]);
		translate([105, 137, 0]) square([35, 20]);
		translate([0, -17, 0]) square([35, 20]);
		translate([70, -17, 0]) square([35, 20]);
	}
}

module cote() {
	difference() {
		union() {
			for (i = [0:4]) {
				translate([0, (1000 * i) / 9, 0])  square([137,500 / 9]);
			}
			for (i = [0:3]) {
				translate([3,  + (1000 * i + 500) / 9, 0])  square([137,500 / 9]);
			}
		}
		translate([35, 497, 0]) square([35, 20]);
		translate([105, 497, 0]) square([35, 20]);
		translate([70, 25, 0]) circle(2);
		translate([70, 85, 0]) circle(2);
	}
}

module boxel() {
	translate([0, 3, 0]) rotate([90, 0, 0]) linear_extrude(height = 3, convexity = 10, twist = 0) cote();
	color([1, 0, 0]) translate([137, 0, 0]) rotate([90, 0, 90]) linear_extrude(height = 3, convexity = 10, twist = 0) cote();
	translate([140, 137, 0]) rotate([90, 0, 180]) linear_extrude(height = 3, convexity = 10, twist = 0) cote();
	color([1, 0, 0]) translate([3, 140, 0]) rotate([90, 0, -90]) linear_extrude(height = 3, convexity = 10, twist = 0) cote();
	color([0, 1, 0]) translate([0, 0, 497]) linear_extrude(height = 3, convexity = 10, twist = 0) top();
}