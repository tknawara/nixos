
$env.PROMPT_INDICATOR = ""
$env.PROMPT_INDICATOR_VI_INSERT = ""
$env.PROMPT_INDICATOR_VI_NORMAL = ""
$env.config = {
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
