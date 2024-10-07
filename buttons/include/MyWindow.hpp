#pragma once
#include <iostream>
#include <string>
#include <gtkmm.h>

#include "buttons/Button.hpp"

#define APP_NAME "org.evolosCTA.application"

class MyWindow : public Gtk::ApplicationWindow {
  public:
      MyWindow();
      virtual ~MyWindow();

      void on_button_clicked();
  protected:

      // add  a button
      Button m_button;

};
