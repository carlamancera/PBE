require 'i2c/drivers/lcd'
require 'gtk3'

app = Gtk::Application.new("org.gtk.example", :flags_none)
display = I2C::Drivers::LCD::Display.new('/dev/i2c-1', 0x27, cols=20, rows=4)

app.signal_connect "activate" do |application|
  window = Gtk::ApplicationWindow.new(application)
  window.set_title("Puzzle 2")
  window.set_default_size(300, 50)

  box = Gtk::Box.new(:vertical, 100)
  window.add(vbox)

  titol = Gtk::Label.new("Escribe algo para verlo en la LCD :)")
  box.pack_start(titol, :expand => false, :fill => true, :padding => 2)

  entry = Gtk::Entry.new
  entry.set_size_request(200, 200)
  entry.placeholder_text = "Escribe aquí"
  box.pack_start(entry, :expand => true, :fill => true, :padding => 2)

  button_box = Gtk::ButtonBox.new(:horizontal)
  button = Gtk::Button.new(label: "Display")
  button_box.add(button)
  button.signal_connect "clicked" do
	puts 
# Enviem el missatge a la LCD
		display.clear
		display.text(entry.text, 0)
# Per estètica, quan es fa click al botó display, es borra el contingut escrit anteriorment
		entry.set_text("")
  end
  box.pack_start(button_box, :expand =>false, :fill => true, :padding => 2)
  
  window.show_all

  window.signal_connect("destroy") do
	window.destroy
  end

end

# Gtk::Application#run need C style argv ([prog, arg1, arg2, ...,argn]).
# The ARGV ruby variable only contains the arguments ([arg1, arg2, ...,argb])
# and not the program name. We have to add it explicitly.

puts app.run([$0] + ARGV)
