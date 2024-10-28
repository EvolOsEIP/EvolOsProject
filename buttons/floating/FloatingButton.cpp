#include "buttons/FloatingButton.hpp"

FloatingButton::FloatingButton(const std::string &text, const std::string &url) : Button(text, url)
{
  this->init();
}

FloatingButton::FloatingButton(Gtk::Button *button) : Button(button)
{
  this->init();
}

void FloatingButton::init()
{
}

void FloatingButton::render() const
{
}

void FloatingButton::onClick()
{
}


