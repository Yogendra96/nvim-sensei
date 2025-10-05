#!/bin/bash

# LazyVim Complete Installation Script
# Includes: LazyVim + Language Support + LeetCode + Learning Tools
# Author: Setup script for comprehensive Neovim configuration

set -e

echo "🚀 Starting Complete LazyVim Installation..."
echo ""

# Check if Neovim is installed
if ! command -v nvim &> /dev/null; then
    echo "❌ Neovim is not installed. Please install Neovim first."
    echo ""
    echo "Installation instructions:"
    echo "  macOS:   brew install neovim"
    echo "  Linux:   sudo apt install neovim  # or your package manager"
    echo "  Windows: scoop install neovim"
    exit 1
fi

# Show Neovim version
NVIM_VERSION=$(nvim --version | head -1)
echo "✓ Found Neovim: $NVIM_VERSION"
echo ""

# Backup existing config if it exists
if [ -d "$HOME/.config/nvim" ]; then
    BACKUP_DIR="$HOME/.config/nvim.backup.$(date +%Y%m%d_%H%M%S)"
    echo "📦 Backing up existing config to: $BACKUP_DIR"
    mv "$HOME/.config/nvim" "$BACKUP_DIR"
    echo ""
fi

# Clone LazyVim starter
echo "📥 Cloning LazyVim starter template..."
git clone https://github.com/LazyVim/starter "$HOME/.config/nvim"
echo ""

# Remove .git directory
echo "🧹 Cleaning up git directory..."
rm -rf "$HOME/.config/nvim/.git"
echo ""

# Create plugins directory if it doesn't exist
mkdir -p "$HOME/.config/nvim/lua/plugins"

echo "⚙️  Creating plugin configurations..."

# 1. Create extras configuration (Language Support)
echo "  - Language support & extras..."
cat > "$HOME/.config/nvim/lua/plugins/extras.lua" << 'EOF'
return {
  -- Language Support
  { import = "lazyvim.plugins.extras.lang.typescript" },
  { import = "lazyvim.plugins.extras.lang.json" },
  { import = "lazyvim.plugins.extras.lang.python" },
  { import = "lazyvim.plugins.extras.lang.go" },
  { import = "lazyvim.plugins.extras.lang.rust" },
  { import = "lazyvim.plugins.extras.lang.yaml" },
  { import = "lazyvim.plugins.extras.lang.markdown" },
  { import = "lazyvim.plugins.extras.lang.docker" },
  { import = "lazyvim.plugins.extras.lang.clojure" },
  { import = "lazyvim.plugins.extras.lang.gleam" },
  { import = "lazyvim.plugins.extras.lang.astro" },
  { import = "lazyvim.plugins.extras.lang.svelte" },
  { import = "lazyvim.plugins.extras.lang.kotlin" },
  { import = "lazyvim.plugins.extras.lang.php" },
  { import = "lazyvim.plugins.extras.lang.ruby" },
  { import = "lazyvim.plugins.extras.lang.elixir" },
  { import = "lazyvim.plugins.extras.lang.java" },
  { import = "lazyvim.plugins.extras.lang.terraform" },
  { import = "lazyvim.plugins.extras.lang.toml" },
  { import = "lazyvim.plugins.extras.lang.nushell" },

  -- Formatting & Linting
  { import = "lazyvim.plugins.extras.formatting.prettier" },
  { import = "lazyvim.plugins.extras.linting.eslint" },

  -- Coding Enhancements
  { import = "lazyvim.plugins.extras.coding.copilot" },
  { import = "lazyvim.plugins.extras.coding.copilot-chat" },
  { import = "lazyvim.plugins.extras.coding.yanky" },
  { import = "lazyvim.plugins.extras.coding.mini-surround" },
  { import = "lazyvim.plugins.extras.coding.neogen" },
  { import = "lazyvim.plugins.extras.coding.luasnip" },

  -- UI Enhancements
  { import = "lazyvim.plugins.extras.ui.edgy" },
  { import = "lazyvim.plugins.extras.ui.mini-animate" },

  -- Editor Enhancements
  { import = "lazyvim.plugins.extras.editor.mini-files" },
  { import = "lazyvim.plugins.extras.editor.telescope" },
  { import = "lazyvim.plugins.extras.editor.aerial" },
  { import = "lazyvim.plugins.extras.editor.outline" },

  -- DAP (Debugging)
  { import = "lazyvim.plugins.extras.dap.core" },

  -- Testing
  { import = "lazyvim.plugins.extras.test.core" },

  -- Utilities
  { import = "lazyvim.plugins.extras.util.project" },
}
EOF

