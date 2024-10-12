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

void Button::applyStyle(const std::string &cssFilename)
{
  auto css = Gtk::CssProvider::create();

  try {
    css->load_from_path(cssFilename);
    std::cout << "[*] CSS file was loaded" << std::endl;
  } catch (const Gtk::CssProviderError &e) {
    std::cerr << "Error loading CSS file: " << e.what() << std::endl;
  } catch (const Glib::FileError &e) {
    std::cerr << "Error loading CSS file: " << e.what() << std::endl;
  }

  auto screen = Gdk::Screen::get_default();
  auto context = m_button->get_style_context();
  context->add_provider(css, GTK_STYLE_PROVIDER_PRIORITY_USER);
  std::cout << "[*] Button was styled" << std::endl;
}

Button::~Button() {
  std::cout << "[*] Button was destroyed" << std::endl;
}
