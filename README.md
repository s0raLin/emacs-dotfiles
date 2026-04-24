# Emacs 配置说明

## 项目结构

```
emacs/
├── early-init.el        # 早期初始化（垃圾回收、界面禁用）
├── init.el              # 主入口，加载顺序控制
├── lisp/
│   ├── setup-ui.el          # 界面配置（dashboard、主题、状态栏）
│   ├── setup-keybindings.el # 快捷键映射（Leader 键、Treemacs）
│   ├── setup-editor.el      # 编辑行为（Evil、缩进、自动配对）
│   ├── setup-appearance.el  # 字体与视觉（Maple Mono + 霞鹜文楷）
│   ├── setup-corfu.el       # 自动补全 UI
│   ├── setup-tools.el       # 工具类（vertico/consult、magit、treemacs）
│   ├── setup-rust.el        # Rust 开发（LSP、rustic、inlay hints）
│   ├── setup-go.el          # Go 开发（eglot + gopls）
│   └── setup-markdown.el    # Markdown 编辑配置
└── assets/
    └── logo.png          # 启动页 Logo
```

## 配置文件说明

### early-init.el

启动前的早期优化：

- **垃圾回收优化**：启动时分配 100MB 内存，避免启动过程中的频繁 GC
- **界面禁用**：彻底禁用菜单栏、工具栏、滚动条，防止启动闪烁
- **启动画面禁用**：关闭欢迎页和启动提示

这些设置在 `init.el` 加载前生效，确保启动过程极速且无闪烁。

### init.el

主配置文件，控制加载顺序：

1. **加载路径**：将 `lisp/` 目录加入 `load-path`
2. **包管理器初始化**：配置 MELPA、GNU、NonGNU 源，安装 `use-package`
3. **模块加载**：按依赖顺序依次 require 各个 setup 模块
4. **GC 阈值恢复**：启动完成后将 `gc-cons-threshold` 调回 8MB

### 模块说明

#### setup-ui.el — 界面配置

- **性能与外观**：禁用启动屏、自定义窗口标题、禁用铃声、自动换行
- **启动页**：使用 `dashboard` 定制，显示欢迎语和自定义 Logo
- **UI 组件**：彻底关闭工具栏、菜单栏、滚动条
- **行号**：全局相对行号（`relative`），终端/Dashboard/Tree-s 等模式自动禁用
- **主题**：`doom-themes`（doom-one 深蓝主题） + `doom-modeline` 状态栏
- **彩虹括号**：`rainbow-delimiters` 区分嵌套层级

#### setup-keybindings.el — 快捷键绑定

- **Leader 键**：基于 `general`，使用 `SPC` 作为前缀（类似 Neovim）
- **常用操作**：
  - `SPC ff` — 查找文件
  - `SPC fr` — 最近文件
  - `SPC fs` — 保存文件
  - `SPC ee` — 切换 Treemacs
  - `SPC ef` — 在 Tree 中定位当前文件
  - `SPC /` — Ripgrep 搜索
  - `SPC gs` — Magit 状态
- **LSP 操作**：在 Rust buffer 中可用 `SPC ca`（code-actions）、`SPC cr`（rename）、`SPC cf`（format）

#### setup-editor.el — 编辑行为

- **Evil 模式**：完整 Vim 键位绑定，集成 `evil-collection` 支持其他插件
- **快捷键**：
  - `jk` — 退出插入模式（`evil-escape`）
  - `gc` — 注释（`evil-commentary`）
  - `s/S` — 快速跳转（`evil-snipe`）
- **缩进**：Tab = 2 空格，`indent-tabs-mode` 为 `nil`
- **自动配对**：`electric-pair-mode` 实时匹配括号
- **剪贴板**：与系统剪贴板同步

#### setup-appearance.el — 字体配置

- **英文字体**：Maple Mono Regular 13pt
- **中文字体**：霞鹜文楷（LXGW WenKai Screen），缩放 1.2 倍以对齐英文高度
- **优先级**：通过 `face-font-rescale-alist` 精确控制中英文视觉平衡

#### setup-corfu.el — 自动补全 UI

- **Corfu**：全局启用，内联弹出式补全（类似 VSCode 的 IntelliSense）
- **自动触发**：输入 2 个字符后开始，延迟 0.1s
- **文档**：在回显区显示补全项文档
- **LSP 集成**：`lsp-completion-provider` 设为 `none`，由 Corfu 接管 LSP 补全

#### setup-tools.el — 工具集成

- **模糊查找**：`vertico`（垂直补全） + `consult` + `orderless`
- **按键提示**：`which-key`（类似 Neovim which-key）
- **版本控制**：`magit`（Git 客户端）
- **文件树**：`treemacs`，支持 Evil 键位（`SPC ee` / `SPC ef`）
- **自动保存**：`super-save`，失焦或闲置 5 秒后自动保存

