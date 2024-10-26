#pragma once

#include "Button.hpp"
#include <memory>

#define TOGGLE_BUTTON_STYLE "../ui/css/ToggleButton.css"

class ToggleButton : public Button
{
  public:
    ToggleButton(const std::string &text, const std::string &url);
    ToggleButton(Gtk::Switch *button);

    virtual ~ToggleButton();

    void init();
    void render() const override;
    void onClick() override;
  private:
};

