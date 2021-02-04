#include "build/rmkit.h"

#include "scenes.h"

using namespace std

HOME_DIR := "/home/root"
int main()
  fb := framebuffer::get()
  fb->clear_screen()
  fb->redraw_screen()

  input_scene := prep_input_scene()

  chdir(HOME_DIR)

  ui::MainLoop::set_scene(input_scene)

  while true:
    ui::MainLoop::main()
    ui::MainLoop::redraw()
    ui::MainLoop::read_input()

