# CLAUDE.md

This file provides guidance to Claude Code (claude.ai/code) when working with code in this repository.

## Development Commands

### Code Formatting
- **Format Lua code**: Use `stylua .` (configured in `stylua.toml` with 2 spaces, 120 column width)
- **Check formatting**: Run `stylua --check .` to verify code formatting

### Plugin Management
- **Install plugins**: Open Neovim, plugins auto-install via lazy.nvim on first launch
- **Update plugins**: Use `:Lazy update` within Neovim
- **Check plugin status**: Use `:Lazy` to open the plugin manager interface

## Architecture Overview

This is a **LazyVim-based Neovim configuration** that follows a modular plugin architecture:

### Core Structure
- `init.lua` - Entry point that bootstraps lazy.nvim
- `lua/config/lazy.lua` - Lazy.nvim setup and plugin loading configuration
- `lua/config/` - Core configuration (options, keymaps, autocmds)
- `lua/plugins/` - Individual plugin configurations

### Plugin Configuration Pattern
Each plugin is configured in its own file under `lua/plugins/` using the lazy.nvim spec format:
```lua
return {
  "plugin-author/plugin-name",
  opts = { /* plugin options */ },
  config = function() /* setup code */ end,
  dependencies = { "other-plugins" },
}
```

### Key Plugin Categories
- **Language Support**: TypeScript/JavaScript, Vue.js, Ruby, C/C++, Python
- **Development Tools**: LSP servers, formatters, debugger (DAP), Git integration
- **UI/UX**: Custom dashboard with image display, Snacks.nvim components, themes
- **AI Integration**: Copilot for code completion, Claude Code plugin for AI assistance

### Language Server Configuration
- **Ruby**: Uses ruby_lsp with custom rbenv path (`/Users/kienbz/.rbenv/versions/3.2.0/bin/ruby-lsp`)
- **TypeScript/Vue**: Configured with Vue Language Server plugin integration
- **Mason**: Auto-installs and manages language servers, formatters, and linters

### Custom Features
- **Dashboard**: Custom Snacks.nvim dashboard with ASCII art image display using img2art
- **TODO Integration**: Built-in TODO list functionality in dashboard using ripgrep
- **Git Blame**: Integrated git blame with custom message templates
- **Image Support**: Image rendering in buffers via image.nvim and diagram support

### Development Workflow
1. Open Neovim in project directory
2. LazyVim auto-detects file types and loads appropriate language servers
3. Use `<leader>` keybindings for common operations (LazyVim defaults apply)
4. Custom keybindings: `<leader>fp` for finding plugin files, `<leader>ce` for ESLint fix
5. Format on save enabled via conform.nvim for supported file types

### Configuration Overrides
The configuration extends LazyVim defaults rather than replacing them. Key patterns:
- Plugin specs in `lua/plugins/core.lua` override LazyVim defaults
- Uses `opts` functions to extend rather than replace default configurations
- Maintains backward compatibility with LazyVim keybindings and behavior

### File Locations
- **Plugin configs**: Each plugin gets its own file in `lua/plugins/`
- **Core configs**: `lua/config/` contains Neovim core settings
- **Assets**: Dashboard images stored in `lua/plugins/dashboard_img/`
- **Lock file**: `lazy-lock.json` tracks exact plugin versions