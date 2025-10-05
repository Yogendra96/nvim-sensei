# nvim-sensei 🥋

> One-command Neovim setup with integrated learning tools, LeetCode practice, and 20+ language support

**nvim-sensei** is a comprehensive, automated LazyVim installation script that transforms your Neovim into a powerful development and learning environment in seconds. Perfect for developers who want to master Vim motions while preparing for technical interviews.

## ✨ Features

### 🚀 One-Command Installation
- Complete LazyVim setup in ~20 seconds
- Automatic backup of existing configuration
- Cross-platform: macOS, Linux, Windows (PowerShell & WSL)
- No manual configuration needed

### 📚 Integrated Learning Tools
- **vim-be-good**: Interactive game to practice Vim motions (by ThePrimeagen)
- **precognition.nvim**: Real-time motion hints in your viewport
- **hardtime.nvim**: Enforces efficient Vim motion usage
- **cheatsheet.nvim**: Quick reference for all keybindings
- **Built-in tutorials**: Access to `:Tutor` and comprehensive help system

### 💻 LeetCode Integration
- **leetcode.nvim**: Solve coding problems directly in Neovim
- Pre-configured for Python, C++, Java, JavaScript
- Integrated test runner and submission
- Custom keybindings: `<leader>lq`, `<leader>ll`, `<leader>lr`, `<leader>ls`

### 🛠️ 20+ Language Support
Pre-configured with LazyVim extras for:
- **Web**: TypeScript, JavaScript, JSON, HTML, CSS, Tailwind
- **Systems**: Go, Rust, C/C++
- **Backend**: Python, Java, Ruby, Elixir
- **DevOps**: Docker, Terraform, YAML
- **Data**: SQL, Markdown
- **Functional**: Clojure

### 📖 Comprehensive Documentation
- **LEARNING.md**: 600+ line beginner's guide
- **INSTALL_INFO.md**: Post-installation reference
- Progressive learning path (Day 1 → Week 4)
- Quick wins and pro tips

## 🎯 Who Is This For?

- **Neovim beginners** who want a professional setup without configuration hell
- **Interview prep** enthusiasts who want LeetCode integration
- **Vim learners** who want to master motions through practice
- **Developers** setting up Neovim on multiple machines
- **Students** learning programming with a modern IDE alternative

## ⚡ Quick Start

### Prerequisites
- **Neovim 0.9+** (recommended 0.10+)
- **Git**
- **A Nerd Font** (optional but recommended)

### Installation

#### 🍎 macOS / 🐧 Linux

```bash
# 1. Download the script
curl -O https://raw.githubusercontent.com/yogibairagi/nvim-sensei/main/install.sh

# 2. Make it executable
chmod +x install.sh

# 3. Run it
./install.sh

# 4. Start Neovim
nvim
```

#### 🪟 Windows (PowerShell)

```powershell
# 1. Download the script
Invoke-WebRequest -Uri "https://raw.githubusercontent.com/yogibairagi/nvim-sensei/main/install.ps1" -OutFile "install.ps1"

# 2. Run it
.\install.ps1

# 3. Start Neovim
nvim
```

#### 🪟 Windows (WSL/Git Bash)

```bash
# Same as macOS/Linux instructions above
curl -O https://raw.githubusercontent.com/yogibairagi/nvim-sensei/main/install.sh
chmod +x install.sh
./install.sh
nvim
```

**That's it!** Your Neovim is now fully configured with learning tools and LeetCode integration.

### What Gets Installed

**Config Location:**
- macOS/Linux: `~/.config/nvim/`
- Windows: `%LOCALAPPDATA%\nvim\` (typically `C:\Users\YourName\AppData\Local\nvim\`)

**Directory Structure:**
```
nvim/
├── init.lua                              # LazyVim entry point
├── lua/
│   ├── config/                          # LazyVim core config
│   │   ├── autocmds.lua
│   │   ├── keymaps.lua
│   │   ├── lazy.lua
│   │   └── options.lua
│   └── plugins/                         # Plugin configurations
│       ├── extras.lua                   # 20+ language extras
│       ├── leetcode.lua                 # LeetCode integration
│       ├── learning.lua                 # Vim learning tools
│       └── which-key-learning.lua       # Custom keybindings
├── LEARNING.md                          # Comprehensive guide
└── INSTALL_INFO.md                      # Quick reference
```

## 📚 Learning Path

### Day 1: Basics
```vim
:Tutor                    " Start Vim's built-in tutorial (30 minutes)
:VimBeGood                " Practice with the game
<leader>up                " Toggle motion hints (precognition)
```

### Week 1: Essential Motions
- Master `hjkl` navigation
- Learn `w`, `b`, `e` for word movement
- Practice `0`, `$`, `^` for line navigation
- Use `f`, `t` for character jumping

### Week 2: Operators & Text Objects
- Combine operators: `d`, `c`, `y`
- With text objects: `iw`, `aw`, `i"`, `a"`
- Practice: `ciw`, `dap`, `yi"`

### Week 3: Advanced Features
- Visual mode: `v`, `V`, `<C-v>`
- Macros: `q{register}`, `@{register}`
- Search and replace: `/`, `?`, `:%s/old/new/g`

### Week 4: LeetCode Practice
```vim
<leader>lq                " Open LeetCode
<leader>ll                " Browse problems
<leader>lr                " Run test cases
<leader>ls                " Submit solution
```

## 🎮 Learning Tools

### vim-be-good
Interactive game for practicing Vim motions:
```vim
:VimBeGood                " Start the game
<leader>vg                " Quick launch
```

