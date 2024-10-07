#include "MyWindow.hpp"

MyWindow::MyWindow() : m_button("Hello World")
{
  set_title("Hello World");
  set_default_size(400, 200);
  std::cout << "Initiating MyWindow" << std::endl;

  m_button.signal_clicked().connect(sigc::mem_fun(*this, &MyWindow::on_button_clicked));
  add(m_button);
  show_all();
}


void MyWindow::on_button_clicked()
{
  std::cout << "Hello World" << std::endl;
}

MyWindow::~MyWindow()
{
  std::cout << "Destroying MyWindow" << std::endl;
}
