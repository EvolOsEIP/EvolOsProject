#include "MyWindow.hpp"

int main(int ac, char **av)
{
  auto app = Gtk::Application::create(ac, av, APP_NAME);
  Glib::RefPtr<Gtk::Builder> builder = Gtk::Builder::create();

  try {
    std::cout << "Loading UI file: " << CTA_BUTTON_UI_FILE << std::endl;
    builder->add_from_file(CTA_BUTTON_UI_FILE);
  } catch (const Glib::FileError& ex) {
    std::cerr << "FileError: " << ex.what() << std::endl;
    return 1;
  } catch (const Glib::MarkupError& ex) {
    std::cerr << "MarkupError: " << ex.what() << std::endl;
    return 1;
  } catch (const Gtk::BuilderError& ex) {
    std::cerr << "BuilderError: " << ex.what() << std::endl;
    return 1;
  }

  MyWindow *window = nullptr;
  builder->get_widget_derived("example_window", window);
  if (!window) {
    std::cerr << "Could not get window" << std::endl;
    return 1;
  }
  std::cout << "Window created" << std::endl;

  return app->run(*window);
}