#### setup-rust.el — Rust 开发

- **语法高亮**：`treesit-auto`（Tree-sitter 自动安装）
- **LSP**：`lsp-mode` + `lsp-ui`，进入 `rustic-mode` / `rust-ts-mode` 时自动启动
- **代码操作**：内嵌提示（inlay hints）、行尾诊断、悬停文档
- **格式化**：保存时自动 `rustfmt`（`rustic-format-on-save`）
- **快捷键**：
  - `M-j` — `lsp-dwim`（智能代码操作）
  - `C-c f` — 格式化 buffer
  - `C-c C-c a` — 执行代码操作

#### setup-go.el — Go 开发

- **主模式**：`go-mode`
- **LSP**：`eglot` + `gopls`，保存前自动 `gofmt`

#### setup-markdown.el — Markdown 支持

- **渲染**：`markdown-mode` + `gfm-mode`（GitHub 风格）
- **代码块**：原生语法高亮（`markdown-fontify-code-blocks-natively`）
- **快捷键**：
  - `TAB` — 折叠/展开章节
  - `RET` — 跳转链接

## 使用方法

### 启动 Emacs

```bash
emacs
```

### Daemon 模式（推荐）

```bash
# 启动服务端
emacs --daemon

# 连接客户端（图形界面）
emacsclient -c

# 终端客户端
emacsclient -t
```

### 重新加载配置

在 Emacs 中执行：

```elisp
M-x eval-buffer          ; 重新加载当前 buffer
M-x load-file RET ~/.config/emacs/init.el  ; 重新加载主配置
```

## 依赖说明

### 外部工具

- **Rust**：`rust-analyzer`（LSP 服务）
- **Go**：`gopls`（LSP 服务）
- **Node.js**：`prettier`（可选，用于格式化）
- **Ripgrep**：`rg`（`consult-ripgrep` 依赖）
- **Multimarkdown**：`multimarkdown`（Markdown 预览）

### Emacs 包

通过 `use-package` 自动安装（首次启动时会下载）：

- `use-package` — 包管理
- `dashboard` — 启动页
- `doom-themes` / `doom-modeline` — 主题与状态栏
- `evil` / `evil-collection` / `evil-escape` / `evil-commentary` / `evil-snipe` — Vim 键位
- `corfu` — 自动补全 UI
- `vertico` / `consult` / `orderless` — 模糊查找
- `which-key` — 按键提示
- `magit` — Git 客户端
- `treemacs` — 文件树
- `super-save` — 自动保存
- `lsp-mode` / `lsp-ui` — LSP 客户端
- `rustic` — Rust 开发支持
- `eglot` — LSP 客户端（Go 等语言）
- `markdown-mode` — Markdown 支持
- `treesit-auto` — Tree-sitter 语法高亮

## 自定义指南

### 修改主题

编辑 `lisp/setup-ui.el` 第 75 行：

```elisp
(load-theme 'doom-one t)  ; 改为 doom-dracula、doom-opera 等
```

### 修改字体

编辑 `lisp/setup-appearance.el`：

```elisp
(set-face-attribute 'default nil
                    :font "Your-Font-Name"
                    :weight 'regular)
(set-fontset-font t 'han (font-spec :family "Your-CJK-Font"))
(add-to-list 'face-font-rescale-alist '("Your-CJK-Font" . 1.2))
```

### 修改快捷键

编辑 `lisp/setup-keybindings.el`，使用 `general-create-definer` 定义新的 Leader 键绑定。

### 禁用自动保存

编辑 `lisp/setup-tools.el`，注释掉 `super-save-mode` 相关行：

```elisp
;; (super-save-mode 1)
```

## 故障排查

### LSP 无法启动

- 确认对应语言的 LSP 服务已安装（`rust-analyzer` / `gopls`）
- 检查 `*Messages*` buffer 查看错误信息：`C-h e`
- 手动启动 LSP：`M-x lsp` 或 `M-x eglot`

### 字体显示异常

- 确认系统已安装相应字体
- 执行 `M-x describe-font` 查看当前字体配置
- 检查 `setup-appearance.el` 中的字体名称是否正确

### Evil 模式冲突

- 某些模式下 Evil 键位可能被覆盖，执行 `M-x evil-normal-state` 切换回 Normal 模式
- 使用 `C-z` 临时切换 Emacs 键位

### 性能问题

- 确认 `gc-cons-threshold` 设置正确（启动时 100MB，运行中 8MB）
- 关闭不必要的后台模式：`M-x customize-variable RET gc-cons-threshold`
- 使用 `M-x profiler-start` 进行性能分析

## 许可证

MIT License — 自由使用、修改和分发。

## 贡献

欢迎提交 Issue 和 Pull Request！
