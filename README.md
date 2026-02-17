# Daniv's Dotfiles

Welcome to mission control.

This is my personal macOS setup: fast, keyboard-first, and tuned for deep work.
If your ideal desktop is calm, minimal, and a little obsessive about details, you are in the right place.

## Core Stack

- `aerospace/` - Tiling window manager with Alt-based navigation and workspace flow
- `sketchybar/` - Custom status bar with workspace state, system stats, and app context
- `ghostty/` - Fira Code terminal setup with blur, transparency, and Aura theme
- `nvim/` - Lua-first Neovim config with Lazy.nvim, LSP, Telescope, Treesitter, and Tokyo Night

## Design Intent

- Speed over ceremony
- Keyboard over mouse
- Focus over clutter
- Good defaults, light friction

## Notable Behaviors

- AeroSpace starts at login and syncs workspace changes to SketchyBar
- Workspace movement is built around `alt + h/j/k/l` and `alt + 1..8`
- Utility apps (Finder, System Settings, Activity Monitor) float by default
- SketchyBar surfaces front app, battery, DND, volume, CPU, GPU, RAM, and clock
- Neovim uses relative numbers, 2-space indentation, system clipboard, and split-friendly defaults

## Quick Start

If you want to use this setup as-is, clone it into your config directory:

```bash
git clone <your-repo-url> ~/.config
```

Then make sure these tools are installed on macOS:

- AeroSpace
- SketchyBar
- Ghostty
- Neovim
- A Nerd Font (this setup uses Hack Nerd Font in SketchyBar)

Finally, start/restart the apps so they pick up config changes.

## Philosophy in One Line

This machine should feel like an instrument, not an appliance.

---

Made by Daniv.