# 2. Create LeetCode plugin configuration
echo "  - LeetCode integration..."
cat > "$HOME/.config/nvim/lua/plugins/leetcode.lua" << 'EOF'
return {
  {
    "kawre/leetcode.nvim",
    build = ":TSUpdate html",
    dependencies = {
      "nvim-telescope/telescope.nvim",
      "nvim-lua/plenary.nvim",
      "MunifTanjim/nui.nvim",
      "nvim-treesitter/nvim-treesitter",
      "rcarriga/nvim-notify",
      "nvim-tree/nvim-web-devicons",
    },
    opts = {
      arg = "leetcode.nvim",
      lang = "python",
      cn = { enabled = false },
      storage = {
        home = vim.fn.stdpath("data") .. "/leetcode",
        cache = vim.fn.stdpath("cache") .. "/leetcode",
      },
      plugins = { non_standalone = false },
      logging = true,
      injector = {
        ["python"] = { before = true },
        ["cpp"] = {
          before = { "#include <bits/stdc++.h>", "using namespace std;" },
          after = "int main() {}",
        },
        ["java"] = { before = "import java.util.*;" },
      },
      cache = { update_interval = 60 * 60 * 24 * 7 },
      console = {
        open_on_runcode = true,
        dir = "row",
        size = { width = "90%", height = "75%" },
        result = { size = "60%" },
        testcase = { virt_text = true, size = "40%" },
      },
      description = {
        position = "left",
        width = "40%",
        show_stats = true,
      },
      hooks = {
        ["enter"] = {},
        ["question_enter"] = {},
        ["leave"] = {},
      },
      keys = {
        toggle = { "q" },
        confirm = { "<CR>" },
        reset_testcases = "r",
        use_testcase = "U",
        focus_testcases = "H",
        focus_result = "L",
      },
    },
    keys = {
      { "<leader>lq", "<cmd>Leet<cr>", desc = "Open Leetcode" },
      { "<leader>ll", "<cmd>Leet list<cr>", desc = "List Problems" },
      { "<leader>lr", "<cmd>Leet run<cr>", desc = "Run Code" },
      { "<leader>ls", "<cmd>Leet submit<cr>", desc = "Submit Solution" },
      { "<leader>li", "<cmd>Leet info<cr>", desc = "Problem Info" },
      { "<leader>ld", "<cmd>Leet desc<cr>", desc = "Toggle Description" },
      { "<leader>lc", "<cmd>Leet console<cr>", desc = "Toggle Console" },
      { "<leader>lt", "<cmd>Leet tabs<cr>", desc = "Problem Tabs" },
      { "<leader>ly", "<cmd>Leet yank<cr>", desc = "Yank Solution" },
      { "<leader>lL", "<cmd>Leet lang<cr>", desc = "Change Language" },
    },
  },
}
EOF

