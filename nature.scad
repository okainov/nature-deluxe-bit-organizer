// Save as meat_box.scad next to boardgame_insert_toolkit_lib.3.scad and bit_functions_lib.3.scad
include <boardgame_insert_toolkit_lib.3.scad>;

// Helper library to simplify creation of single components
// Also includes some basic lid helpers
include <bit_functions_lib.3.scad>;

// Determines whether lids are output.
g_b_print_lid = true;

// Determines whether boxes are output.
g_b_print_box = true; 

// Only render specified box
g_isolated_print_box = "core"; 

// Used to visualize how all of the boxes fit together. 
g_b_visualization = false;          
        
// Outer wall thickness
// Default = 1.5mm
g_wall_thickness = 1.5;

// Provided to make variable math easier
// i.e., it's a lot easier to just type "wall" than "g_wall_thickness"
wall = g_wall_thickness;

// The tolerance value is extra space put between planes of the lid and box that fit together.
// Increase the tolerance to loosen the fit and decrease it to tighten it.
//
// Note that the tolerance is applied exclusively to the lid.
// So if the lid is too tight or too loose, change this value ( up for looser fit, down for tighter fit ) and 
// you only need to reprint the lid.
// 
// The exception is the stackable box, where the bottom of the box is the lid of the box below,
// in which case the tolerance also affects that box bottom.
//
g_tolerance = 0.15;

// This adjusts the position of the lid detents downward. 
// The larger the value, the bigger the gap between the lid and the box.
g_tolerance_detents_pos = 0.1;

g_default_font = "Arial:style=Bold";

// Variables for components box
cmp_size = 20;
cmp_pitch = cmp_size + wall;


gap_between_columns_mm    = 3.0;     // horizontal gap between columns
gap_between_rows_mm       = 2.0;     // vertical gap between the two rows
finger_cutout_on_front_4b = [f,f,t,f];  // [Front, Back, Left, Right]
$fn = 64; // smooth circles

// ---- Content sizes (INTERIOR) ----
tolerance_gap = 2.0;
diam_token      = 70.0;                   // left column, both rows
dice_diam      = 39.0;                   // left column, both rows
dial_diam = 50 + tolerance_gap;
reg_w = 63.0+tolerance_gap; reg_h = 89.0+tolerance_gap;               // regular cards
big_w = 80.0+tolerance_gap; big_h = 120.0+tolerance_gap;              // big cards

// Depths (how deep the pocket is from the top rim down)
depth_solo_cards  = 2.0+tolerance_gap;    // middle-top thin pocket
depth_player_aids  = 2.0+tolerance_gap;    // middle-bottom thin pocket
depth_reg_deep  = 15.0+tolerance_gap;   // right column deep pocket

// ---- Derived layout (don’t change unless you want a different packing) ----
// Column widths (interior)
colL_w = diam_token;
colM_w = max(reg_w, big_w);

// Row heights (interior)
rowTop_h    = max(diam_token, reg_h); // top row must fit round pocket & reg deck
rowBottom_h = max(diam_token, big_h); // bottom row must fit round pocket & big deck

// Exterior box size
box_x = (2*g_wall_thickness)
        + colL_w + gap_between_columns_mm
        + colM_w + gap_between_columns_mm
        + 9;

box_y = (2*g_wall_thickness)
        + diam_token*2 + gap_between_rows_mm
        + 0;

box_z = 30.0; // overall box height

// Helper: lower-left origins of each grid cell (interior coords)
llx_L = g_wall_thickness;
llx_M = llx_L + colL_w + gap_between_columns_mm;
llx_R = llx_M + colM_w + gap_between_columns_mm;

lly_T = 0 + diam_token + gap_between_rows_mm; // top row starts above bottom row
lly_B = 0;

center_mid = 130;
rainforest_center_mid = 132;
tundra_center_of_aids_solo = 135;
natural_disaster_center = 85;
comet_box_x = 30;
comet_box_y = 50;
comet_box_z = 18;
tundra_watering_hole_height = 2.0;
rainforest_watering_hole_height = 2.0;
base_watering_hole_height = 2.0;

small_box_x = 120.0;
small_box_y = 70.0;

