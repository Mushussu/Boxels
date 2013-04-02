$fn = 20;

color([0.8, 0.8, 0.8]) profile();

module profile() {
	linear_extrude(height = 60, convexity = 10)
	difference() {
		translate([-8.5, -8.5, 0]) {
			minkowski() {
				square([17, 17]);
				circle(1.5);
			}
		}
		for (i = [0:3]) {
			rotate(i * 90)
			polygon([	[-3, -10], [-3, -8.5], [-6, -8.5], [-6, -7], [-3.5, -4.5], 
						[3.5, -4.5], [6, -7], [6, -8.5], [3, -8.5], [3, -10]	]);
		}
		circle(2.75);
	}
}