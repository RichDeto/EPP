library(hexSticker) # https://github.com/GuangchuangYu/hexSticker
library(rsvg)
# add special text font
library(sysfonts)
font.families.google()
font_add_google(name = "Gochi Hand", family = "gochi")
font_add_google(name = "Sanchez")

### Black and light blue logo ---------------

### .png
sticker("./man/figures/logo_text.svg", package = "",
        h_color = "#74a9cf", s_x = 1, s_y = 1,
        s_width = .9, s_height = 1.8,
        h_fill = "#74a9cf", url = "https://github.com/RichDeto/EPP", u_color = "black",
        u_size = 5, filename = "./man/figures/epp_logo.png", dpi = 400)
        
### .svg
sticker("./man/figures/logo_text.svg", package = "",
        h_color = "#74a9cf", s_x = 1, s_y = 1,
        s_width = .9, s_height = 1.8,
        h_fill = "#74a9cf", url = "https://github.com/RichDeto/EPP", u_color = "black",
        u_size = 5,
        filename = "./man/figures/epp_logo.svg")  # output name and resolution


### .png
sticker("./man/figures/logo_text_b.svg", package = "",
        s_x = 1, s_y = 1,
        s_width = .9, s_height = 1.8, u_size = 5,
        h_fill = "black", h_color = "black", # hexagon
        url = "https://github.com/RichDeto/EPP", u_color = "#4dc0d1",
        filename = "./man/figures/epp_logo_b.png", dpi = 400)  # output name and resolution


### .svg
sticker("./man/figures/logo_text_b.svg", package = "",
        s_x = 1, s_y = 1,
        s_width = .9, s_height = 1.8, u_size = 5,
        h_fill = "black", h_color = "black", # hexagon
        url = "https://github.com/RichDeto/EPP", u_color = "#4dc0d1",
        filename = "./man/figures/epp_logo_b.svg")  # output name and resolution
