
kerf_3mm = 0.08;
kerf_6mm = 0.15;
press_fit_mdf = 0.15;
box_material_thickness = 6;
motor_holder_material_thickness = 10;
lifter_bottom_base_height = 25;
lifter_edge_joint_lenght = 10;
edge_clearnece_space = 1;
box_lift_width = 180;
shaft_lenght = 285;
box_lift_depth  = 150;
box_lift_height = 275 + lifter_bottom_base_height;
$fn=60;
shaft_diameter = 8;
helicoidal_shaft_diameter = 8;
bearings_hole_center_to_center_distance = 18.24;
m_3_diameter = 3;
m_5_diameter = 5;
motor_holder_height = 50;
motor_gearbox_diameter = 36;
motor_holder_dimensions = 57;
//TODO: UERGENT: LEAVE SPACE FOR BEARING SCREWS IN BOTH THE SENSOR AND THE MOTOR HOLDER

module edge_joit(repetitions, edge_joint_lenght, y_press_fit = press_fit_mdf, z_press_fit = press_fit_mdf, x_delta = 0, y_delta = 0, z_delta = 0, y_edge_clearnece_space = 1) {
    // Cubes are empy spaces, that are removed from the box
    translate([-box_material_thickness, - y_edge_clearnece_space, -box_material_thickness - (z_press_fit / 2)]){
        cube([box_material_thickness * 3, edge_joint_lenght + y_edge_clearnece_space - y_press_fit, box_material_thickness + z_delta - z_press_fit]);
    }
    for(step = [1 : 1 : repetitions - 2]) {
        translate([-box_material_thickness, (step * edge_joint_lenght * 2) + (y_press_fit / 2) , -box_material_thickness - (z_press_fit / 2)]){
            cube([box_material_thickness * 3, (edge_joint_lenght) - y_press_fit , box_material_thickness + z_delta - z_press_fit]);
        }
    }  
    if(repetitions > 1) {
        translate([-box_material_thickness, ((repetitions - 1) * edge_joint_lenght * 2) + (y_press_fit / 2), -box_material_thickness - (z_press_fit / 2)]){
            cube([box_material_thickness * 3, edge_joint_lenght + y_edge_clearnece_space - y_press_fit, box_material_thickness + z_delta - z_press_fit]);
        }
    }
}

module lift_box_lateral() {
    difference() {
        difference() {
            cube([box_material_thickness, box_lift_depth, box_lift_height]);
            translate([0, 0, lifter_bottom_base_height + box_material_thickness]){
                edge_joit(8, lifter_edge_joint_lenght, (press_fit_mdf / 2) + kerf_6mm, (press_fit_mdf / 2) + kerf_6mm);
            }
        }
        translate([0, 0, box_lift_height]){
            edge_joit(8, lifter_edge_joint_lenght, (press_fit_mdf / 2) + kerf_6mm, (press_fit_mdf / 2), 0, 0, 1);
        }
    }
}

module lift_laterals() {
    translate([box_lift_width / 2, 0, 0]){
        lift_box_lateral();
    }
    translate([- box_lift_width / 2, 0, 0]){
        lift_box_lateral();
    }
}

module lift_base_without_hole() {
    width_lift_base_raw = box_lift_width - (box_material_thickness * 2);
    translate([-width_lift_base_raw / 2, 0, 0]){
        cube([width_lift_base_raw + box_material_thickness, box_lift_depth, box_material_thickness]);
    }
    translate([-width_lift_base_raw / 2, 0,  box_material_thickness]){
        edge_joit(8, lifter_edge_joint_lenght, 0,0,0,0,0,0);  
    }
    translate([width_lift_base_raw / 2, 0,  box_material_thickness]){
        edge_joit(8, lifter_edge_joint_lenght, 0,0,0,0,0,0);  
    }
}

module lift_box() {
    translate([0, 0, lifter_bottom_base_height]){
       color([106/255, 135/255, 90/255,1])
       lift_base();
    }
    translate([0, 0, box_lift_height - box_material_thickness]){
        color([106/255, 135/255, 90/255])
        lift_base();
    }
    lift_laterals();
}

