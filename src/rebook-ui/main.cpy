#include "build/rmkit.h"
#include "boost/json/src.hpp"
#include "boost/unordered/unordered_map.hpp"

#include "csignal"

using namespace std
using namespace boost::json

// {{{ from https://stackoverflow.com/questions/478898/how-do-i-execute-a-command-and-get-the-output-of-the-command-within-c-using-po
```
#include <cstdio>
#include <iostream>
#include <memory>
#include <stdexcept>
#include <string>
#include <array>
#include <fstream>
#include <iomanip>

std::string exec(const char* cmd) {
    std::array<char, 128> buffer;
    std::string result;
    std::unique_ptr<FILE, decltype(&pclose)> pipe(popen(cmd, "r"), pclose);
    if (!pipe) {
        throw std::runtime_error("popen() failed!");
    }
    while (fgets(buffer.data(), buffer.size(), pipe.get()) != nullptr) {
        result += buffer.data();
    }
    return result;
}
```
// }}}

class SearchInput: public ui::TextInput:
  public:

  SearchInput(int x, y, w, h, std::string t = "input"): TextInput(x, y, w, h, t):
    self->events.done += PLS_LAMBDA(std::string &s):
      self.search_for(s)
    ;

  void search_for(std::string query):
    debug "Searching for", query

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


    pager := new ui::Pager(0, 0, 700, 700, NULL)
    pager->options = options
    pager->setup_for_render()
    pager->events.selected += [=](std::string t):
      debug "Downloading", t

      std::stringstream quoted_t
      quoted_t << std::quoted(std::string(urls.at(t)))

      std::string cmd = "/opt/rebook-go-standardebooks -action download -name '"

      cmd = cmd + t
      cmd = cmd + "' -url "
      cmd = cmd + quoted_t.str()
      cmd = cmd + " -path /home/root/"
      debug cmd
      exec(cmd.c_str())
      debug "end download"
      ui::MainLoop::hide_overlay()
      self->text = ""
    ;

    pager->show()
    debug result

int main()
  // get the framebuffer
  fb := framebuffer::get()
  // clear the framebuffer using a white rect
  fb->clear_screen()

  // make a new scene
  scene := ui::make_scene()
  // set the scene
  ui::MainLoop::set_scene(scene)

  text := new ui::Text(50, 100, 400, 40, "ReBook The missing book store for Remarkable.")
  label := new ui::Text(50,141, 200, 40, "Search String: ")
  textinput := new SearchInput(251,141,500,40, "")

  // add the text widget to our scene
  scene->add(text)
  scene->add(label)
  scene->add(textinput)



  while true:
    // main() dispatches user input handlers, runs tasks in the task queue and so on
    ui::MainLoop::main()

    // goes through all widgets that were marked as dirty since
    // the previous loop iteration and call their redraw() method
    ui::MainLoop::redraw()
    // wait for user input. the input will be handled by the next
    // iteration of this loop
    ui::MainLoop::read_input()

