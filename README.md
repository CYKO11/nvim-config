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

## Dependencies

### Required Dependencies

#### Core Tools
- **git** - Required by lazy.nvim (plugin manager bootstrap), gitsigns.nvim, and claude-code.nvim
- **C compiler** (gcc/clang) - Required by nvim-treesitter to compile parser modules

#### Formatters
- **prettier** - JavaScript/TypeScript/Svelte/HTML/CSS/JSON/Markdown formatting
  ```bash
  npm install -g prettier
  ```
- **stylua** - Lua code formatting
  ```bash
  cargo install stylua
  # or via package manager
  ```

#### Search Tools (Telescope)
- **ripgrep (rg)** - Required for Telescope's live_grep functionality
  ```bash
  # Debian/Ubuntu
  apt install ripgrep
  ```

#### Plugin-Specific CLI Tools
- **claude** - Claude Code CLI tool, required by claude-code.nvim plugin
  ```bash
  # Install Claude Code CLI from Anthropic
  ```

### Recommended (Optional) Dependencies

- **fd** or **fd-find** - Faster file finding for Telescope (improves find_files performance)
  ```bash
  # Debian/Ubuntu
  apt install fd-find
  ```

- **Nerd Font** - For proper icon display in nvim-web-devicons, nvim-tree.lua, lualine.nvim, and various UI elements. Install any Nerd Font from https://www.nerdfonts.com/

### Language-Specific

#### Treesitter Parsers
The following language parsers will be auto-installed by nvim-treesitter:
- lua, vim, vimdoc
- javascript, typescript, html, css, svelte
- python, bash
- markdown, markdown_inline

These don't require separate host installation but do require a C compiler.

### Quick Installation

**System Package Manager:**
```bash
# Debian/Ubuntu example
sudo apt install git gcc ripgrep fd-find
```

**Node.js (npm):**
```bash
npm install -g prettier
```

**Rust (cargo):**
```bash
cargo install stylua
```

**Manual Installation:**
- Claude Code CLI (from Anthropic)
- Nerd Font (from nerdfonts.com)

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