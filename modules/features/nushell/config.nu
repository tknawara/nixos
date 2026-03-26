$env.PROMPT_INDICATOR = ""
$env.PROMPT_INDICATOR_VI_INSERT = ""
$env.PROMPT_INDICATOR_VI_NORMAL = ""
$env.EDITOR = "hx"
$env.config = {
  buffer_editor: "hx"
  show_banner: false
  edit_mode: vi
  error_style: "fancy"
  use_ansi_coloring: true
  cursor_shape: {
      vi_insert: line
      vi_normal: block
  }
  ls: {
      use_ls_colors: true
      clickable_links: true
  }
}

# Autostart zellij
if 'ZELLIJ' not-in $env {
    if $env.ZELLIJ_AUTO_ATTACH? == 'true' {
        zellij attach --create
    } else {
        zellij
    }
    if $env.ZELLIJ_AUTO_EXIT? == 'true' {
        exit
    }
}
