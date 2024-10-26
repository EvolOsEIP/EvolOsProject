#include "MyWindow.hpp"

MyWindow::MyWindow(BaseObjectType* cobject, const Glib::RefPtr<Gtk::Builder>& refBuilder)
  : Gtk::Window(cobject)
{
  // Get the GtkBuilder-instantiated Button, and connect a signal handler:
  BUTTON_CLASS* pButton = nullptr;
  refBuilder->get_widget(WIDGET_NAME, pButton);
  if(pButton) {
    std::cout << "Found button: " << WIDGET_NAME << std::endl;
  }

  m_button = std::make_shared<BUTTON_TYPE>(pButton);

  show_all();
}

MyWindow::~MyWindow()
{
  std::cout << "Destroying MyWindow" << std::endl;
}
