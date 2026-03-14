# config.nu
#
# Installed by:
# version = "0.102.0"
#
# This file is used to override default Nushell settings, define
# (or import) custom commands, or run any other startup tasks.
# See https://www.nushell.sh/book/configuration.html
#
# This file is loaded after env.nu and before login.nu
#
# You can open this file in your default editor using:
# config nu
#
# See `help config nu` for more options
#
# You can remove these comments if you want or leave
# them for future reference.
use std/config light-theme

$env.config.show_banner = false

# $env.EDITOR = 'nvim'
$env.EDITOR = 'hx'
$env.KI_EDITOR_KEYBOARD = 'colemak'

$env.LEDGER_FILE = ['~/writing/notes/.hledger.journal']

$env.path ++= ["/usr/bin"]
$env.path ++= ["~/dev/ols"]
$env.LD_LIBRARY_PATH = ["/usr/local/lib/"]

#bob
$env.path ++= ["/home/xanderjakeq/.local/share/bob/nvim-bin"]
#go
$env.path ++= ["/home/xanderjakeq/go/bin"]
#bun
$env.path ++= ["~/.bun/bin"]
#Odin
$env.path ++= ["/home/xanderjakeq/dev/odin/Odin"]
$env.ODIN_ROOT = "/home/xanderjakeq/dev/odin/Odin"


#cargo
$env.path ++= ["~/.cargo/bin"]

#cwebp
$env.path ++= ["/home/xanderjakeq/dev/libwebp-0.4.1-linux-x86-32/bin"]

#node bin
$env.path ++= ["/home/xanderjakeq/.nvm/versions/node/v25.2.1/bin"]
#$env.path ++= ["/home/xanderjakeq/.nvm/versions/node/./bin"]

# fly.io
$env.FLYCTL_INSTALL = "/home/xanderjakeq/.fly"
$env.path ++= [$"($env.FLYCTL_INSTALL)/bin"]

# whitebox
$env.path ++= ["/home/xanderjakeq/dev/tools/whitebox/whitebox_v0.122.0"]

# superhtml
$env.path ++= ["/usr/bin/superhtml"]

$env.books = "/media/xanderjakeq/T7/books"

$env.config = {
    color_config: (light-theme)
    edit_mode: 'vi'
}

#vulkan
$env.VULKAN_SDK = "~/dev/vulkansdk-linux-x86_64-1.4.328.1/1.4.328.1/x86_64/"
$env.path ++= [$"($env.VULKAN_SDK)/bin"]
$env.LD_LIBRARY_PATH ++= [$"($env.VULKAN_SDK)/lib"]
$env.VK_LAYER_PATH = $"($env.VULKAN_SDK)/share/vulkan/explicit_layer.d"
$env.VK_ADD_LAYER_PATH = $"($env.VULKAN_SDK)/share/vulkan/explicit_layer.d"
$env.PKG_CONFIG_PATH = $"($env.VULKAN_SDK)/lib/pkgconfig/"

$env.path ++= [$"($env.VULKAN_SDK)/bin"]

alias j = just
alias yz = yazi
alias fg = job unfreeze
alias lj = lazyjj


# NOTE: trying to install fnm but they don't support nushell for some reason
# https://github.com/Schniz/fnm/issues/463#issuecomment-2987700729

#if not (which fnm | is-empty) {
#    ^fnm env --json | from json | load-env
#
#    $env.PATH = $env.PATH | prepend ($env.FNM_MULTISHELL_PATH | path join (if $nu.os-info.name == 'windows' {''} else {'bin'}))
#    $env.config.hooks.env_change.PWD = (
#        $env.config.hooks.env_change.PWD? | append {
#            condition: {|| ['.nvmrc' '.node-version', 'package.json'] | any {|el| $el | path exists}}
#            code: {|| ^fnm use}
#        }
#    )
#}


# needed to load .env files: open .env | load-env
def "from env" []: string -> record {
  lines
    | split column '#' # remove comments
    | get column1
    | parse "{key}={value}"
    | update value {
        str trim                        # Trim whitespace between value and inline comments
          | str trim -c '"'             # unquote double-quoted values
          | str trim -c "'"             # unquote single-quoted values
          | str replace -a "\\n" "\n"   # replace `\n` with newline char
          | str replace -a "\\r" "\r"   # replace `\r` with carriage return
          | str replace -a "\\t" "\t"   # replace `\t` with tab
    }
    | transpose -r -d
}
