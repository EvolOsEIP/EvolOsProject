#include "buttons/CTAButton.hpp"

CTAButton::CTAButton(const std::string &text, const std::string &url) : Button(text, url)
{
  this->init();
}

CTAButton::CTAButton(Gtk::Button *button) : Button(button)
{
  // Connect the signal handler
  m_button->signal_clicked().connect(sigc::mem_fun(*this, &CTAButton::onClick));
  this->init();
}

void CTAButton::init()
{
  std::cout << "CTAButton initialized" << std::endl;
  this->applyStyle(CTA_BUTTON_STYLE);
}

void CTAButton::render() const
{
    std::cout << "Rendering CTAButton" << std::endl;
}

void CTAButton::onClick()
{
  std::cout << "CTAButton clicked" << std::endl;
}
