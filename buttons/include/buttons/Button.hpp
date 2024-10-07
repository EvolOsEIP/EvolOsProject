#pragma once

#include <gtkmm.h>
#include <iostream>
#include <string>

class Button : public Gtk::Button
{
  public:
    Button(const std::string &label);
    virtual ~Button();

  protected:
    void on_button_clicked();
    Gtk::Button m_button;
    std::string m_label;
};
