require 'i2c/drivers/lcd'

#Después de consultar en que pin se encontraba el LCD, lo definimos como constante.
LCD_ADDRESS = 0x27 

#Inicializamos la clase display que usaremos para escribir en el LCD, a partir de los módulos donde se encuentra
display = I2C::Drivers::LCD::Display.new('/dev/i2c-1', LCD_ADDRESS, cols = 20, rows = 4)

#Limpiamos la pantalla
display.clear

#Escribimos en las filas 0 y 1 lo siguiente:
display.text("Hello", 0)
display.text("How are you?", 1)
