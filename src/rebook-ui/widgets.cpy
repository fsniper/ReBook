#include "widgets.h"
#include "exec.h"

#include "build/rmkit.h"

#include "boost/json/src.hpp"
#include "boost/unordered/unordered_map.hpp"

using namespace std
using namespace boost::json

class SearchInput: public ui::TextInput:
  private:
  ui::Pixmap* logo
  ui::Text* log_line

  public:

  SearchInput(int x, y, w, h, ui::Pixmap* logo, ui::Text* log_line, std::string t = "input"): TextInput(x, y, w, h, t):
    self->logo = logo
    self->log_line = log_line
    self->events.done += PLS_LAMBDA(std::string &s):
      self.search_for(s)
      self.text = ""
      self.mark_redraw()
    ;

  void before_render():
    framebuffer::get()->waveform_mode = WAVEFORM_MODE_AUTO

  void search_for(std::string query):
    self->log_line->text = "Searching for " + query
    self->log_line->mark_redraw()

    std::stringstream quoted_query
    quoted_query << std::quoted(query)

    result := std::string(exec(("/opt/rebook-go-standardebooks -action search -query " + quoted_query.str()).c_str()))

    value jv = parse(result)
    books := jv.as_array()
    vector<std::string> options
    boost::unordered_map<std::string, std::string> urls;

    
    if not books.empty():
      it := books.begin();
      while true:
        obj := it->as_object()
        key := std::string(obj.at("Name").as_string().subview()) + ", " + std::string(obj.at("Author").as_string().subview())
        urls[key] = std::string(obj.at("Url").as_string().subview())
        options.push_back(key)
        if ++it == books.end():
          break;


    pager := new ui::Pager(0, 0, 700, 800, NULL)
    pager->options = options
    pager->setup_for_render()
    pager->events.selected += [=](std::string t):
      self->log_line->text = "Downloading " + t
      self->log_line->mark_redraw()

      std::stringstream quoted_t
      quoted_t << std::quoted(std::string(urls.at(t)))

      std::string cmd = "/opt/rebook-go-standardebooks -action download -name '"

      cmd = cmd + t
      cmd = cmd + "' -url "
      cmd = cmd + quoted_t.str()
      cmd = cmd + " -path /home/root/"
      exec(cmd.c_str())

      self->log_line->text = "Downloaded " + t
      self->log_line->mark_redraw()
      
      ui::MainLoop::hide_overlay()
      self->logo->mark_redraw()
    ;

    self->logo->mark_redraw()
    pager->show()
