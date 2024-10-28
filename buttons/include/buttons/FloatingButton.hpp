#pragma once

#include "Button.hpp"

#define FLOATING_BUTTON_STYLE "../ui/css/FloatingButton.css"

class FloatingButton : public Button
{
  public:
    FloatingButton(const std::string &text, const std::string &url);
    FloatingButton(Gtk::Button *button);

    virtual ~FloatingButton() = default;

    void init();
    void render() const override;
    void onClick() override;
  private:
};