# 3. Create Learning plugins configuration
echo "  - Learning tools (VimBeGood, Precognition, Hardtime)..."
cat > "$HOME/.config/nvim/lua/plugins/learning.lua" << 'EOF'
return {
  -- Game to practice vim motions
  {
    "ThePrimeagen/vim-be-good",
    cmd = "VimBeGood",
    keys = {
      { "<leader>vg", "<cmd>VimBeGood<cr>", desc = "Vim Be Good (Practice Game)" },
    },
  },

  -- Shows available motions in your viewport
  {
    "tris203/precognition.nvim",
    event = "VeryLazy",
    opts = {
      startVisible = false,
      showBlankVirtLine = true,
      highlightColor = { link = "Comment" },
      hints = {
        Caret = { text = "^", prio = 2 },
        Dollar = { text = "$", prio = 1 },
        MatchingPair = { text = "%", prio = 5 },
        Zero = { text = "0", prio = 1 },
        w = { text = "w", prio = 10 },
        b = { text = "b", prio = 9 },
        e = { text = "e", prio = 8 },
        W = { text = "W", prio = 7 },
        B = { text = "B", prio = 6 },
        E = { text = "E", prio = 5 },
      },
      gutterHints = {
        G = { text = "G", prio = 10 },
        gg = { text = "gg", prio = 9 },
        PrevParagraph = { text = "{", prio = 8 },
        NextParagraph = { text = "}", prio = 8 },
      },
      disabled_fts = {
        "neo-tree",
        "TelescopePrompt",
        "Trouble",
        "lazy",
        "mason",
      },
    },
    keys = {
      {
        "<leader>up",
        function()
          require("precognition").toggle()
        end,
        desc = "Toggle Precognition (Motion Hints)",
      },
    },
  },

  -- Forces you to use vim motions properly (optional, can be annoying)
  {
    "m4xshen/hardtime.nvim",
    dependencies = { "MunifTanjim/nui.nvim", "nvim-lua/plenary.nvim" },
    cmd = "Hardtime",
    opts = {
      max_count = 4,
      disable_mouse = false,
      hint = true,
      notification = true,
      allow_different_key = true,
      disabled_filetypes = {
        "qf",
        "netrw",
        "neo-tree",
        "lazy",
        "mason",
        "oil",
        "TelescopePrompt",
      },
      restricted_keys = {
        ["h"] = { "n", "x" },
        ["j"] = { "n", "x" },
        ["k"] = { "n", "x" },
        ["l"] = { "n", "x" },
        ["-"] = { "n", "x" },
        ["+"] = { "n", "x" },
        ["gj"] = { "n", "x" },
        ["gk"] = { "n", "x" },
        ["<CR>"] = { "n", "x" },
        ["<C-M>"] = { "n", "x" },
        ["<C-N>"] = { "n", "x" },
        ["<C-P>"] = { "n", "x" },
      },
      disabled_keys = {
        ["<Up>"] = { "", "i" },
        ["<Down>"] = { "", "i" },
        ["<Left>"] = { "", "i" },
        ["<Right>"] = { "", "i" },
      },
    },
    keys = {
      { "<leader>uh", "<cmd>Hardtime toggle<cr>", desc = "Toggle Hardtime (Vim Motion Training)" },
      { "<leader>uH", "<cmd>Hardtime report<cr>", desc = "Hardtime Report" },
    },
  },

  -- Quick reference for keybindings
  {
    "sudormrfbin/cheatsheet.nvim",
    cmd = { "Cheatsheet", "CheatsheetEdit" },
    dependencies = {
      "nvim-telescope/telescope.nvim",
      "nvim-lua/popup.nvim",
      "nvim-lua/plenary.nvim",
    },
    keys = {
      { "<leader>?", "<cmd>Cheatsheet<cr>", desc = "Cheatsheet" },
    },
  },
}
EOF

# 4. Create Which-Key learning extensions
echo "  - Which-Key learning keybindings..."
cat > "$HOME/.config/nvim/lua/plugins/which-key-learning.lua" << 'EOF'
return {
  {
    "folke/which-key.nvim",
    opts = function(_, opts)
      opts.spec = opts.spec or {}
      vim.list_extend(opts.spec, {
        { "<leader>v", group = "vim learning" },
        { "<leader>vt", "<cmd>Tutor<cr>", desc = "Vim Tutor (Built-in Tutorial)" },
        { "<leader>vh", "<cmd>help<cr>", desc = "Help" },
        { "<leader>vq", "<cmd>help quickref<cr>", desc = "Quick Reference" },
        { "<leader>vm", "<cmd>help motion<cr>", desc = "Motion Help" },
        { "<leader>vw", "<cmd>help windows<cr>", desc = "Window Help" },
        { "<leader>vb", "<cmd>help buffers<cr>", desc = "Buffer Help" },
        { "<leader>vc", "<cmd>help commands<cr>", desc = "Command Help" },
        { "<leader>vk", "<cmd>help keycodes<cr>", desc = "Keycodes Help" },
        { "<leader>vo", "<cmd>help options<cr>", desc = "Options Help" },
      })
      return opts
    end,
  },
}
EOF

