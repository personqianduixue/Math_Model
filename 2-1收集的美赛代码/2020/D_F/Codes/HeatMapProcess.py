import Image



background = Image.open("test1.png")

foreground = Image.open("test2.png")



background.paste(foreground, (0, 0), foreground)

background.show()