module shaft_clamp() {
  hole_center_to_center_distance =  16.185;
  translate([hole_center_to_center_distance, 0, - edge_clearnece_space]){
    cylinder(d=5,h=box_material_thickness + (2 * edge_clearnece_space));
  }
  translate([0, 0, - edge_clearnece_space]){
    cylinder(d = shaft_diameter - press_fit_mdf - kerf_6mm,h=box_material_thickness + 2);
    //cube([44,25,20], center = true); 
  }
  translate([-hole_center_to_center_distance, 0, - edge_clearnece_space]){
    cylinder(d=5,h=box_material_thickness + (2 * edge_clearnece_space));
  }
}

distance_front_shaft_clamps = 40;
hexagon_dowln_pin_diameter = 5.55;
module sensor_base_holes(thickness, diameter_increase = 0, press_fit_hex = press_fit_mdf, kerf_hex = kerf_6mm, press_fit_screws = press_fit_mdf, kerf_screws = kerf_6mm) {
    hole_center_to_center_distance = 18.3;
    translate([0, distance_front_shaft_clamps - 20, 0]){
        translate([hole_center_to_center_distance, 0, - edge_clearnece_space]){
            cylinder(d=m_3_diameter - press_fit_screws - kerf_screws + diameter_increase,h=thickness + (2 * edge_clearnece_space));
        }
        translate([0, 0, - edge_clearnece_space]){
            cylinder(d=m_3_diameter - press_fit_screws - kerf_screws + diameter_increase,h=thickness + (2 * edge_clearnece_space));
        }
        translate([-hole_center_to_center_distance, 0, - edge_clearnece_space]){
        cylinder(d=hexagon_dowln_pin_diameter - (press_fit_hex + kerf_hex)/2 + diameter_increase,h=thickness + (2 * edge_clearnece_space), $fn=6);
        }
    }
    translate([0, distance_front_shaft_clamps + 20, 0]){
        translate([-hole_center_to_center_distance, 0, - edge_clearnece_space]){
            cylinder(d=m_3_diameter - press_fit_screws - kerf_screws + diameter_increase,h=thickness + (2 * edge_clearnece_space));
        }
        translate([0, 0, - edge_clearnece_space]){
            cylinder(d=m_3_diameter - press_fit_screws - kerf_screws + diameter_increase,h=thickness + (2 * edge_clearnece_space));
        }
        translate([hole_center_to_center_distance, 0, - edge_clearnece_space]){
            cylinder(d=hexagon_dowln_pin_diameter - (press_fit_hex + kerf_hex)/2 + diameter_increase,h=thickness + (2 * edge_clearnece_space), $fn=6);
        }
    }
}

module actuator_shaft_bearings(thickness = box_material_thickness, added_diameter =0) {
    hole_center_to_center_distance = 18.3;
    translate([0, distance_front_shaft_clamps, 0]){
        translate([hole_center_to_center_distance, 0, - edge_clearnece_space]){
            cylinder(d=5 + added_diameter,h=thickness + (2 * edge_clearnece_space));
        }
        translate([0, 0, - edge_clearnece_space]){
            cylinder(d=helicoidal_shaft_diameter - kerf_6mm,h=thickness + (2 * edge_clearnece_space));
            //cube([48,27,40], center = true);
        }
        translate([-hole_center_to_center_distance, 0, - edge_clearnece_space]){
            cylinder(d=5 + added_diameter,h=thickness + (2 * edge_clearnece_space));
        }        
    }
}


module shaft_clamps() {
    distance_back_shaft_clamps = 120;
    lateral_distance_front_shaft_clamps = 53;
    translate([lateral_distance_front_shaft_clamps, distance_front_shaft_clamps, 0]){
        shaft_clamp();
    }
    translate([-lateral_distance_front_shaft_clamps, distance_front_shaft_clamps, 0]){
        shaft_clamp();
    }
    translate([0, distance_back_shaft_clamps, 0]){
        shaft_clamp();
    }
}

module lift_base() {
    difference() {
        lift_base_without_hole(7);
        shaft_clamps();
        actuator_shaft_bearings();
        sensor_base_holes(box_material_thickness);
    }
}



