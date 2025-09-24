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
g_isolated_print_box = "all";

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

gap_between_columns_mm = 3.0; // horizontal gap between columns
gap_between_rows_mm = 2.0; // vertical gap between the two rows
finger_cutout_on_front_4b = [f, f, t, f]; // [Front, Back, Left, Right]
$fn = 64; // smooth circles

tolerance_gap = 2.0;
nest_diam = 70.0; // left column, both rows
dice_diam = 39.0; // left column, both rows
round_indicator_dial_diam = 55 + tolerance_gap;
// regular cards
reg_w = 63.0 + tolerance_gap;
reg_h = 89.0 + tolerance_gap;
// Player aids and natural disaster cards
big_w = 80.0 + tolerance_gap;
big_h = 120.0 + tolerance_gap;

// Depths (how deep the pocket is from the top rim down)
depth_solo_cards = 2.0 + tolerance_gap;
depth_player_aids = 2.0 + tolerance_gap;
depth_reg_deep = 15.0 + tolerance_gap;

// ---- Derived layout (don’t change unless you want a different packing) ----
// Column widths (interior)
colL_w = nest_diam;
colM_w = big_w;

// Row heights (interior)
rowTop_h = reg_h; // top row must fit round pocket & reg deck
rowBottom_h = big_h; // bottom row must fit round pocket & big deck

// Exterior box size
box_x = 170;
box_y = 145;
box_z = 30.0;

// Initial calculations which led to 17*14.5 size. Also 14.5 because original box is 30 cm, and we want to fit two boxes in that space, thus 14.5*2=29cm and 1cm for tolerance
//box_x = (2 * wall) + colL_w + gap_between_columns_mm + colM_w + gap_between_columns_mm + 9;
//box_y = (2 * wall) + nest_diam * 2 + gap_between_rows_mm + 0;

// Helper: lower-left origins of each grid cell (interior coords)
llx_L = wall;
llx_M = llx_L + colL_w + gap_between_columns_mm;
llx_R = llx_M + colM_w + gap_between_columns_mm;

lly_T = 0 + nest_diam + gap_between_rows_mm; // top row starts above bottom row
lly_B = 0;

center_mid = 130;
rainforest_center_mid = 132;
tundra_center_of_aids_solo = 135;
natural_disaster_center = 85;
comet_box_x = 30;
comet_box_y = 50;
comet_box_z = 18;

watering_hole_height = 2.0;

small_box_x = 120.0;
small_box_y = 70.0;

// Core decks are bigger than modules
core_nature_deck_height = 30 + tolerance_gap;
core_hunter_deck_height = 7 + tolerance_gap;
core_player_aids_height = 4 + tolerance_gap;
core_center_of_aids_solo = 145;

// Change to adjust the proportion between frogs/bananas compartments
frogs_bananas_difference = 15;
base_frog_bananas_comp_size = (small_box_x - wall * 2 - gap_between_rows_mm) / 2;

function player_aids(x, y, depth = depth_player_aids, cutouts = [f, f, f, f]) =
  [
    BOX_COMPONENT,
    [
      [CMP_SHAPE, SQUARE],
      [CMP_NUM_COMPARTMENTS_XY, [1, 1]],
      [CMP_COMPARTMENT_SIZE_XYZ, [big_w, big_h, depth]],
      [POSITION_XY, [x, y]],
      [CMP_SHAPE_VERTICAL_B, t],
      [CMP_CUTOUT_SIDES_4B, cutouts],
    ],
  ];
function solo_cards(x, y, depth = depth_solo_cards, rotation = 0, cutouts = [f, f, t, t]) =
  [
    BOX_COMPONENT,
    [
      [CMP_SHAPE, SQUARE],
      [CMP_NUM_COMPARTMENTS_XY, [1, 1]],
      [CMP_COMPARTMENT_SIZE_XYZ, [reg_w, reg_h, depth]],
      [POSITION_XY, [x, y]],
      [CMP_SHAPE_VERTICAL_B, t],
      [CMP_CUTOUT_SIDES_4B, cutouts],
      [ROTATION, rotation],
    ],
  ];

// As solo cards and nature cards are the same size, this is just a syntax sugar  
function nature_cards(x, y, depth = depth_reg_deep, rotation = 0, cutouts = [f, f, f, f]) =
  solo_cards(x, y, depth, rotation, cutouts);

