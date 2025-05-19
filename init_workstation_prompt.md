## 1. 安装vscode
官网地址:
https://code.visualstudio.com/

## 2. 设置输入法
prompt: setting the chinese input method

### 检查当前系统中是否已经安装了输入法相关的软件包，不使用过滤，以获取更完整的信息。

buddy_command: `ls -la /usr/bin/*input* /usr/bin/*ibus* /usr/bin/*fcitx* 2>/dev/null || echo "No input method binaries found"`

### 检查是否已安装中文输入法引擎, 如果需要iBus以启用中文输入
buddy_command: `ls -la /usr/share/ibus/component/ || echo "No iBus components found"`

buddy_command: `ibus-daemon --version && pgrep -l ibus-daemon || echo "iBus daemon not running"`

buddy_command: `ibus-setup`

buddy_command_steps:
```
1. 点击"Input Method"（输入法）选项卡
2. 点击"Add"（添加）按钮
3. 选择"Chinese"（中文）
4. 选择"Intelligent Pinyin"（智能拼音）或其他您喜欢的中文输入法
```

buddy_command: `gsettings get org.gnome.desktop.input-sources sources`

buddy_command: `gsettings set org.gnome.desktop.input-sources sources "[('xkb', 'us'), ('ibus', 'libpinyin')]"`
buddy_steps:
```
已成功设置iBus中文拼音输入法。现在您可以：
1. 使用快捷键 Super + 空格键（Super键通常是Windows键）在不同输入法之间切换
2. 或者点击桌面右上角的键盘图标来切换输入法
如果输入法图标没有立即显示在系统托盘中，您可以：
1. 按 Alt + F2
2. 输入 r 并按回车来重新加载GNOME Shell
使用说明：
切换到中文输入法后，直接输入拼音即可
使用数字键（1-9）选择候选词
使用空格键确认选择
使用 Shift 键临时切换中英文输入
```

## 安装百度网盘

buddy_command: `wget https://wppkg.bdimg.com/file/baidupan/BaiduNetdisk_11.0.0.1_amd64.deb -O baidu-netdisk.deb || echo "Failed to download Baidu Netdisk package"`

buddy_command: `sudo dpkg -i baidu-netdisk.deb || sudo apt-get install -f -y && echo "Baidu Netdisk installed successfully"`

## 安装微信

buddy_command: `wget https://dldir1.qq.com/weixin/linux/x86_64/wechat_3.9.13.68_amd64.deb -O wechat.deb || echo "Failed to download WeChat package"`

buddy_command: `sudo dpkg -i wechat.deb || sudo apt-get install -f -y && echo "WeChat installed successfully"`

## 安装openssh

buddy_command: `sudo apt-get update && sudo apt-get install -y openssh-server || echo "Failed to install openssh-server"`

buddy_command: `sudo systemctl status ssh || echo "OpenSSH service is not running"`

## 配置密钥
敏感信息，不执行，只提示作用









