#pragma once

#include "Button.hpp"
#include <memory>

class CTAButton : public Button
{
  public:
      CTAButton(const std::string& text, const std::string& url);
      CTAButton(Gtk::Button *button);

      virtual ~CTAButton() = default;

      void render() const override;
      void onClick() override;

  private:
};
