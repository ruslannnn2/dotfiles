hl.config({
  general = {
    ["col.active_border"] = "0xff7f8c8d",    --gray
    ["col.inactive_border"] = "0xff4a5559",  --dimmer gray
    gaps_in = 3,
    gaps_out = 8,
    border_size = 2,
    layout = "dwindle",
  },
  decoration = {
    rounding = 5,
  }
})

hl.window_rule({
  match = {class = "kitty"},
  -- no_blur = true
})


