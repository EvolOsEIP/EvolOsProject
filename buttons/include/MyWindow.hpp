#pragma once
#include <iostream>
#include <string>
#include <gtkmm.h>
#include <gtkmm/builder.h>
#include <memory>

#include "buttons/Button.hpp"
#include "buttons/CTAButton.hpp"

#define APP_NAME "org.evolosCTA.application"


class MyWindow : public Gtk::Window {
  public:
      MyWindow(BaseObjectType* cobject, const Glib::RefPtr<Gtk::Builder>& refGlade);
      virtual ~MyWindow();

      void on_button_clicked();
  protected:
      std::shared_ptr<CTAButton> m_button;
};

