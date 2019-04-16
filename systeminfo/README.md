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

# Writing modules

Python scripts need to call the `display` method to print an output on stdin.
The following items should be defined;

* **format['actN']**: Where N is (
1: left-click,
2: middle-click,
3: right-click,
4: scroll-up,
5: scroll-down.) are shell commands to run on click.
* **format['output']**: The text to display in the info bar.
* **format['prefix']**: Icon prefix to display.
* **format['suffix']**: Icon suffix to display.
* **format['color']**: Accent color for the module.
* **mute**: When foreground should be made faded.
