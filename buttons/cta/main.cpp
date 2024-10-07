#include "MyWindow.hpp"

int main(int ac, char **av)
{
  auto app = Gtk::Application::create(ac, av, APP_NAME);

  MyWindow window;
  return app->run(window);
}
