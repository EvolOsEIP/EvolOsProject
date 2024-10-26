#include "buttons/ToggleButton.hpp"

ToggleButton::ToggleButton(const std::string &text, const std::string &url) : Button(text, url)
{
  this->init();
}

ToggleButton::ToggleButton(Gtk::Switch *button) : Button(button)
{
  this->init();
}

ToggleButton::~ToggleButton()
{
}

void ToggleButton::init()
{
  std::cout << "ToggleButton::init()" << std::endl;
  this->applyStyle(TOGGLE_BUTTON_STYLE);
}

void ToggleButton::render() const
{
}

void ToggleButton::onClick()
{
}