//hole_center_to_center_distance
module sensor_box_alignent_holes(){
   m_3_scew_lenght = 20;
   m_5_screw_lenght = 10;
   screw_m_5_spacer_diameter = 11;
   screw_m_3_spacer_diameter = 8;
   sensor_alignment_width = 22.00;
   sensor_alignment_lenght = 28.00;
   sensor_center_ic = 7.5;
   translate([0, - distance_front_shaft_clamps , 0]){      
       sensor_base_holes(motor_holder_material_thickness, 0, 0, 0);
   }
   translate([-sensor_alignment_width/2, -(sensor_alignment_lenght / 2) - 6.5, -edge_clearnece_space]){      
     cube([sensor_alignment_width, sensor_alignment_lenght, motor_holder_material_thickness + (2* edge_clearnece_space)]);
   }
}
module sensor_box_alignent(){
    difference(){
      translate([-motor_holder_dimensions/2, - motor_holder_dimensions/2 , 0]){  
         cube([motor_holder_dimensions, motor_holder_dimensions, motor_holder_material_thickness]);
      }
      sensor_box_alignent_holes();
    }
}
   sensor_box_material_thickness = 10; //TODO: use correct one
//TODO: as stated above, add holes for bearing screws
module sensor_box_holder_holes(){
   m_3_scew_lenght = 20;
   sensor_alignment_width = 11;
   sensor_alignment_lenght = 14;
   sensor_screw_diameter = 2.6;
   translate([0, - distance_front_shaft_clamps, 0]){      
      actuator_shaft_bearings(sensor_box_material_thickness, 5);  
   }
   //TODO: I hardly doubt that the screws for the sensor are actually M3, probably M2
   translate([9, (11/2), -edge_clearnece_space]){         
      cylinder(d=sensor_screw_diameter,h= sensor_box_material_thickness + (2 *    edge_clearnece_space));
    } 
   translate([-9, (11/2), -edge_clearnece_space]){         
      cylinder(d=sensor_screw_diameter,h= sensor_box_material_thickness + (2 *    edge_clearnece_space));
    } 
   translate([9, - (11/2), -edge_clearnece_space]){         
      cylinder(d=sensor_screw_diameter,h= sensor_box_material_thickness + (2 *    edge_clearnece_space));
    } 
   translate([-9, - (11/2), -edge_clearnece_space]){         
      cylinder(d=sensor_screw_diameter,h= sensor_box_material_thickness + (2 *    edge_clearnece_space));
    } 
    translate([-sensor_alignment_width / 2, - sensor_alignment_lenght / 2 , -edge_clearnece_space]){         
      cube([sensor_alignment_width, sensor_alignment_lenght, sensor_box_material_thickness + (2* edge_clearnece_space)]);
    }
    translate([-22 / 2, - sensor_alignment_lenght / 2 - 13.5, -edge_clearnece_space]){         
      cube([22, 5, sensor_box_material_thickness + (2* edge_clearnece_space)]);
    }
}

module sensor_box_holder(){
    difference(){
      translate([0, 0, motor_holder_material_thickness/2]){
        cube([motor_holder_dimensions, motor_holder_dimensions, motor_holder_material_thickness], center= true);
      }
      translate([0, - distance_front_shaft_clamps , 0]){      
        sensor_base_holes(motor_holder_material_thickness);
      }
      sensor_box_holder_holes();
    }
}



module lifter_sensor() {
   color([106/255, 135/255, 90/255])
   sensor_box_alignent();
   translate([0, 0, motor_holder_material_thickness]){
     color([135/255, 100/255, 90/255])
     sensor_box_holder();
   }
} 

module project_lift_box_lateral() {
    projection() {
        rotate([0,90,0])
        translate([0, 0, -1])
        difference() {
            lift_box_lateral();
            edge_joit(7);
        }
    }
}

module project_lift_base() {
    projection() {
        translate([box_lift_width / 2, 0, -edge_clearnece_space]){
            color([106/255, 135/255, 90/255])
            lift_base();
        }
        translate([box_lift_width + 100, 0, -edge_clearnece_space]){
            color([106/255, 135/255, 90/255])
            lift_base();
        }
    }
}