function round_compartment(x, y, diam, depth = 20.0, cutouts = [f, f, f, f]) =
  [
    BOX_COMPONENT,
    [
      [CMP_SHAPE, ROUND],
      [CMP_NUM_COMPARTMENTS_XY, [1, 1]],
      [CMP_COMPARTMENT_SIZE_XYZ, [diam, diam, depth]],
      [POSITION_XY, [x, y]],
      [CMP_SHAPE_VERTICAL_B, t],
      [CMP_CUTOUT_SIDES_4B, cutouts],
    ],
  ];

function make_lid(label_text) =
  [
    BOX_LID,
    [
      [LID_SOLID_B, f],
      [
        LABEL,
        [
          [LBL_TEXT, label_text],
          [LBL_SIZE, AUTO],
          [LBL_PLACEMENT, CENTER],
        ],
      ],
    ],
  ];

data = [
  [
    "flight",
    [
      [BOX_SIZE_XYZ, [box_x, box_y, box_z]],

      // Two slots for nest tokens
      round_compartment(-5, lly_T, nest_diam, depth=25.0, cutouts=finger_cutout_on_front_4b),
      round_compartment(-5, 0, nest_diam, depth=25.0, cutouts=finger_cutout_on_front_4b),

      // SOLO cards on the bottom
      solo_cards(center_mid - reg_w / 2 - 10, box_y / 2 - reg_h / 2, depth=depth_player_aids + depth_solo_cards + depth_reg_deep),
      // Full deck then (rotated)
      nature_cards(center_mid - reg_w / 2 - 10, box_y / 2 - reg_h / 2, depth=depth_player_aids + depth_reg_deep, rotation=90),
      // Player aids on top
      player_aids(center_mid - big_w / 2 - 10, box_y / 2 - big_h / 2),

      make_lid(label_text="FLIGHT"),
    ],
  ],

  [
    "tundra",
    [
      [BOX_SIZE_XYZ, [box_x, box_y, box_z]],

      // Big dice
      round_compartment(wall, box_y - dice_diam - wall * 2, dice_diam, depth=28.0, cutouts=finger_cutout_on_front_4b),

      // Full deck
      nature_cards(wall, wall, depth=depth_reg_deep + watering_hole_height, cutouts=[t, f, f, f]),

      // SOLO cards on the bottom
      solo_cards(tundra_center_of_aids_solo - reg_w / 2 - 10, box_y / 2 - reg_h / 2, depth=depth_player_aids + depth_solo_cards + watering_hole_height, cutouts=[f, f, f, f]),

      // Player aids on top
      player_aids(tundra_center_of_aids_solo - big_w / 2 - 10, box_y / 2 - big_h / 2, depth=depth_player_aids + watering_hole_height, cutouts=[f, f, f, t]),

      make_lid(label_text="TUNDRA"),
    ],
  ],

  [
    "jurassic",
    // Almost the same as tundra, just no watering hole and different label
    [
      [BOX_SIZE_XYZ, [box_x, box_y, box_z]],

      // Big dice
      round_compartment(wall, box_y - dice_diam - wall * 2, dice_diam, depth=28.0, cutouts=finger_cutout_on_front_4b),

      // Full deck
      nature_cards(wall, wall, depth=depth_reg_deep, cutouts=[t, f, f, f]),

      // SOLO cards on the bottom
      solo_cards(tundra_center_of_aids_solo - reg_w / 2 - 10, box_y / 2 - reg_h / 2, depth=depth_player_aids + depth_solo_cards, cutouts=[f, f, f, f]),
      // Player aids on top
      player_aids(tundra_center_of_aids_solo - big_w / 2 - 10, box_y / 2 - big_h / 2, depth=depth_player_aids, cutouts=[f, f, f, t]),

      make_lid(label_text="JURASSIC"),
    ],
  ],

  [
    "core",
    [
      [BOX_SIZE_XYZ, [180, 140, 40]],

      // Round indicator
      round_compartment(
        6,
        75,
        round_indicator_dial_diam,
        depth=7.0 + core_hunter_deck_height + watering_hole_height
      ),

      // Dial center small hole
      // 10 is diameter of the thingy in the middle of the indicator
      round_compartment(
        6 + round_indicator_dial_diam / 2 - 10 / 2,
        75 + round_indicator_dial_diam / 2 - 10 / 2,
        10,
        depth=2.0 + 7.0 + core_hunter_deck_height + watering_hole_height
      ),

      // Full deck
      nature_cards(wall + 12, -12, depth=core_nature_deck_height + watering_hole_height, rotation=90, cutouts=[f, f, t, f]),

      // Hunter cards
      nature_cards(wall + 12, reg_w - 7, depth=core_hunter_deck_height + watering_hole_height, rotation=90, cutouts=[f, f, f, t]),

      // SOLO cards in the middle
      nature_cards(50, box_y / 2 - reg_h / 2, depth=depth_solo_cards + core_nature_deck_height + watering_hole_height, cutouts=[f, f, f, t]),

      // Player aids
      player_aids(core_center_of_aids_solo - big_w / 2 - 10, box_y / 2 - big_h / 2, depth=core_player_aids_height + watering_hole_height, cutouts=[f, f, f, t]),

      make_lid("CORE"),
    ],
  ],

  [
    "natural_disasters",
    // Smaller than others, like two small boxes together
    [
      [BOX_SIZE_XYZ, [small_box_x, small_box_y * 2, 20]],

      //Comet compartment
      [
        BOX_COMPONENT,
        [
          [CMP_SHAPE, SQUARE],
          [CMP_NUM_COMPARTMENTS_XY, [1, 1]],
          [CMP_COMPARTMENT_SIZE_XYZ, [comet_box_x + 1, comet_box_y + 1, comet_box_z]],
          [POSITION_XY, [wall, 0]],
          [CMP_SHAPE_VERTICAL_B, t],
          [CMP_CUTOUT_SIDES_4B, [t, f, f, f]],
          [
            LABEL,
            [
              [
                LBL_TEXT,
                "Natural",
              ],
              [LBL_PLACEMENT, BACK],
              [LBL_SIZE, 10],
              [ROTATION, 90],
              [POSITION_XY, [53, 6]],
              [LBL_FONT, "Times New Roman:style=bold italic"],
            ],
          ],
          [
            LABEL,
            [
              [
                LBL_TEXT,
                "Disasters",
              ],
              [LBL_PLACEMENT, BACK],
              [LBL_SIZE, 10],
              [ROTATION, 90],
              [POSITION_XY, [53, -6]],
              [LBL_FONT, "Times New Roman:style=bold italic"],
            ],
          ],
        ],
      ],

      // SOLO cards on the bottom
      nature_cards(natural_disaster_center - reg_w / 2 - 10, box_y / 2 - reg_h / 2, depth=depth_reg_deep + depth_solo_cards),
      // Player aids on top
      player_aids(natural_disaster_center - big_w / 2 - 10, box_y / 2 - big_h / 2, depth=depth_reg_deep, cutouts=[f, f, f, t]),

      make_lid("NATURAL DISASTERS"),
    ],
  ],

  [
    "natural_disasters_comet",
    [
      [BOX_SIZE_XYZ, [comet_box_x, comet_box_y, comet_box_z]],
      [BOX_NO_LID_B, t],
      [
        BOX_COMPONENT,
        [
          [CMP_NUM_COMPARTMENTS_XY, [1, 1]],
          [CMP_COMPARTMENT_SIZE_XYZ, [comet_box_x - 2 * wall, comet_box_y - 2 * wall, comet_box_z - 2]],
          [CMP_SHAPE, FILLET],
        ],
      ],
      // without lid actually
      // [
      //   BOX_LID,
      //   [
      //     [ENABLED_B, f],
      //     [LID_FIT_UNDER_B, f],
      //     [
      //       LABEL,
      //       [
      //         [LBL_TEXT, "COMET"],
      //         [LBL_SIZE, AUTO],
      //         [LBL_PLACEMENT, CENTER],
      //       ],
      //     ],
      //   ],
      // ],
    ],
  ],

  [
    "rainforest",
    [
      [BOX_SIZE_XYZ, [box_x, box_y, box_z]],

      // Frogs and banana tokens box space
      [
        BOX_COMPONENT,
        [
          [CMP_SHAPE, SQUARE],
          [CMP_NUM_COMPARTMENTS_XY, [1, 1]],
          // As our main box is 14*7, we want to have space for smaller box
          // Extra +2 for lid of the box which should be 70*120*26
          [CMP_COMPARTMENT_SIZE_XYZ, [70 + 1, 120 + 1, 26 + 2 + watering_hole_height]],
          [POSITION_XY, [wall, wall]],
          [CMP_SHAPE_VERTICAL_B, t],
          [CMP_CUTOUT_SIDES_4B, [t, f, f, f]],
        ],
      ],

      // SOLO cards on the bottom
      nature_cards(rainforest_center_mid - reg_w / 2 - 10, box_y / 2 - reg_h / 2, depth=depth_player_aids + depth_solo_cards + depth_reg_deep + watering_hole_height, cutouts=[f, f, t, t]),
      // Full deck then (rotated)
      nature_cards(rainforest_center_mid - reg_h / 2, box_y / 2 - reg_h / 2, depth=depth_player_aids + depth_reg_deep + watering_hole_height, rotation=90),
      // Player aids on top
      player_aids(rainforest_center_mid - big_w / 2 - 10, box_y / 2 - big_h / 2, depth=depth_player_aids + watering_hole_height, cutouts=[f, f, f, f]),

      make_lid("RAINFOREST"),
    ],
  ],
  [
    "meat",
    [
      [BOX_SIZE_XYZ, [small_box_x, small_box_y, 40.0]],
      [
        BOX_COMPONENT,
        [
          [CMP_NUM_COMPARTMENTS_XY, [1, 1]],
          [CMP_COMPARTMENT_SIZE_XYZ, [small_box_x - 2 * wall, small_box_y - 2 * wall, 38]],
        ],
      ],
      make_lid("MEAT"),
    ],
  ],
  [
    "population",
    [
      [BOX_SIZE_XYZ, [small_box_x, small_box_y, 40.0]],
      [
        BOX_COMPONENT,
        [
          [CMP_NUM_COMPARTMENTS_XY, [1, 1]],
          [CMP_COMPARTMENT_SIZE_XYZ, [small_box_x - 2 * wall, small_box_y - 2 * wall, 38]],
        ],
      ],
      make_lid("POPULATION"),
    ],
  ],
  [
    "leaves",
    [
      [BOX_SIZE_XYZ, [small_box_x, small_box_y, 40.0]],
      [
        BOX_COMPONENT,
        [
          [CMP_NUM_COMPARTMENTS_XY, [1, 1]],
          [CMP_COMPARTMENT_SIZE_XYZ, [small_box_x - 2 * wall, small_box_y - 2 * wall, 38]],
        ],
      ],
      make_lid("FOOD"),
    ],
  ],

  [
    "bananas and frogs",
    [
      // 26 seems not enough... height should match what's inside bigger RAINFORST box
      [BOX_SIZE_XYZ, [small_box_x, small_box_y, 25.0]],
      [
        BOX_LID,
        [
          [
            LABEL,
            [
              [LBL_TEXT, "FROGS"],
              [LBL_SIZE, AUTO],
              [ROTATION, 270],
              [POSITION_XY, [-base_frog_bananas_comp_size / 2 - frogs_bananas_difference + wall * 2, 0]],
              [LBL_PLACEMENT, CENTER],
            ],
          ],

          [
            LABEL,
            [
              [LBL_TEXT, "BANANAS"],
              [LBL_SIZE, AUTO],
              [ROTATION, 270],
              [POSITION_XY, [60 + gap_between_rows_mm - frogs_bananas_difference - base_frog_bananas_comp_size / 2, 0]],
              [LBL_PLACEMENT, BOTTOM],
            ],
          ],
        ],
      ],
      [
        BOX_COMPONENT,
        [
          [CMP_NUM_COMPARTMENTS_XY, [1, 1]],
          [CMP_COMPARTMENT_SIZE_XYZ, [base_frog_bananas_comp_size - frogs_bananas_difference, small_box_y - wall * 2, 25 - 2]],
          [CMP_SHAPE, FILLET],
          [CMP_FILLET_RADIUS, 10],
          [POSITION_XY, [0, 0]],

          [
            LABEL,
            [
              [
                LBL_TEXT,
                "FROGS",
              ],
              [LBL_PLACEMENT, CENTER],
              [LBL_SIZE, 12],
              [ROTATION, 90],
              [POSITION_XY, [0, 0]],
              [LBL_FONT, "Times New Roman:style=bold italic"],
            ],
          ],
        ],
      ],
      [
        BOX_COMPONENT,
        [
          [CMP_NUM_COMPARTMENTS_XY, [1, 1]],
          [CMP_COMPARTMENT_SIZE_XYZ, [base_frog_bananas_comp_size + frogs_bananas_difference, small_box_y - wall * 2, 25 - 2]],
          [CMP_SHAPE, FILLET],
          [CMP_FILLET_RADIUS, 10],
          [POSITION_XY, [60 - 2 * wall + gap_between_rows_mm - frogs_bananas_difference, 0]],

          [
            LABEL,
            [
              [
                LBL_TEXT,
                "BANANAS",
              ],
              [LBL_PLACEMENT, CENTER],
              [LBL_SIZE, AUTO],
              [ROTATION, 90],
              [POSITION_XY, [0, 0]],
              [LBL_FONT, "Times New Roman:style=bold italic"],
            ],
          ],
        ],
      ],
    ],
  ],
];

MakeAll();
