# SBP: Sway

My sway layout; keybindings and config.

# Concepts to keep in mind from i3

i3 concept is build upon `container`s.
A container is a node that contains other containers, or nodes.
Unlike BSPWM; the tree is not binary.
Tree traverses in sequence the following

* **root window**; kinda like the beginning of tree.
* It's split into **displays**; which is monitors.
* Each display has some special top level nodes, such as **dock** and **content**
* Each display also has **workspaces**
* Each workspace has **containers** which can house **windows** into apps, or other containers.

Containers have split modes, and it determines how they are displayed.

* `splith` mode shows **container** nodes next to each other on horizontal direction.
* `splitv` mode shows **container** nodes next to each other on vertical direction.
* `stacking` mode shows the active node in **container**, and a vertically stacked list of other nodes.
* `tabbed` mode shows the active node in **container**, and a horizontally stacked list of other nodes.

# Layout

The tree layout should be organized in a different way than the X window layout.

## Main monitor Workspaces: Intent

Each workspace should be of different *intent*, rather than an app; unlike current layout.

* Default
* Work
* Creative
* Programming
* Media
* Gaming
* System

And these should be navigable using `Mod R/L`.

* External monitors should work like a single workspace; and split by default.
* Each workspace should have a **primary container** in `tabbed` mode.
* The leaves of the top tabbed mode should swap using `Mod U/D`.
* If an app generates a window, it should be in a split.
(So if a window has a child;
put this window in a split container,
add the new window to the container.)
* New apps should be launched in a new tab.

## Status bar

Status bar would contain what apps are in current **primary container** and the activated groups.

