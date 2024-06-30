$fn=50;

thickness = 1/8;
g = 3/4; //outer width spacer dim
j = 1/32; //gap space between parts for fit tolerance
w = 8.25 - (2 * g);
d = 9;
h = 1.5;

module openTop(w, d, h, t=1) {
    inner = [w-(2*t), d-(2*t), h];
    outer = [w,d,h];

    difference() {
        cube(outer);
        translate([t,t,t]) cube(inner);
    }
}

module drawer(w, d, h, t=1) {
    difference() {
        openTop(w, d, h, t);
        translate([w/2, d+0.5, h * 1.1])
            resize([w/3,2,h], [1,1,1])
                rotate([90,0,0])
                    cylinder((2 * thickness), r=5);
    }
}

module cabinetBase(w, d, h, t=1) {
    difference() {
        openTop(w, d, h, t);
        translate([t, 2 * t + 1, t]) cube([w - (2 * t), d - (2 * t), h]);
    }
}

module cabinetWithDrawer(w, d, h, g, t=1) {
    dw = w - t - g;
    dd = d - t;
    dh = h - t;

    union() {
        translate([g,0,h])
            mirror([0,0,1])
                cabinetBase(w, d, h, t);
        cube([g, d, h]);
        translate([w,0,0]) cube([g, d, h]);
    }

    translate([t + j, t + j, 0])
        translate([g,0,0])
            drawer(dw-(2*j), dd-j, dh-j, t);
}

translate([j/2,0,0]) cabinetWithDrawer(w,d,h,g,thickness);