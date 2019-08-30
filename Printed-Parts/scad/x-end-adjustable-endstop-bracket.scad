/**
 * A tray that can be mounted to the motor mount to be used for a Z axis adjustment bolt
**/

use <x-end-motor.scad>

// Space between the motor mount body and this piece - added for tolerance
extraOffset = 0.1;

// Diomensions for this piece
length = 47;
width = 17.8;
height = 7;


// Copied x_end_motor_endstop_base() from x-end-motor.scad to make it a little larger to be used as a cutout
module cutout_x_end_motor_endstop_base()
{
    translate([(-23.5 - extraOffset),-28.5,58])
    {
        difference()
        {
            // Base block
            cube([(17 + (extraOffset * 2)), (18.2 + extraOffset), (4 + extraOffset)]);
            // Nice edge
            translate([-1, (10 + extraOffset), 10])rotate([-45, 0, 0])cube([20, 20, 20]);
        } 
    }
}

// Make bevelled edges
module edgeCutouts()
{
    translate( [0, -8, 1] )
    {
        rotate( [-60, 0, 0] )
        {
                cube( [length, width, height] );
        }
        translate( [0, 4, -3] )
        {
            rotate( [60, 0, 0] )
            {
                cube( [length, width, height] );
            }
        }
    }

    translate( [0, 16.8, -14.4] )
    {
        rotate( [60, 0, 0] )
        {
                cube( [length, width, height] );
        }

        translate( [0, -4, 28] )
        {
            rotate( [-60, 0, 0] )
            {
                cube( [length, width, height] );
            }
        }
    }

    translate( [-10.93, 0, 0] )
    {
        rotate( [120, 0, 90] )
        {
            cube( [width, width, height] );
        }

        translate( [7.65, 0, -7] )
        {
            rotate( [60, 0, 90] )
            {
                cube( [width, width, height] );
            }
        }
    }
}

// This piece before the cutout and mounting holes
module mainUnit()
{
    translate( [(-23.5 - length + 17), -28.5, 58] )
    {
        difference()
        {
            {
                cube( [length, width, height] );
            }
            {
                translate( [9, (width/2), -0.1] )
                {
                    // bolt capture and through-hole
                    translate([0,0,-4.4])cylinder(h = (height + 0.2), r = 4.2, $fn=6);
                    cylinder(h = (height + 0.2), d = 3.85, $fn=256);
                }
                edgeCutouts();
            }
        }
        

        
    }

}

// All together now (all together now)
difference()
{
    {
        mainUnit();
    }
    {
        cutout_x_end_motor_endstop_base();
        x_end_motor_endstop_holes();
    }
}

// Uncomment this to test the fit
// x_end_motor();
