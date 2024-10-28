#pragma once

#include <gtkmm.h>
#include <iostream>
#include <string>

#define CTA_BUTTON_UI_FILE "../ui/CTAButton.glade"
#define TOGGLE_BUTTON_UI_FILE "../ui/ToggleButton.glade"
#define FLOATING_BUTTON_UI_FILE "../ui/FloatingButton.glade"

#ifdef TOGGLE_BUTTON
    #define BUTTON_CLASS Gtk::Switch
#elif defined(NORMAL_BUTTON)
    #define BUTTON_CLASS Gtk::Button
#endif

class Button
{
  public:
    Button(const std::string &label, const std::string &url);
    Button(BUTTON_CLASS *button);
    virtual ~Button();

    virtual void init() = 0;
    virtual void onClick();
    virtual void render() const;

    void applyStyle(const std::string &cssFilename);

  protected:
    void on_button_clicked();
    std::string m_label;
    std::string m_url;
    BUTTON_CLASS *m_button;
};

