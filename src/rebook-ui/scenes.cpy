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

  text := new ui::Text(50, 305, 400, 40, "ReBook The missing book store for Remarkable.")
  label := new ui::Text(50,346, 200, 40, "Search String: ")
  logo := new ui::Pixmap(0, 0, 300, 280, ICON(assets::_rebook_logo_png))
  textinput := new SearchInput(251,346,500,40, logo, "")

  // add the text widget to our scene
  scene->add(logo)
  scene->add(text)
  scene->add(label)
  scene->add(textinput)

  return scene
