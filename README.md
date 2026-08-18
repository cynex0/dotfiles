<div align="center">
<h1>⚫ dotfiles</h1>
<p>Personal configuration for Linux (Hyprland) and macOS (AeroSpace)</p>
</div>

---

## Installation

_Dear future me (probably),_

```bash
git clone git@github.com:cynex0/dotfiles.git ~/dotfiles
cd ~/dotfiles
```

**macOS (fresh laptop):**
```bash
./setup.sh
```

**Linux:**
```bash
stow common linux
```

**macOS (manual):**
```bash
stow common macos
```

## Showcase

### Linux

![Desktop with fastfetch](./img/fastfetch.png)

![Desktop with wofi](./img/wofi.png)

![Neovim](./img/nvim.png)

## Components

### Shared
- Terminal: [`ghostty`](https://github.com/ghostty-org/ghostty) — CommitMono Nerd Font, kanagawa palette
- Editor: [`neovim`](https://github.com/neovim/neovim) — kickstart-based, codeium, harpoon, treesitter
- Multiplexer: [`tmux`](https://github.com/tmux/tmux)
- Shell: `zsh` with [`oh-my-zsh`](https://github.com/ohmyzsh/ohmyzsh/)

### Linux
- Compositor/WM: [`hyprland`](https://github.com/hyprwm/Hyprland)
- Status Bar: [`waybar`](https://github.com/Alexays/Waybar)
- App Launch: [`wofi`](https://hg.sr.ht/~scoopta/wofi)
- Notifications: [`swaync`](https://github.com/ErikReider/SwayNotificationCenter)
- Wallpaper setter: [`hyprpaper`](https://github.com/hyprwm/hyprpaper)
- Keyboard: [`kmonad`](https://github.com/kmonad/kmonad)

### macOS
- WM: [`aerospace`](https://github.com/nikitabobko/AeroSpace)
- Keyboard: [`karabiner-elements`](https://github.com/pqrs-org/Karabiner-Elements) — caps lock = esc/ctrl
- Launcher: [`raycast`](https://www.raycast.com/)
- Scroll: [`unnaturalscrollwheels`](https://github.com/ther0n/UnnaturalScrollWheels)

## Acknowledgements
- [@IonelPopJara](https://github.com/IonelPopJara) and his [dotfiles](https://github.com/IonelPopJara/dotfiles)
- [ML4W Dotfiles for Hyprland](https://github.com/mylinuxforwork/dotfiles)
- [kickstart.nvim](https://github.com/nvim-lua/kickstart.nvim) and [kickstart-modular.nvim](https://github.com/dam9000/kickstart-modular.nvim?tab=readme-ov-file)
- [midnight](https://github.com/refact0r/midnight-discord/tree/master) discord theme
- [Stow has forever changed the way I manage my dotfiles](https://youtu.be/y6XCebnB9gs) (Youtube - Dreams of Autonomy)
