#include "build/rmkit.h"
#include "assets.h"
#include "scenes.h"
#include "widgets.h"

#include "boost/json/src.hpp"
#include "boost/unordered/unordered_map.hpp"

#include <iostream>

using namespace std
using namespace boost::json


ui::Scene prep_input_scene()
  scene := ui::make_scene()
  fb := framebuffer::get()
  w, h = fb->get_display_size()

  vl := new ui::VerticalLayout(40, 0, w / 2, 600, scene)
  hl := new ui::HorizontalLayout(40, 380, w / 2, 45, scene)

  log_line := new ui::Text(0, 0, 500, 40, "")
  logo := new ui::Pixmap(0, 0, 300, 280, ICON(assets::_rebook_logo_png))
  title_text := new ui::Text(0, 0, 400, 40, "ReBook The missing book store for Remarkable.")
  search_label := new ui::Text(0, 0, 200, 40, "Search For: ")
  search_input := new SearchInput(0, 0, 500,40, logo, log_line, "")


  hl->pack_start(search_label)
  hl->pack_start(search_input)

  vl->pack_start(logo)
  vl->pack_start(title_text)
  vl->pack_start(log_line)

  return scene