# 5. Create comprehensive learning documentation
echo "  - Learning documentation (LEARNING.md)..."
cat > "$HOME/.config/nvim/LEARNING.md" << 'EOF'
# 🎓 Learning Neovim Inside Neovim

## 🚀 Quick Start

### 1. Interactive Tutorial (START HERE!)
```vim
:Tutor
```
This is the **best** way to learn Vim/Neovim basics. Takes about 30 minutes.

### 2. Practice Game
```vim
:VimBeGood
```
Or press `<leader>vg` - Fun game to practice motions!

### 3. Motion Hints (Training Wheels)
```vim
<leader>up
```
Toggle **Precognition** to see available motions highlighted in your viewport.

### 4. Hardtime (Advanced Training)
```vim
<leader>uh
```
Forces you to use efficient motions (can be annoying but very effective!)

## 📚 Built-in Help System

### Quick Access Keybindings
- `<leader>vt` - Vim Tutor
- `<leader>vh` - Open Help
- `<leader>vq` - Quick Reference
- `<leader>vm` - Motion Help
- `<leader>vw` - Window Help
- `<leader>?` - Cheatsheet

### Manual Help Commands
```vim
:help                  " Main help
:help quickref         " Quick reference
:help motion.txt       " All motions
:help text-objects     " Text objects (ciw, daw, etc.)
:help windows          " Window management
:help buffers          " Buffer management
:help visual-mode      " Visual mode
:help insert-mode      " Insert mode
:help normal-mode      " Normal mode
:help user-manual      " Full user manual
```

### Search Help
```vim
:help <topic>          " General search
:helpgrep <pattern>    " Search all help files
```

## 🎯 Essential Concepts to Learn (in order)

### 1. Basic Movement (Week 1)
- `hjkl` - Arrow keys replacement
- `w/b` - Word forward/backward
- `e` - End of word
- `0/$` - Start/end of line
- `gg/G` - Top/bottom of file
- `{/}` - Paragraph up/down

**Practice:** `:help motion.txt`

### 2. Operators (Week 1-2)
- `d` - Delete
- `c` - Change
- `y` - Yank (copy)
- `p/P` - Paste after/before
- `.` - Repeat last change

**Practice:** `:help operator`

### 3. Text Objects (Week 2)
- `iw/aw` - Inner/around word
- `i"/a"` - Inner/around quotes
- `i(/a(` - Inner/around parentheses
- `it/at` - Inner/around tag
- `ip/ap` - Inner/around paragraph

**Practice:** `:help text-objects`

### 4. Combining (Week 2-3)
```vim
ciw  " Change inner word
daw  " Delete around word
yi(  " Yank inside parentheses
vip  " Visual select paragraph
```

**Practice:** `:VimBeGood` then play the "TextManip" game

### 5. Search & Replace (Week 3)
```vim
/pattern       " Search forward
?pattern       " Search backward
n/N           " Next/previous match
*/#           " Search word under cursor
:%s/old/new/g " Replace all
```

**Practice:** `:help pattern-searches`

### 6. Macros (Week 4)
```vim
qa        " Start recording macro in register 'a'
q         " Stop recording
@a        " Play macro 'a'
@@        " Repeat last macro
```

**Practice:** `:help recording`

## 🎮 Learning Plugins Installed

### VimBeGood
```vim
:VimBeGood          " Start the game
<leader>vg          " Keybinding
```
Games available:
- `relative` - Practice relative line numbers
- `hjkl` - Basic movements
- `word` - Word motions
- `delete` - Deletion practice
- `whackamole` - Reaction time

### Precognition (Motion Hints)
```vim
<leader>up          " Toggle hints on/off
```
Shows available motions:
- `w/b/e` - Word motions
- `^/$` - Line start/end
- `{/}` - Paragraph motions
- `gg/G` - File top/bottom

### Hardtime (Strict Training)
```vim
<leader>uh          " Toggle on/off
<leader>uH          " View report
```
Prevents:
- Excessive `hjkl` usage
- Arrow keys in insert mode
- Forces efficient motions

## 📖 Recommended Learning Path

