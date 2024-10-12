#include "buttons/CTAButton.hpp"

CTAButton::CTAButton(const std::string &text, const std::string &url) : Button(text, url)
{
  std::cout << "Creating CTAButton" << std::endl;
  std::cout << "Text: " << m_label << std::endl;
  std::cout << "URL: " << m_url << std::endl;
}

CTAButton::CTAButton(Gtk::Button *button) : Button(button)
{
  std::cout << "Creating CTAButton" << std::endl;
  std::cout << "Text: " << m_label << std::endl;
  std::cout << "URL: " << m_url << std::endl;

  // Connect the signal handler
  m_button->signal_clicked().connect(sigc::mem_fun(*this, &CTAButton::onClick));
}

void CTAButton::render() const
{
    std::cout << "Rendering CTAButton" << std::endl;
}

void CTAButton::onClick()
{
  std::cout << "CTAButton clicked" << std::endl;
}
