#include "build/rmkit.h"

#include "scenes.h"

using namespace std

int main()
  // get the framebuffer
  fb := framebuffer::get()
  // clear the framebuffer using a white rect
  fb->clear_screen()

  input_scene := prep_input_scene()

  // set the scene
  ui::MainLoop::set_scene(input_scene)

  while true:
    // main() dispatches user input handlers, runs tasks in the task queue and so on
    ui::MainLoop::main()

    // goes through all widgets that were marked as dirty since
    // the previous loop iteration and call their redraw() method
    ui::MainLoop::redraw()
    // wait for user input. the input will be handled by the next
    // iteration of this loop
    ui::MainLoop::read_input()