### Day 1: Basics
1. Run `:Tutor` (30 min)
2. Practice `hjkl` movement
3. Learn `i/a/o/O` for insert mode
4. Practice `dd/yy/p`

### Day 2-3: Motions
1. Enable Precognition: `<leader>up`
2. Practice `w/b/e` movements
3. Learn `0/$` for line navigation
4. Play `:VimBeGood` (10 min daily)

### Week 2: Text Objects
1. Study `:help text-objects`
2. Practice `ciw`, `daw`, `yi(`
3. Enable Hardtime: `<leader>uh` (if feeling brave!)
4. Play VimBeGood "delete" game

### Week 3: Advanced
1. Learn search/replace
2. Practice macros
3. Study `:help windows`
4. Customize your config

## 🔥 Pro Tips

1. **Don't use arrow keys** - They're disabled in hardtime for a reason
2. **Use relative line numbers** - Makes jumping easier (`7j` to jump down 7 lines)
3. **Think in verbs + nouns** - `d` (delete) + `iw` (inner word) = delete word
4. **Use `.` to repeat** - Most powerful command in Vim
5. **Learn one thing at a time** - Don't overwhelm yourself
6. **Practice daily** - Even 10 minutes makes a difference

## 🎯 Quick Wins (Learn These First!)

```vim
ciw     " Change inner word (cursor on any part of word)
daw     " Delete around word (includes space)
dd      " Delete line
yy      " Copy line
p       " Paste
.       " Repeat last change
u       " Undo
<C-r>   " Redo
>>      " Indent line
<<      " Unindent line
==      " Auto-indent line
```

## 🚀 LazyVim Specific

### LazyVim Cheatsheet
```vim
<leader>?   " Show cheatsheet
<leader>sk  " Search keymaps
<leader>sC  " Search commands
```

### Essential LazyVim Keys
```vim
<leader>e   " File explorer
<leader>ff  " Find files
<leader>sg  " Search with grep
<leader>bb  " Switch buffers
<leader>qq  " Quit all
```

## 🎓 LeetCode Integration

### Quick Start
```vim
<leader>lq  " Open LeetCode
<leader>ll  " List problems
<leader>lr  " Run code
<leader>ls  " Submit solution
```

### Workflow
1. Open LeetCode: `<leader>lq`
2. Browse problems: `<leader>ll`
3. Select a problem (Enter)
4. Write your solution
5. Test: `<leader>lr`
6. Submit: `<leader>ls`

## 📚 Additional Resources

Within Neovim:
```vim
:help user-manual           " Complete user manual
:help tips                  " Tips and tricks
:help reference-toc         " Table of contents
:Tutor                      " Interactive tutorial
```

External (bookmark these):
- https://neovim.io/doc/user/
- https://www.lazyvim.org/
- https://vim.fandom.com/

## 🎓 Your Learning Checklist

