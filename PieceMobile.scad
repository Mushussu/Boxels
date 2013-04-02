$fn = 20;

diametreTubeExt = 15.7;
diametreTige = 10.4;

difference() {
	translate([-38, -13,0]) cube([76, 26, 30]);
	translate([25, 0,0]) rotate(-45) cube([20, 20, 30]);
	translate([-25, 0,0]) rotate(135) cube([20, 20, 30]);
	cylinder(h = 100, r = diametreTige / 2); // Empreinte de la tige filetée
	translate([0, 0, 5]) cylinder(h = 30, r = diametreTubeExt / 2); // Empreinte du tube guide
	translate([15, 0, -10]) cylinder(h = 30, r = 1.5); // Empreinte de vis
	translate([15, 0, 20]) cylinder(h = 1.5, r1 = 1.5, r2 = 0);
	translate([-15, 0, -10]) cylinder(h = 30, r = 1.5); // Empreinte de vis
	translate([-15, 0, 20]) cylinder(h = 1.5, r1 = 1.5, r2 = 0);
}
translate([25, 0,0]) rotate(-45) extremite();
translate([-25, 0,0]) rotate(135) extremite();

module extremite() {
	difference() {
		cube([21, 21, 30]);
		translate([3, 3, 0]) cube([21, 21, 30]);
	}
	translate([10.1, 3, 0]) cube([5.8, 4.5, 30]);
	translate([3, 10.1, 0]) cube([4.5, 5.8, 30]);
}

