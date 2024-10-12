#pragma once

#include <gtkmm.h>
#include <iostream>
#include <string>

#define CTA_BUTTON_UI_FILE "../ui/CTAButton.ui"

class Button
{
  public:
    Button(const std::string &label, const std::string &url);
    Button(Gtk::Button *button);
    virtual ~Button();

    virtual void init() = 0;
    virtual void onClick();
    virtual void render() const;

    void applyStyle(const std::string &cssFilename);

  protected:
    void on_button_clicked();
    std::string m_label;
    std::string m_url;
    Gtk::Button *m_button;
};

