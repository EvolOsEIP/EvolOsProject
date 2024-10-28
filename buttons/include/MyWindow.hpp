#pragma once

#include <iostream>
#include <string>
#include <gtkmm.h>
#include <gtkmm/builder.h>
#include <memory>

#include "buttons/Button.hpp"

#ifdef CTA_BUTTON
  #include "buttons/CTAButton.hpp"
  #define BUTTON_TYPE CTAButton
  #define WIDGET_NAME "cta_button"
#elif defined(TOGGLE_BUTTON)
  #include "buttons/ToggleButton.hpp"
  #define BUTTON_TYPE ToggleButton
  #define WIDGET_NAME "toggle_button"
#elif defined(FLOATING_BUTTON)
  #include "buttons/FloatingButton.hpp"
  #define BUTTON_TYPE FloatingButton
  #define WIDGET_NAME "floating_button"
#endif

#define APP_NAME "org.evolosCTA.application"


class MyWindow : public Gtk::Window {
  public:
      MyWindow(BaseObjectType* cobject, const Glib::RefPtr<Gtk::Builder>& refGlade);
      virtual ~MyWindow();

      void on_button_clicked();
  protected:
      std::shared_ptr<Button> m_button;
};

