#include "MyWindow.hpp"

MyWindow::MyWindow(BaseObjectType* cobject, const Glib::RefPtr<Gtk::Builder>& refBuilder)
  : Gtk::Window(cobject)
{
  // Get the GtkBuilder-instantiated Button, and connect a signal handler:
  Gtk::Button* pButton = nullptr;
  refBuilder->get_widget("cta_button", pButton);
  if(pButton) {
    std::cout << "Found button1" << std::endl;
  }

  m_button = std::make_shared<CTAButton>(pButton);

  show_all();
}

MyWindow::~MyWindow()
{
  std::cout << "Destroying MyWindow" << std::endl;
}
