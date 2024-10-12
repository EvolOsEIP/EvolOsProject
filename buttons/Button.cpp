#include "buttons/Button.hpp"

Button::Button(const std::string &label, const std::string &url) : m_label(label), m_url(url)
{
  std::cout << "[*] Button was created" << std::endl;
}

Button::Button(Gtk::Button *button) : m_button(button)
{
  std::cout << "[*] Button was created" << std::endl;
}

void Button::onClick()
{
  std::cout << "[*] Button was clicked" << std::endl;
}

void Button::render() const
{
  std::cout << "[*] Button was rendered" << std::endl;
}

Button::~Button() {
  std::cout << "[*] Button was destroyed" << std::endl;
}
