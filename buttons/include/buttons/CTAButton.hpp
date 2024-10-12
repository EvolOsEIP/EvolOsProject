#pragma once

#include "Button.hpp"
#include <memory>

#define CTA_BUTTON_STYLE "../ui/css/CTAButton.css"

class CTAButton : public Button
{
  public:
      CTAButton(const std::string& text, const std::string& url);
      CTAButton(Gtk::Button *button);

      virtual ~CTAButton() = default;

      void init();
      void render() const override;
      void onClick() override;

  private:
};