- [ ] Complete `:Tutor` (30 min)
- [ ] Learn basic motions (hjkl, w/b/e)
- [ ] Master text objects (ciw, daw, yi()
- [ ] Practice with `:VimBeGood` (5 games)
- [ ] Enable Precognition for 1 week
- [ ] Try Hardtime for 1 day
- [ ] Learn search and replace
- [ ] Record your first macro
- [ ] Solve 1 LeetCode problem in Neovim
- [ ] Customize one keybinding
- [ ] Help someone else learn Vim!

---

**Remember:** Vim mastery is a journey, not a destination. Start with basics, practice daily, and gradually add new skills. You'll be flying through code in no time! 🚀
EOF

echo ""
echo "✅ All plugin configurations created!"
echo ""

# Create a README for the installation
cat > "$HOME/.config/nvim/INSTALL_INFO.md" << 'EOF'
# LazyVim Installation Information

## What was installed?

### Core
- **LazyVim** - Modern Neovim configuration framework
- **Lazy.nvim** - Plugin manager

### Language Support (20+ languages)
- TypeScript/JavaScript
- Python
- Go
- Rust
- Java
- Ruby
- Elixir
- And many more...

### Development Tools
- **Prettier** - Code formatting
- **ESLint** - Linting
- **Copilot** - AI pair programming
- **DAP** - Debugging
- **Neotest** - Testing framework

### Learning Tools
- **vim-be-good** - Practice game for Vim motions
- **precognition.nvim** - Shows available motions in viewport
- **hardtime.nvim** - Forces efficient motion usage
- **cheatsheet.nvim** - Quick reference guide

### Special Features
- **leetcode.nvim** - Solve LeetCode problems in Neovim
- **Telescope** - Fuzzy finder
- **Mini.files** - File explorer
- **Which-Key** - Keybinding hints

## First Steps

1. **Start Neovim**
   ```bash
   nvim
   ```

2. **Wait for plugins to install** (2-5 minutes on first launch)

3. **Start learning**
   ```vim
   :Tutor
   ```

4. **Read the learning guide**
   ```vim
   :e ~/.config/nvim/LEARNING.md
   ```

## Quick Reference

### Essential Keybindings
- `<Space>` - Leader key (shows all commands)
- `<leader>e` - File explorer
- `<leader>ff` - Find files
- `<leader>sg` - Search in files
- `<leader>?` - Show cheatsheet

### Learning
- `<leader>vt` - Start Vim tutor
- `<leader>vg` - Vim practice game
- `<leader>up` - Toggle motion hints
- `<leader>vh` - Open help

### LeetCode
- `<leader>lq` - Open LeetCode
- `<leader>ll` - List problems
- `<leader>lr` - Run code
- `<leader>ls` - Submit solution

## Customization

Edit these files to customize:
- `~/.config/nvim/lua/config/options.lua` - Neovim options
- `~/.config/nvim/lua/config/keymaps.lua` - Custom keybindings
- `~/.config/nvim/lua/plugins/` - Add/modify plugins

## Plugin Management

```vim
:Lazy              " Open plugin manager
:Lazy sync         " Install/update plugins
:Lazy clean        " Remove unused plugins
:LazyExtras        " Manage extras (languages, tools)
```

## Getting Help

```vim
:help              " Main help
:help <topic>      " Search for topic
:Tutor             " Interactive tutorial
:checkhealth       " Check Neovim installation
```

## Troubleshooting

If plugins don't load:
1. Restart Neovim
2. Run `:Lazy sync`
3. Run `:checkhealth`

For LeetCode authentication:
1. Open `:Leet`
2. Follow the authentication prompts
3. Sign in to your LeetCode account

---

Installation completed on: $(date)
EOF

echo "📝 Installation summary created: ~/.config/nvim/INSTALL_INFO.md"
echo ""

# Final messages
echo "════════════════════════════════════════════════════════════════"
echo ""
echo "✅ LazyVim Complete Installation Finished!"
echo ""
echo "════════════════════════════════════════════════════════════════"
echo ""
echo "📚 What's Included:"
echo "   ✓ LazyVim with 20+ language support"
echo "   ✓ LeetCode integration"
echo "   ✓ Learning tools (VimBeGood, Precognition, Hardtime)"
echo "   ✓ Copilot AI assistance"
echo "   ✓ Debugging (DAP) and Testing (Neotest)"
echo "   ✓ Comprehensive documentation"
echo ""
echo "🚀 Next Steps:"
echo ""
echo "   1. Start Neovim:"
echo "      $ nvim"
echo ""
echo "   2. Wait for plugins to install (2-5 minutes)"
echo ""
echo "   3. Start the interactive tutorial:"
echo "      :Tutor"
echo ""
echo "   4. Read the learning guide:"
echo "      :e ~/.config/nvim/LEARNING.md"
echo ""
echo "   5. View installation info:"
echo "      :e ~/.config/nvim/INSTALL_INFO.md"
echo ""
echo "📖 Quick Commands:"
echo "   :Lazy          - Manage plugins"
echo "   :Tutor         - Interactive Vim tutorial"
echo "   :VimBeGood     - Practice game"
echo "   :Leet          - LeetCode integration"
echo "   <Space>        - Show all keybindings"
echo "   <leader>?      - Cheatsheet"
echo ""
echo "💡 Pro Tip: Press <Space> in Neovim to see all available commands!"
echo ""
echo "════════════════════════════════════════════════════════════════"
echo ""
echo "🎉 Happy Vimming!"
echo ""
