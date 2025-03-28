# Neovim Configuration

This is a modular Neovim configuration built with Lazy.nvim as the plugin manager.

## Structure

```
~/.config/nvim/
├── init.lua            # Main configuration file
├── lazy-lock.json      # Plugin version lock file
├── lua/
│   ├── behaviour.lua   # Custom behaviors (autocmds, options)
│   ├── keybinds.lua    # Custom keybindings
│   └── plugins/        # Plugin configurations
│       ├── init.lua    # Main plugin loader
│       ├── claude.lua  # Claude AI integration
│       ├── telescope.lua
│       ├── nvimtree.lua
│       └── ...         # Other plugin configs
```

## Key Components

### behaviour.lua

Contains custom behaviors and autocommands:
- Directory change handling (updates plugins when changing directories)
- Other custom autocmds and behavior settings

### keybinds.lua

Central location for all custom keybindings:
- Ctrl+S: Save file in all modes
- Ctrl+N: Toggle terminal
- Ctrl+B: Toggle file explorer

### plugins/

Each plugin has its own configuration file:
- `init.lua`: Loads all other plugin files
- Individual plugin configs (telescope.lua, nvimtree.lua, etc.)

## Adding New Plugins

Add a new file in the `lua/plugins/` directory following the Lazy.nvim format:

```lua
return {
  "username/plugin-name",
  config = function()
    -- Plugin configuration
  end
}
```

The plugin will be automatically loaded by Lazy.nvim.