core_nature_deck_height = 30+tolerance_gap;
core_hunter_deck_height = 7 +tolerance_gap;
core_player_aids_height = 4 + tolerance_gap;
core_center_of_aids_solo = 145;

frogs_bananas_difference = 15;
base_frog_bananas_comp_size = (small_box_x-wall*2-gap_between_rows_mm)/2;

data = [
	
   [ "flight",
    [
      [ BOX_SIZE_XYZ, [box_x, box_y, box_z] ],

      // LEFT column: two round Ø70 pockets (top & bottom), shallow depth equals token height you prefer
      [ BOX_COMPONENT, [
          [ CMP_SHAPE, ROUND  ],
          [ CMP_SHAPE_VERTICAL_B, t  ],
          [ CMP_NUM_COMPARTMENTS_XY, [1,1] ],
          [ CMP_COMPARTMENT_SIZE_XYZ, [diam_token, diam_token, 25.0] ],
          [ POSITION_XY, [-5 , lly_T ] ],
          [ CMP_CUTOUT_SIDES_4B, finger_cutout_on_front_4b ]
      ]],
      [ BOX_COMPONENT, [
          [ CMP_SHAPE, ROUND  ],
          [ CMP_SHAPE_VERTICAL_B, t  ],
          [ CMP_NUM_COMPARTMENTS_XY, [1,1] ],
          [ CMP_COMPARTMENT_SIZE_XYZ, [diam_token, diam_token, 25.0] ],
          [ POSITION_XY, [-5 , 0 ] ],
          [ CMP_CUTOUT_SIDES_4B, finger_cutout_on_front_4b ]
      ]],

      // SOLO cards on the bottom
      [ BOX_COMPONENT, [
          [ CMP_SHAPE, SQUARE ],
          [ CMP_NUM_COMPARTMENTS_XY, [1,1] ],
          [ CMP_COMPARTMENT_SIZE_XYZ, [reg_w, reg_h, depth_player_aids+depth_solo_cards+depth_reg_deep] ],
          [ POSITION_XY, [center_mid-reg_w/2-10, box_y/2-reg_h/2 ] ],
          [ CMP_SHAPE_VERTICAL_B, t ],
          [ CMP_CUTOUT_SIDES_4B, [f,f,t,t] ]
      ]],

      // Full deck then (rotated)
      [ BOX_COMPONENT, [
          [ CMP_SHAPE, SQUARE ],
          [ CMP_NUM_COMPARTMENTS_XY, [1,1] ],
          [ CMP_COMPARTMENT_SIZE_XYZ, [reg_w, reg_h, depth_player_aids+depth_reg_deep] ],
          [ POSITION_XY, [center_mid-reg_h/2, box_y/2-reg_h/2] ],
          [ CMP_SHAPE_VERTICAL_B, t ],
		  [ ROTATION, 90 ],
          //[ CMP_CUTOUT_SIDES_4B, [f,f,f,t] ]
      ]],

      // Player aids on top
      [ BOX_COMPONENT, [
          [ CMP_SHAPE, SQUARE ],
          [ CMP_NUM_COMPARTMENTS_XY, [1,1] ],
          [ CMP_COMPARTMENT_SIZE_XYZ, [big_w, big_h, depth_player_aids] ],
          [ POSITION_XY, [center_mid-big_w/2-10, box_y/2-big_h/2] ],
          [ CMP_SHAPE_VERTICAL_B, t ],
          //[ CMP_CUTOUT_SIDES_4B, [f,f,t,t] ]
      ]],

      [ BOX_LID, [
          [ LID_SOLID_B, f ],
          //[ LID_INSET_B, t ],
		  [ LABEL,
            [
              [ LBL_TEXT, "FLIGHT" ],
              [ LBL_SIZE, AUTO ],
              [ LBL_PLACEMENT, CENTER ]
            ]
          ]
      ] ],

      // Make bases stackable (optional)
      //[ BOX_STACKABLE_B, t ],
    ]
  ],
	
   [ "tundra",
    [
      [ BOX_SIZE_XYZ, [box_x, box_y, box_z] ],

      // Big dice
      [ BOX_COMPONENT, [
          [ CMP_SHAPE, ROUND  ],
          [ CMP_SHAPE_VERTICAL_B, t  ],
          [ CMP_NUM_COMPARTMENTS_XY, [1,1] ],
          [ CMP_COMPARTMENT_SIZE_XYZ, [dice_diam, dice_diam, 28.0] ],
          [ POSITION_XY, [wall , box_y-dice_diam-wall*2 ] ],
          [ CMP_CUTOUT_SIDES_4B, finger_cutout_on_front_4b ]
		  
      ]],
	  
	  

      // Full deck
      [ BOX_COMPONENT, [
          [ CMP_SHAPE, SQUARE ],
          [ CMP_NUM_COMPARTMENTS_XY, [1,1] ],
          [ CMP_COMPARTMENT_SIZE_XYZ, [reg_w, reg_h, depth_reg_deep+tundra_watering_hole_height] ],
          [ POSITION_XY, [wall, wall] ],
          [ CMP_SHAPE_VERTICAL_B, t ],
          [ CMP_CUTOUT_SIDES_4B, [t,f,f,f] ],
		  
		  // [ LABEL,
            // [
                        // [LBL_TEXT,        "Cards"
                        // ],
                        // [LBL_PLACEMENT,     BACK],
                        // [ LBL_SIZE,         12],
                        // [ POSITION_XY,      [ 25,8]],
                        // [ LBL_FONT,         "Times New Roman:style=bold italic"],

                    // ]
					// ]
      ]],

      // SOLO cards on the bottom
      [ BOX_COMPONENT, [
          [ CMP_SHAPE, SQUARE ],
          [ CMP_NUM_COMPARTMENTS_XY, [1,1] ],
          [ CMP_COMPARTMENT_SIZE_XYZ, [reg_w, reg_h, depth_player_aids+depth_solo_cards+tundra_watering_hole_height] ],
          [ POSITION_XY, [tundra_center_of_aids_solo-reg_w/2-10, box_y/2-reg_h/2 ] ],
          [ CMP_SHAPE_VERTICAL_B, t ],
          //[ CMP_CUTOUT_SIDES_4B, [f,f,t,t] ],
		  //[ CMP_CUTOUT_TYPE, EXTERIOR ]
      ]],

      // Player aids on top
      [ BOX_COMPONENT, [
          [ CMP_SHAPE, SQUARE ],
          [ CMP_NUM_COMPARTMENTS_XY, [1,1] ],
          [ CMP_COMPARTMENT_SIZE_XYZ, [big_w, big_h, depth_player_aids+tundra_watering_hole_height] ],
          [ POSITION_XY, [tundra_center_of_aids_solo-big_w/2-10, box_y/2-big_h/2] ],
          [ CMP_SHAPE_VERTICAL_B, t ],
          [ CMP_CUTOUT_SIDES_4B, [f,f,f,t] ]
      ]],

      [ BOX_LID, [
          [ LID_SOLID_B, f ],
          //[ LID_INSET_B, t ],
		  [ LABEL,
            [
              [ LBL_TEXT, "TUNDRA" ],
              [ LBL_SIZE, AUTO ],
              [ LBL_PLACEMENT, CENTER ]
            ]
          ]
      ] ],

      // Make bases stackable (optional)
      //[ BOX_STACKABLE_B, t ],
    ]
  ],
  
  [ "jurassic",
  // Almost the same as tundra, just no watering hole and different label
    [
      [ BOX_SIZE_XYZ, [box_x, box_y, box_z] ],

      // Big dice
      [ BOX_COMPONENT, [
          [ CMP_SHAPE, ROUND  ],
          [ CMP_SHAPE_VERTICAL_B, t  ],
          [ CMP_NUM_COMPARTMENTS_XY, [1,1] ],
          [ CMP_COMPARTMENT_SIZE_XYZ, [dice_diam, dice_diam, 28.0] ],
          [ POSITION_XY, [wall , box_y-dice_diam-wall*2 ] ],
          [ CMP_CUTOUT_SIDES_4B, finger_cutout_on_front_4b ]
		  
      ]],
	  
	  

      // Full deck
      [ BOX_COMPONENT, [
          [ CMP_SHAPE, SQUARE ],
          [ CMP_NUM_COMPARTMENTS_XY, [1,1] ],
          [ CMP_COMPARTMENT_SIZE_XYZ, [reg_w, reg_h, depth_reg_deep] ],
          [ POSITION_XY, [wall, wall] ],
          [ CMP_SHAPE_VERTICAL_B, t ],
          [ CMP_CUTOUT_SIDES_4B, [t,f,f,f] ],
		  
		  [ LABEL,
            [
                        [LBL_TEXT,        "Jurassic"
                        ],
                        [LBL_PLACEMENT,     BACK],
                        [ LBL_SIZE,         11],
                        [ POSITION_XY,      [ 20,7]],
                        [ LBL_FONT,         "Times New Roman:style=bold italic"],

                    ]
					]
      ]],

      // SOLO cards on the bottom
      [ BOX_COMPONENT, [
          [ CMP_SHAPE, SQUARE ],
          [ CMP_NUM_COMPARTMENTS_XY, [1,1] ],
          [ CMP_COMPARTMENT_SIZE_XYZ, [reg_w, reg_h, depth_player_aids+depth_solo_cards] ],
          [ POSITION_XY, [tundra_center_of_aids_solo-reg_w/2-10, box_y/2-reg_h/2 ] ],
          [ CMP_SHAPE_VERTICAL_B, t ],
          //[ CMP_CUTOUT_SIDES_4B, [f,f,t,t] ],
		  //[ CMP_CUTOUT_TYPE, EXTERIOR ]
      ]],

      // Player aids on top
      [ BOX_COMPONENT, [
          [ CMP_SHAPE, SQUARE ],
          [ CMP_NUM_COMPARTMENTS_XY, [1,1] ],
          [ CMP_COMPARTMENT_SIZE_XYZ, [big_w, big_h, depth_player_aids] ],
          [ POSITION_XY, [tundra_center_of_aids_solo-big_w/2-10, box_y/2-big_h/2] ],
          [ CMP_SHAPE_VERTICAL_B, t ],
          [ CMP_CUTOUT_SIDES_4B, [f,f,f,t] ]
      ]],

      [ BOX_LID, [
          [ LID_SOLID_B, f ],
          //[ LID_INSET_B, t ],
		  [ LABEL,
            [
              [ LBL_TEXT, "JURASSIC" ],
              [ LBL_SIZE, AUTO ],
              [ LBL_PLACEMENT, CENTER ]
            ]
          ]
      ] ],

      // Make bases stackable (optional)
      //[ BOX_STACKABLE_B, t ],
    ]
  ],
  
  [ "core",
  // Special
    [
      [ BOX_SIZE_XYZ, [180, 140, 40] ],

      // Round indicator
      [ BOX_COMPONENT, [
          [ CMP_SHAPE, ROUND  ],
          [ CMP_SHAPE_VERTICAL_B, t  ],
          [ CMP_NUM_COMPARTMENTS_XY, [1,1] ],
          [ CMP_COMPARTMENT_SIZE_XYZ, [dial_diam, dial_diam, 7.0+core_hunter_deck_height+base_watering_hole_height] ],
          [ POSITION_XY, [6 , 75 ] ],
		  
      ]],
	  
	  

      // Full deck
      [ BOX_COMPONENT, [
          [ CMP_SHAPE, SQUARE ],
          [ CMP_NUM_COMPARTMENTS_XY, [1,1] ],
          [ CMP_COMPARTMENT_SIZE_XYZ, [reg_w, reg_h, core_nature_deck_height+base_watering_hole_height] ],
          [ POSITION_XY, [wall+12, -12] ],
          [ CMP_SHAPE_VERTICAL_B, t ],
          [ ROTATION, 90 ],
          [ CMP_CUTOUT_SIDES_4B, [f,f,t,f] ],
		  
		  // [ LABEL,
            // [
                        // [LBL_TEXT,        "Jurassic"
                        // ],
                        // [LBL_PLACEMENT,     BACK],
                        // [ LBL_SIZE,         11],
                        // [ POSITION_XY,      [ 20,7]],
                        // [ LBL_FONT,         "Times New Roman:style=bold italic"],

                    // ]
					// ]
      ]],
	  
	  
      // Hunter deck
      [ BOX_COMPONENT, [
          [ CMP_SHAPE, SQUARE ],
          [ CMP_NUM_COMPARTMENTS_XY, [1,1] ],
          [ CMP_COMPARTMENT_SIZE_XYZ, [reg_w, reg_h, core_hunter_deck_height+base_watering_hole_height] ],
          [ POSITION_XY, [wall+12, reg_w-7] ],
          [ CMP_SHAPE_VERTICAL_B, t ],
          [ ROTATION, 90 ],
          [ CMP_CUTOUT_SIDES_4B, [f,f,f,t] ],
		  
		  // [ LABEL,
            // [
                        // [LBL_TEXT,        "Jurassic"
                        // ],
                        // [LBL_PLACEMENT,     BACK],
                        // [ LBL_SIZE,         11],
                        // [ POSITION_XY,      [ 20,7]],
                        // [ LBL_FONT,         "Times New Roman:style=bold italic"],

                    // ]
					// ]
      ]],
	  
	  

      // SOLO cards in the middle
      [ BOX_COMPONENT, [
          [ CMP_SHAPE, SQUARE ],
          [ CMP_NUM_COMPARTMENTS_XY, [1,1] ],
          [ CMP_COMPARTMENT_SIZE_XYZ, [reg_w, reg_h, depth_solo_cards+core_nature_deck_height+base_watering_hole_height] ],
          [ POSITION_XY, [50, box_y/2-reg_h/2 ] ],
          [ CMP_SHAPE_VERTICAL_B, t ],
          [ CMP_CUTOUT_SIDES_4B, [f,f,f,t] ],
		  //[ CMP_CUTOUT_TYPE, EXTERIOR ]
      ]],


      // // SOLO cards on the bottom
      // [ BOX_COMPONENT, [
          // [ CMP_SHAPE, SQUARE ],
          // [ CMP_NUM_COMPARTMENTS_XY, [1,1] ],
          // [ CMP_COMPARTMENT_SIZE_XYZ, [reg_w, reg_h, core_player_aids_height+depth_solo_cards+base_watering_hole_height] ],
          // [ POSITION_XY, [core_center_of_aids_solo-reg_w/2-10, box_y/2-reg_h/2 ] ],
          // [ CMP_SHAPE_VERTICAL_B, t ],
          // //[ CMP_CUTOUT_SIDES_4B, [f,f,t,t] ],
		  // //[ CMP_CUTOUT_TYPE, EXTERIOR ]
      // ]],

      // Player aids on top
      [ BOX_COMPONENT, [
          [ CMP_SHAPE, SQUARE ],
          [ CMP_NUM_COMPARTMENTS_XY, [1,1] ],
          [ CMP_COMPARTMENT_SIZE_XYZ, [big_w, big_h, core_player_aids_height+base_watering_hole_height] ],
          [ POSITION_XY, [core_center_of_aids_solo-big_w/2-10, box_y/2-big_h/2] ],
          [ CMP_SHAPE_VERTICAL_B, t ],
          [ CMP_CUTOUT_SIDES_4B, [f,f,f,t] ]
      ]],

      [ BOX_LID, [
          [ LID_SOLID_B, f ],
          //[ LID_INSET_B, t ],
		  [ LABEL,
            [
              [ LBL_TEXT, "CORE" ],
              [ LBL_SIZE, AUTO ],
              [ LBL_PLACEMENT, CENTER ]
            ]
          ]
      ] ],

      // Make bases stackable (optional)
      //[ BOX_STACKABLE_B, t ],
    ]
  ],
  
  [ "natural_disasters",
  // Smaller than others, like two small boxes together
    [
      [ BOX_SIZE_XYZ, [small_box_x, small_box_y*2, 20] ],


      //Comet compartment
      [ BOX_COMPONENT, [
          [ CMP_SHAPE, SQUARE ],
          [ CMP_NUM_COMPARTMENTS_XY, [1,1] ],
          [ CMP_COMPARTMENT_SIZE_XYZ, [comet_box_x+1, comet_box_y+1, comet_box_z] ],
          [ POSITION_XY, [wall, 0] ],
          [ CMP_SHAPE_VERTICAL_B, t ],
          [ CMP_CUTOUT_SIDES_4B, [t,f,f,f] ],
		  
		  [ LABEL,
            [
                        [LBL_TEXT,        "Natural"
                        ],
                        [LBL_PLACEMENT,     BACK],
                        [ LBL_SIZE,         10],
						[ ROTATION, 90],
                        [ POSITION_XY,      [ 53,6]],
                        [ LBL_FONT,         "Times New Roman:style=bold italic"],

                    ]
					],
					
		  [ LABEL,
            [
                        [LBL_TEXT,        "Disasters"
                        ],
                        [LBL_PLACEMENT,     BACK],
                        [ LBL_SIZE,         10],
						[ ROTATION, 90],
                        [ POSITION_XY,      [ 53,-6]],
                        [ LBL_FONT,         "Times New Roman:style=bold italic"],

                    ]
					]
      ]],

      // SOLO cards on the bottom
      [ BOX_COMPONENT, [
          [ CMP_SHAPE, SQUARE ],
          [ CMP_NUM_COMPARTMENTS_XY, [1,1] ],
          [ CMP_COMPARTMENT_SIZE_XYZ, [reg_w, reg_h, depth_reg_deep+depth_solo_cards] ],
          [ POSITION_XY, [natural_disaster_center-reg_w/2-10, box_y/2-reg_h/2 ] ],
          [ CMP_SHAPE_VERTICAL_B, t ],
      ]],

      // Player aids on top
      [ BOX_COMPONENT, [
          [ CMP_SHAPE, SQUARE ],
          [ CMP_NUM_COMPARTMENTS_XY, [1,1] ],
          [ CMP_COMPARTMENT_SIZE_XYZ, [big_w, big_h, depth_reg_deep] ],
          [ POSITION_XY, [natural_disaster_center-big_w/2-10, box_y/2-big_h/2] ],
          [ CMP_SHAPE_VERTICAL_B, t ],
          [ CMP_CUTOUT_SIDES_4B, [f,f,f,t] ]
      ]],

      [ BOX_LID, [
          [ LID_SOLID_B, f ],
		  [ LABEL,
            [
              [ LBL_TEXT, "NATURAL DISASTERS" ],
              [ LBL_SIZE, AUTO ],
              [ LBL_PLACEMENT, CENTER ]
            ]
          ]
      ] ],

    ]
  ],
  
    [ "natural_disasters_comet",
    [
      [ BOX_SIZE_XYZ, [comet_box_x, comet_box_y, comet_box_z] ],
	  [BOX_NO_LID_B, t],
	  // without lid actually
      [ BOX_LID,
        [
				[ ENABLED_B, f ],
                [ LID_FIT_UNDER_B,     f],
          [ LABEL,
            [
              [ LBL_TEXT, "COMET" ],
              [ LBL_SIZE, AUTO ],
              [ LBL_PLACEMENT, CENTER ]
            ]
          ]
        ]
      ],
      [ BOX_COMPONENT,
        [
          [ CMP_NUM_COMPARTMENTS_XY, [1, 1] ],
          [ CMP_COMPARTMENT_SIZE_XYZ, [comet_box_x - 2*wall, comet_box_y - 2*wall, comet_box_z-2] ],
          [CMP_SHAPE,                             FILLET ],
          //[CMP_FILLET_RADIUS,                             10 ],
        ]
      ]
    ]
  ],
  
  [ "rainforest",
    [
      [ BOX_SIZE_XYZ, [box_x, box_y, box_z] ],

      // Frogs and banana tokens box space
      [ BOX_COMPONENT, [
          [ CMP_SHAPE, SQUARE ],
          [ CMP_NUM_COMPARTMENTS_XY, [1,1] ],
		  // As our main box is 14*7, we want to have space for smaller box
		  // Extra +2 for lid of the box
          [ CMP_COMPARTMENT_SIZE_XYZ, [70+1, 120+1, 26 + 2 + rainforest_watering_hole_height] ],
          [ POSITION_XY, [wall, wall] ],
          [ CMP_SHAPE_VERTICAL_B, t ],
          [ CMP_CUTOUT_SIDES_4B, [t,f,f,f] ],
      ]],



      // SOLO cards on the bottom
      [ BOX_COMPONENT, [
          [ CMP_SHAPE, SQUARE ],
          [ CMP_NUM_COMPARTMENTS_XY, [1,1] ],
          [ CMP_COMPARTMENT_SIZE_XYZ, [reg_w, reg_h, depth_player_aids+depth_solo_cards+depth_reg_deep+rainforest_watering_hole_height] ],
          [ POSITION_XY, [rainforest_center_mid-reg_w/2-10, box_y/2-reg_h/2 ] ],
          [ CMP_SHAPE_VERTICAL_B, t ],
          [ CMP_CUTOUT_SIDES_4B, [f,f,t,t] ]
      ]],

      // Full deck then (rotated)
      [ BOX_COMPONENT, [
          [ CMP_SHAPE, SQUARE ],
          [ CMP_NUM_COMPARTMENTS_XY, [1,1] ],
          [ CMP_COMPARTMENT_SIZE_XYZ, [reg_w, reg_h, depth_player_aids+depth_reg_deep+rainforest_watering_hole_height] ],
          [ POSITION_XY, [rainforest_center_mid-reg_h/2, box_y/2-reg_h/2] ],
          [ CMP_SHAPE_VERTICAL_B, t ],
		  [ ROTATION, 90 ],
          //[ CMP_CUTOUT_SIDES_4B, [f,f,f,t] ]
      ]],

      // Player aids on top
      [ BOX_COMPONENT, [
          [ CMP_SHAPE, SQUARE ],
          [ CMP_NUM_COMPARTMENTS_XY, [1,1] ],
          [ CMP_COMPARTMENT_SIZE_XYZ, [big_w, big_h, depth_player_aids+rainforest_watering_hole_height] ],
          [ POSITION_XY, [rainforest_center_mid-big_w/2-10, box_y/2-big_h/2] ],
          [ CMP_SHAPE_VERTICAL_B, t ],
          //[ CMP_CUTOUT_SIDES_4B, [f,f,t,t] ]
      ]],

      [ BOX_LID, [
          [ LID_SOLID_B, f ],
          //[ LID_INSET_B, t ],
		  [ LABEL,
            [
              [ LBL_TEXT, "RAINFOREST" ],
              [ LBL_SIZE, AUTO ],
              [ LBL_PLACEMENT, CENTER ]
            ]
          ]
      ] ],

      // Make bases stackable (optional)
      //[ BOX_STACKABLE_B, t ],
    ]
  ],
  [ "meat box",
    [
      [ BOX_SIZE_XYZ, [small_box_x, small_box_y, 40.0] ],
      [ BOX_LID,
        [
          [ LABEL,
            [
              [ LBL_TEXT, "MEAT" ],
              [ LBL_SIZE, AUTO ],
              [ LBL_PLACEMENT, CENTER ]
            ]
          ]
        ]
      ],
      [ BOX_COMPONENT,
        [
          [ CMP_NUM_COMPARTMENTS_XY, [1, 1] ],
          [ CMP_COMPARTMENT_SIZE_XYZ, [small_box_x - 2*wall, small_box_y - 2*wall, 38] ],
        ]
      ]
    ]
  ],
  [ "population",
    [
      [ BOX_SIZE_XYZ, [small_box_x, small_box_y, 40.0] ],
      [ BOX_LID,
        [
          [ LABEL,
            [
              [ LBL_TEXT, "POPULATION" ],
              [ LBL_SIZE, AUTO ],
              [ LBL_PLACEMENT, CENTER ]
            ]
          ]
        ]
      ],
      [ BOX_COMPONENT,
        [
          [ CMP_NUM_COMPARTMENTS_XY, [1, 1] ],
          [ CMP_COMPARTMENT_SIZE_XYZ, [small_box_x - 2*wall, small_box_y - 2*wall, 38] ],
        ]
      ]
    ]
  ],
  [ "bananas and frogs",
    [
	  // 26 height should match what's inside bigger RAINFORST box
      [ BOX_SIZE_XYZ, [small_box_x, small_box_y, 25.0] ],
      [ BOX_LID,
        [
          [ LABEL,
            [
              [ LBL_TEXT, "FROGS" ],
              [ LBL_SIZE, AUTO ],
              [ ROTATION, 270 ],
              [ POSITION_XY,      [ -base_frog_bananas_comp_size/2-frogs_bananas_difference+wall*2,0]],
              [ LBL_PLACEMENT, CENTER ]
            ]
          ],
		  
          [ LABEL,
            [
              [ LBL_TEXT, "BANANAS" ],
              [ LBL_SIZE, AUTO ],
              [ ROTATION, 270 ],
              [ POSITION_XY,      [ 60+gap_between_rows_mm-frogs_bananas_difference-base_frog_bananas_comp_size/2,0]],
              [ LBL_PLACEMENT, BOTTOM ]
            ]
          ]
        ]
      ],
      [ BOX_COMPONENT,
        [
          [ CMP_NUM_COMPARTMENTS_XY, [1, 1] ],
          [ CMP_COMPARTMENT_SIZE_XYZ, [base_frog_bananas_comp_size-frogs_bananas_difference, small_box_y-wall*2, 25-2] ],
          [CMP_SHAPE,                             FILLET ],
          [CMP_FILLET_RADIUS,                             10 ],
          [ POSITION_XY, [0, 0] ],
		  		  
		  [ LABEL,
            [
                        [LBL_TEXT,        "FROGS"
                        ],
                        [LBL_PLACEMENT,     CENTER],
                        [ LBL_SIZE,         12],
                        [ ROTATION,         90],
                        [ POSITION_XY,      [ 0,0]],
                        [ LBL_FONT,         "Times New Roman:style=bold italic"],

                    ]
					]
        ]
      ],
      [ BOX_COMPONENT,
        [
          [ CMP_NUM_COMPARTMENTS_XY, [1, 1] ],
          [ CMP_COMPARTMENT_SIZE_XYZ, [base_frog_bananas_comp_size+frogs_bananas_difference, small_box_y-wall*2, 25-2] ],
          [CMP_SHAPE,                             FILLET ],
          [CMP_FILLET_RADIUS,                             10 ],
          [ POSITION_XY, [60-2*wall+gap_between_rows_mm-frogs_bananas_difference, 0] ],
		  
		  [ LABEL,
            [
                        [LBL_TEXT,        "BANANAS"
                        ],
                        [LBL_PLACEMENT,     CENTER],
                        [ LBL_SIZE,         AUTO],
                        [ ROTATION,         90],
                        [ POSITION_XY,      [ 0,0]],
                        [ LBL_FONT,         "Times New Roman:style=bold italic"],

                    ]
					]
        ]
      ]
    ]
  ],
	
  [ "leaves box",
    [
      [ BOX_SIZE_XYZ, [small_box_x, small_box_y, 40.0] ],
      //[ BOX_STACKABLE_B, t ],                  // stackable base
      [ BOX_LID,
        [
			[LID_FIT_UNDER_B, t],
           //[ LID_INSET_B, t ],                  // required for stackable stacks
          // [ LID_SOLID_B, f ],                  // honeycomb (mesh) lid
          // [ LID_PATTERN_RADIUS, 3 ],           // hex radius; tweak to taste
          [ LABEL,
            [
              [ LBL_TEXT, "FOOD" ],
              [ LBL_SIZE, AUTO ],
              [ LBL_PLACEMENT, CENTER ]
            ]
          ]
        ]
      ],
      [ BOX_COMPONENT,                         // one full-size compartment
        [
          [ CMP_NUM_COMPARTMENTS_XY, [1, 1] ],
          // interior size; keep a safe margin vs walls
          [ CMP_COMPARTMENT_SIZE_XYZ, [small_box_x - 2*wall, small_box_y - 2*wall, 38] ],
		  
          //[CMP_SHAPE,                             FILLET ],
        ]
      ]
    ]
  ],
 
];

MakeAll();