//hole_center_to_center_distance
module motor_holder_holes(){
   motor_screw_center_radius = 15;
   m_3_scew_lenght = 20;
   m_5_screw_lenght = 10;
   motor_coupler_diameter = 25; //TODO: verify
   screw_m_5_spacer_diameter = 11;
   screw_m_3_spacer_diameter = 9;
   // motor screws
   for(angle = [0 : 90 : 270]) {
       rotate(a = 45 + angle) {
         translate([motor_screw_center_radius, 0, -edge_clearnece_space]){          
            cylinder(d=screw_m_3_spacer_diameter, h= motor_holder_height - m_3_scew_lenght + ( 2 * edge_clearnece_space ), center =false);
            translate([0, 0, motor_holder_height - m_3_scew_lenght]){  
              //cylinder(d=m_3_diameter+(kerf_6mm*3), h=m_3_scew_lenght + ( 2 * edge_clearnece_space ) , center=false);
            }
         }
       }
    }
    translate([0, 0, -edge_clearnece_space]){       
        cylinder(d= motor_coupler_diameter, h=motor_holder_height + ( 2 *edge_clearnece_space), center=false);
    }
    // bearing screws
    for(position = [-1 : 2 : 1]) {
        translate([position * bearings_hole_center_to_center_distance, 0, -edge_clearnece_space]){
            cylinder(d=screw_m_5_spacer_diameter, h=motor_holder_height + (2 * edge_clearnece_space) , center=false);
        }
    }
    // gearbox holder
    translate([0, 0, (4*motor_holder_material_thickness) - edge_clearnece_space]){
        //TODO: verify motor_gearbox_diameter is ok, let's make it whide enough, we can add glue or something to fill the gaps in case it's necessary
       cylinder(d=motor_gearbox_diameter - ((press_fit_mdf + kerf_6mm) / 2), h=motor_holder_material_thickness+(2*edge_clearnece_space), center=false);           
    }
}
module motor_holder(){
    difference(){
      translate([-motor_holder_dimensions/2, -motor_holder_dimensions/2, 0]){ 
        cube([motor_holder_dimensions, motor_holder_dimensions, motor_holder_height], center=false);
      }
      base_screw_distance = 10;
      motor_holder_holes();
      translate([0, -distance_front_shaft_clamps, base_screw_distance]){
        sensor_base_holes(motor_holder_height- base_screw_distance, 10, 0, 0);
      }
      translate([0, -distance_front_shaft_clamps, 0]){
        sensor_base_holes(motor_holder_height, diameter_increase = 0, press_fit_hex = 0, kerf_hex = -kerf_3mm, press_fit_screws = 0, kerf_screws = -kerf_6mm*3);
      }
    }
}
module project_motor_holder() {
    projection(cut = true) {
        translate([0, 0, -5]){
            motor_holder();
        }
    }
   projection(cut = true) {
        translate([motor_holder_dimensions+edge_clearnece_space, 0, -15]){
            motor_holder();
        }
   }
   projection(cut = true) {
        translate([0, motor_holder_dimensions+edge_clearnece_space, -25]){
            motor_holder();
        }
   }
   projection(cut = true) {
        translate([motor_holder_dimensions + edge_clearnece_space, motor_holder_dimensions + edge_clearnece_space, -35]){
           motor_holder();
       }
  }
  projection(cut = true) {
        translate([(2 *motor_holder_dimensions) + (2 * edge_clearnece_space) , motor_holder_dimensions + edge_clearnece_space, -45]){
           motor_holder();
       }
  }
}

module lifter() {
   translate([0,distance_front_shaft_clamps, box_lift_height]){
        motor_holder();
   }
   translate([0,distance_front_shaft_clamps, 0]){
       lifter_sensor();
   }
   lift_box();
}
//sensor_base_holes(10);
lifter();
//rotate(a = 180, v = [1, 0, 0]) { 
//color([106/255, 135/255, 90/255,0.7])
//motor_holder();
//}

//project_motor_holder();
//sensor_base_holes();