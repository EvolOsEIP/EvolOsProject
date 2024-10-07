#include "buttons/Button.hpp"

Button::Button(const std::string &label) : m_label(label) {
  std::cout << "[*] Button was created" << std::endl;

}

Button::~Button() {
  std::cout << "[*] Button was destroyed" << std::endl;
}
