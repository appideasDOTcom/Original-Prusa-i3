// PRUSA iteration3
// X end prototype
// GNU GPL v3
// Josef Průša <iam@josefprusa.cz> and contributors
// http://www.reprap.org/wiki/Prusa_Mendel
// http://prusamendel.org

use <bearing.scad>
use <polyholes.scad>
rod_distance = 45;

module x_end_base(){
// Main block
height = 58;
translate(v=[-15,-9,height/2]) cube(size = [17,39,height], center = true);
// Bearing holder
 vertical_bearing_base();	
//Nut trap
 // Cylinder
   translate(v=[0,-17,0]) poly_cylinder(h = 8, r=12.5, $fn=25);
 // Hexagon
 //translate(v=[0,-17,0]) rotate([0,0,30]) cylinder(h = 8, r=8, $fn = 6);
translate(v=[-6,-10.6,10]) rotate([0,0,48.2]) cube(size = [10,5,1], center = true);
}

module x_end_holes(){
vertical_bearing_holes();
// Belt hole
translate(v=[-1,0,0]){
// Stress relief
translate(v=[-5.5-10+1.5,-10-1,30]) cube(size = [18,1,28], center = true);
difference(){
	translate(v=[-5.5-10+1.5,-10,30]) cube(size = [10,46,28], center = true);

	

	// Nice edges
  // Cutting a few mm from the "Nice edges" to use a 6mm pulley.
  // Bottom (model is rendered upside-down for printing)
  translate( [0, 0, 3] )
  {
  	translate(v=[-5.5-10+1.5-5,-10,30+23]) rotate([0,20,0]) cube(size = [10,46,28], center = true);
	  translate(v=[-5.5-10+1.5+5,-10,30+23]) rotate([0,-20,0]) cube(size = [10,46,28], center = true);
  }

  // Top
  translate( [0, 0, -1] )
  {
    translate(v=[-5.5-10+1.5,-10,30-23]) rotate([0,45,0]) cube(size = [10,46,28], center = true);
    translate(v=[-5.5-10+1.5,-10,30-23]) rotate([0,-45,0]) cube(size = [10,46,28], center = true);
  }

}
}

// Bottom pushfit rod
translate(v=[-15,-41.5,6]) rotate(a=[-90,0,0]) pushfit_rod(7.8,50);
// Top pushfit rod
translate(v=[-15,-41.5,rod_distance+6]) rotate(a=[-90,0,0]) pushfit_rod(7.8,50);

customNutInsetWidth = 10.6;
customNutInsetLength = 22.5;
customNutInsetDepth = 3.8;


// TR Nut trap
   // Hole for the nut
   // Using a different nut
   customNutRadius = 5.2; // original: 6.6
    translate(v=[0,-17, -1]) poly_cylinder(h = 9.01, r = customNutRadius, $fn = 25);

    // This will cutout a trap for the nut, but that won't print without suports
    // translate(v=[-1 * (customNutInsetLength/2),-17 + (customNutInsetWidth/3) + 0.2, -0.1])  
    // {
    //   rotate( [0, 0, -45] )
    //   {
    //     cube( [customNutInsetLength, customNutInsetWidth, customNutInsetDepth + 0.1] );
    //     // add an extra length at the end to avoid having a small hanging piece of plastic remaining on the ledge
    //     translate( [customNutInsetLength - 0.1, 0, 0] )
    //     {
    //       cube( [5, customNutInsetWidth, customNutInsetDepth + 0.1] );
    //     }
    //   }
    // }

// Screw holes for TR nut
  customScrewHoleOffset = 8; // original: 9.5
  customThroughHoleRadius = 1.65; // Use 1.65 to make the through-holes not press-fit to nuts and bolts. Use 1.2 for a pilot hole for a #4 wood screw. Original: 1.55
    translate(v=[0,-17, 0]) rotate([0, 0, -135]) translate([0, customScrewHoleOffset, -1]) cylinder(h = 10, r = customThroughHoleRadius, $fn=25);
    translate(v=[0,-17, 0]) rotate([0, 0, -135]) translate([0, (-1 * customScrewHoleOffset), -1]) cylinder(h = 10, r = customThroughHoleRadius, $fn=25);

// Nut traps for TR nut screws
// Comment to use press-fit (self-threading) wood screws
    translate(v=[0,-17, 0]) rotate([0, 0, -135]) translate([0, customScrewHoleOffset, 6]) rotate([0, 0, 0])cylinder(h = 3, r = 3.3, $fn=6);

    translate(v=[0,-17, 0]) rotate([0, 0, -135]) translate([0, (-1 * customScrewHoleOffset), 6]) rotate([0, 0, 30])cylinder(h = 3, r = 3.2, $fn=6);
    translate([-5.5,-17.2,6]) rotate([0,0,30]) cube([5,5,3]);
    translate([-0,-17.2,6]) rotate([0,0,60]) cube([5,10,3]);
}


// Final prototype
module x_end_plain(){
 difference(){
  x_end_base();
  x_end_holes();
 }
}

x_end_plain();


module pushfit_rod(diameter,length){
 poly_cylinder(h = length, r=diameter/2);
 difference(){
 	translate(v=[0,-diameter/2.85,length/2]) rotate([0,0,45]) cube(size = [diameter/2,diameter/2,length], center = true);
 	translate(v=[0,-diameter/4-diameter/2-0.4,length/2]) rotate([0,0,0]) cube(size = [diameter,diameter/2,length], center = true);
 }
 //translate(v=[0,-diameter/2-2,length/2]) cube(size = [diameter,1,length], center = true);
}

