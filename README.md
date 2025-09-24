# 🦌 Nature Big Box Deluxe Board Game Organizer

<div align="center">
  <img src=".github/images/animation.gif" alt="Nature Big Box Deluxe Organizer Animation" width="800"/>
</div>

A complete 3D-printed organizer system for the **Nature Big Box Deluxe** Kickstarter edition, designed to transform your gaming experience from chaotic setup to streamlined play.

![Nature Big Box Deluxe](https://img.shields.io/badge/Game-Nature%20%20Big%20Box%20Deluxe-green?style=for-the-badge)
![3D Printing](https://img.shields.io/badge/3D%20Printing-OpenSCAD-blue?style=for-the-badge)

## 🎯 Overview

Say goodbye to countless paper boxes and hello to organized gaming bliss! This custom organizer system replaces the original packaging with precisely designed storage solutions that fit perfectly in your Nature Big Box.

### ✨ Key Features

- **🎲 Complete Organization**: Every token, card, and component has its place
- **⚡ Quick Setup**: Grab modules and go - no more sorting through paper boxes
- **🔧 Modular Design**: Individual boxes for each expansion and module
- **📏 Perfect Fit**: Designed around actual component measurements
- **🖨️ A1 Mini Ready**: All components fit on Bambu A1 Mini print bed
- **🎨 Custom Details**: Hand-crafted elements like water holes and snow leopard cutouts

## 📦 What's Included

### Core Storage
- **🏠 Main Game Box** (18×14×4cm) - Houses the entire core game except player bags and elephant graveyard mini-expansion

### Token Organizers
- **🥩 Meat Tokens Box** (7×12×4cm) with lid - *Can be reduced to 3cm height if needed*
- **🍃 Leaves Tokens Box** (7×12×4cm) with lid
- **👥 Population Tokens Box** (7×12×4cm) with lid

### Module-Specific Boxes
Each expansion gets its own dedicated storage, designed to include as many components as possible for quick module setup:

- **🧊 Tundra Module Box** (17×14.5×3cm) with lid - *Includes dedicated water hole storage on top!*
- **🦅 Flight Module Box** (17×14.5×3cm) with lid
- **🦕 Jurassic Module Box** (17×14.5×3cm) with lid
- **🌿 Rainforest Module Box** (17×14.5×3cm) with lid - *Features water hole storage on top!*

### Special Expansion Storage
- **⚡ Natural Disasters Box** (12×14×2cm) with lid
- **🐸 Frogs Token Box** - Fits inside Rainforest module box
- **🍌 Bananas Token Box** - Fits inside Rainforest module box  
- **☄️ Comet Token Box** - Fits inside Natural Disasters box

> **Note**: Jurassic species tokens, Jurassic predator tokens, and rulebooks require separate storage.

## 🛠️ Built With

This organizer leverages the incredible [**Boardgame Insert Toolkit**](https://github.com/dppdppd/The-Boardgame-Insert-Toolkit), enhanced with custom manual work for unique elements like water holes and the awesome snow leopard design.

## 🖨️ Printing Information

- **📐 Print Plates**: 16 total plates
- **🖨️ Printer**: Optimized for Bambu A1 Mini (largest piece is exactly 18cm width)
- **📏 Largest Component**: Core game box at 18×14×4cm
- **⏱️ Print Time**: in my A1 mini it was around 1hr for smaller boxes or lids and around 2-3 hours for each expansion box.
- **⚖️ Filament Consumption**: 
  - Small boxes (token organizers): ~50g each
  - Large expansion boxes: ~100g each
  - **💡 Pro Tip**: Use **Lightning** infill (I used 15%) to save filament, and it's still strong enough for its purpose
- **🧵 Material**: I printed with Bambu PLA of different varieties

## 📁 Files Structure

```
📂 nature-deluxe/
├── 🔧 nature.scad              # Main OpenSCAD source file
├── 📐 boardgame_insert_toolkit_lib.3.scad  # Toolkit library
├── 🛠️ bit_functions_lib.3.scad # Additional functions
├── 🎯 examples.3.scad          # Usage examples
├── 📦 *.stl                    # Ready-to-print STL files
├── 🎨 *.3mf                    # 3MF project files
└── 📖 README.md               # This file
```

## 🚀 Getting Started

1. **Download** the STL files for the components you need
2. **Slice** using your preferred slicer (optimized for A1 Mini)
3. **Print** each component
4. **Organize** your Nature Big Box components
5. **Enjoy** lightning-fast game setup!

## 🎮 Setup Experience

Before: *"Where is the Tundra dice hole? Are those the right predator tokens? Let me check three different boxes..."*

After: *"Tundra module tonight? Perfect, grab the blue box and we're ready to play!"*

## 🤝 Contributing

Found an improvement or have suggestions? Feel free to:
- Open an issue for bugs or feature requests
- Submit pull requests for enhancements
- Share your print results and modifications


## 🙏 Acknowledgments

- **dppdppd** for the incredible [Boardgame Insert Toolkit](https://github.com/dppdppd/The-Boardgame-Insert-Toolkit)
- **North Star Games** for creating Nature and its amazing expansions

---

*Transform your Nature Big Box into an organized gaming paradise! 🌟*

![Made with ❤️](https://img.shields.io/badge/Made%20with-❤️-red?style=flat-square) ![OpenSCAD](https://img.shields.io/badge/Powered%20by-OpenSCAD-blue?style=flat-square)
