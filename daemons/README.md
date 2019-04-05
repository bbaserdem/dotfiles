# Daemons

This is a pet project of mine, writing multiple daemons for system monitoring,
that can output commands straight to infobar instances.

# Usage

Launch respective script.
The scripts are responsive to two arguments.

* **method**: The method to print scripts.
* **color**: The color of the accents of the output.

They can be given as environment variables, or as command line arguments.
`color='#FFFFFF`, `script --color='#FFFFFF'` or `script -c '#FFFFFF'` works.

# wrapper.py

A wrapper around printing methods, that handles printing specific formats.
Properties that this deals with are

* **method**: The method to use when printing. (Defaults to polybar)
* **color**: Accent color. (Defaults to red.)
* **fields**: All info corresponding to printing lies here

The field variable contains
* **text**: List of text to be printed.
* **color**: Main text color.
* **on-click**,**on-click-right**,**on-scroll-up**,**on-scroll-down**

# color.py

Contains routines regarding color scheme of the output.
To change color theme, define colors on this file.
