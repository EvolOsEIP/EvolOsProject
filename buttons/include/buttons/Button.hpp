#pragma once

#include <gtkmm.h>
#include <iostream>
#include <string>

class Button
{
  public:
    Button(const std::string &label, const std::string &url);
    Button(Gtk::Button *button);
    virtual ~Button();

    virtual void onClick();
    virtual void render() const;

  protected:
    void on_button_clicked();
    std::string m_label;
    std::string m_url;
    Gtk::Button *m_button;
};