### Precognition (Motion Hints)
See available motions highlighted in real-time:
```vim
<leader>up                " Toggle motion hints
```

### Hardtime (Motion Training)
Forces efficient motion usage:
```vim
<leader>uh                " Toggle hardtime mode
<leader>uH                " View report
```

### Cheatsheet
Quick reference for all keybindings:
```vim
<leader>?                 " Open cheatsheet
```

## ⌨️ Key Bindings

### Learning & Practice
| Key | Action |
|-----|--------|
| `<leader>vg` | Launch vim-be-good game |
| `<leader>vt` | Open :Tutor |
| `<leader>up` | Toggle motion hints |
| `<leader>uh` | Toggle hardtime |
| `<leader>?` | Open cheatsheet |

### LeetCode
| Key | Action |
|-----|--------|
| `<leader>lq` | Open LeetCode |
| `<leader>ll` | List problems |
| `<leader>lr` | Run code |
| `<leader>ls` | Submit solution |

### LazyVim Defaults
| Key | Action |
|-----|--------|
| `<leader>ff` | Find files |
| `<leader>sg` | Search with grep |
| `<leader>e` | File explorer |
| `<leader>gg` | Open lazygit |

## 🔧 Customization

**Plugin configurations location:**
- macOS/Linux: `~/.config/nvim/lua/plugins/`
- Windows: `%LOCALAPPDATA%\nvim\lua\plugins\`

Edit them to customize:

```lua
-- learning.lua
return {
  {
    "tris203/precognition.nvim",
    opts = {
      startVisible = true,  -- Start with hints enabled
    },
  },
}
```

## 📦 What's Included

### Core Plugins
- **lazy.nvim**: Fast plugin manager
- **LazyVim**: Pre-configured Neovim setup
- **which-key.nvim**: Keybinding hints
- **telescope.nvim**: Fuzzy finder

### Learning Plugins
- **vim-be-good**: Motion practice game
- **precognition.nvim**: Motion hints
- **hardtime.nvim**: Motion training
- **cheatsheet.nvim**: Quick reference

### Development Tools
- **LSP**: Language servers via Mason
- **Treesitter**: Syntax highlighting
- **Auto-completion**: blink.cmp
- **Git integration**: lazygit, gitsigns
- **Debugging**: nvim-dap
- **Testing**: neotest
- **Formatting**: conform.nvim
- **Linting**: nvim-lint

### Interview Prep
- **leetcode.nvim**: LeetCode integration
- Pre-configured for multiple languages
- Integrated test runner
- Easy submission workflow

## 🆘 Troubleshooting

### Neovim version too old

**macOS:**
```bash
brew install neovim
```

**Linux (Ubuntu/Debian):**
```bash
sudo add-apt-repository ppa:neovim-ppa/unstable
sudo apt update && sudo apt install neovim
```

**Windows:**
```powershell
# Using Scoop (recommended)
scoop install neovim

# Using Chocolatey
choco install neovim

# Using Winget
winget install Neovim.Neovim
```

### Plugin installation fails
```vim
:Lazy sync              " Re-sync all plugins
:Lazy clean             " Remove unused plugins
:Lazy update            " Update all plugins
```

### LeetCode not working
```vim
:LeetcodeSignIn         " Sign in to LeetCode
:checkhealth leetcode   " Check plugin health
```

## 🤝 Contributing

Contributions are welcome! Here's how:

1. **Fork the repository**
2. **Create a feature branch**: `git checkout -b feature/amazing-feature`
3. **Make your changes**
4. **Test thoroughly**: Run the script in a clean environment
5. **Commit**: `git commit -m "Add amazing feature"`
6. **Push**: `git push origin feature/amazing-feature`
7. **Open a Pull Request**

### Ideas for Contributions
- Additional learning plugins
- More language support
- Alternative themes
- Documentation improvements
- Bug fixes
- Performance optimizations

## 📊 Comparison with Other Solutions

| Feature | nvim-sensei | LazyVim Starter | Manual Setup |
|---------|-------------|-----------------|--------------|
| One-command install | ✅ | ❌ | ❌ |
| Learning tools | ✅ | ❌ | ❌ |
| LeetCode integration | ✅ | ❌ | ❌ |
| Language support (20+) | ✅ | ⚠️ (manual) | ⚠️ (manual) |
| Documentation | ✅ (600+ lines) | ⚠️ (basic) | ❌ |
| Setup time | ~20 seconds | ~5 minutes | Hours/Days |
| Beginner friendly | ✅ | ⚠️ | ❌ |

## 📄 License

MIT License - see [LICENSE](LICENSE) for details

## 🙏 Acknowledgments

- **[LazyVim](https://github.com/LazyVim/LazyVim)** - Folke Lemaitre's excellent Neovim distribution
- **[vim-be-good](https://github.com/ThePrimeagen/vim-be-good)** - ThePrimeagen's motion practice game
- **[leetcode.nvim](https://github.com/kawre/leetcode.nvim)** - kawre's LeetCode integration
- **[precognition.nvim](https://github.com/tris203/precognition.nvim)** - tris203's motion hints
- **[hardtime.nvim](https://github.com/m4xshen/hardtime.nvim)** - m4xshen's motion training

## ⭐ Star History

If this project helped you, please consider giving it a star! It helps others discover the project.

## 📞 Support

- **Issues**: [GitHub Issues](https://github.com/yogibairagi/nvim-sensei/issues)
- **Discussions**: [GitHub Discussions](https://github.com/yogibairagi/nvim-sensei/discussions)

---

**Made with ❤️ for the Neovim community**

*Master Vim motions, ace technical interviews, and become a Neovim sensei* 🥋
