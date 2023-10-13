// 3D Printed Spacer for RCBus Modules
//
// Copyright (C) 2023 Sergey Kiselev.
//
// This program is free software: you can redistribute it and/or modify
// it under the terms of the GNU General Public License as published by
// the Free Software Foundation, either version 3 of the License, or
// (at your option) any later version.
//
// This program is distributed in the hope that it will be useful,
// but WITHOUT ANY WARRANTY; without even the implied warranty of
// MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
// GNU General Public License for more details.
//
// You should have received a copy of the GNU General Public License
// along with this program.  If not, see <http://www.gnu.org/licenses/>.

in2mm=25.4;
pcb_thickness=1.6;
card_spacing=0.6*in2mm;
spacer_height=card_spacing-pcb_thickness;
spacer_width=5.5;
spacer_radius=spacer_width/sqrt(3);
spacer_faces=6;
m3_screw_length=8;
m3_tap_hole_radius=1.45;
m3_tap_hole_depth=m3_screw_length-pcb_thickness+0.2;
screw_head_radius=5.7/2;
screw_head_height=3;
head_radius=4.5;
head_height=screw_head_height;
skirt_height=2;
bevel = 0.2;

tolerance=0.1;
$fn=90;

rotate([90,0,0]) color("blue") card_spacer();

module card_spacer() {
    difference() {
        union() {
            // bevel at the bottom of the spacer
            cylinder(bevel,r1=spacer_radius-bevel,r2=spacer_radius, $fn=6);
            // spacer - hexagonal part
            translate([0,0,bevel]) {
                cylinder(h=spacer_height-bevel,r=spacer_radius,$fn=spacer_faces);
            }
            // spacer - skirt to the head
            translate([0,0,spacer_height-head_height-skirt_height]) {
                cylinder(h=skirt_height,r1=spacer_radius,r2=head_radius);
            }
            // head
            translate([0,0,spacer_height-head_height]) {
                cylinder(h=head_height-bevel,r=head_radius);
            }
            // bevel at the top of the spacer
            translate([0,0,spacer_height-bevel]) {
                cylinder(h=bevel,r1=head_radius,r2=head_radius-bevel);
            }
        }
        translate([0,0,-tolerance]) {
            // hole for M3 screw
            cylinder(h=m3_tap_hole_depth+tolerance,r=m3_tap_hole_radius);
            // bevel for the screw enterance
            cylinder(h=bevel+tolerance,r1=m3_tap_hole_radius+bevel+tolerance,r2=m3_tap_hole_radius);
        }
        // cutout for the screw head
        translate([0,0,spacer_height-screw_head_height-tolerance]) {
            cylinder(h=screw_head_height+tolerance*2,r=screw_head_radius+tolerance);
        }
        // bevel for the screw head
        translate([0,0,spacer_height-bevel]) {
            cylinder(h=bevel+tolerance,r1=screw_head_radius+tolerance,r2=screw_head_radius+bevel+tolerance);
        }
        translate([-head_radius-tolerance,-head_radius-tolerance,spacer_height-head_height-skirt_height-tolerance]) {
            cube([head_radius*2+tolerance*2,head_radius-spacer_width/2+tolerance,head_height+skirt_height+tolerance*2]);
        }
        translate([-head_radius-tolerance,spacer_width/2,spacer_height-head_height-skirt_height-tolerance]) {
            cube([head_radius*2+tolerance*2,head_radius-spacer_width/2+tolerance,head_height+skirt_height+tolerance*2]);
        }
    }
}