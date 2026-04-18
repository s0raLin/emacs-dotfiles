# Emacs 配置说明

## 文件结构

```
emacs/
├── init.el           # 主入口，加载顺序控制
└── lisp/
    ├── setup-ui.el   # 界面配置
    ├── setup-font.el # 字体配置
    └── setup-edit.el # 编辑配置
```

## 模块说明

### init.el
- 包管理器初始化
- use-package 安装
- 加载顺序

### setup-ui.el
- 隐藏工具栏、菜单栏、滚动条
- 行号显示（终端模式自动关闭）
- 主题加载 (ef-dream)
- 启动 ASCII logo

### setup-font.el
- 英文/代码字体：Maple Mono NF CN (130)
- 中文/符号字体：霞鹜文楷 Bold

### setup-edit.el
- 括号自动匹配
- Tab = 2 空格
- 当前行高亮

## 使用

```bash
emacs
```

或 daemon 模式：
```bash
emacs --daemon
emacsclient -c
```