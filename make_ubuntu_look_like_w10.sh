#!/bin/bash
#Revisar repo gnome-layout-manager

echo Este script debe ser ejecutado como usuario no root en sesión gráfica.
read -p "Pulsa Intro para continuar..." nulo

echo Instalamos las siguientes extensiones de gnome-shell:
echo - dash-to-panel: https://github.com/home-sweet-gnome/dash-to-panel 1160
echo - Remove alt tab delay v2: https://github.com/bdaase/remove-alt-tab-delay  2741
echo - Start Overlay in Application View: https://github.com/Hexcz/Start-Overlay-in-Application-View-for-Gnome-40- 5040

wget -O gnome-shell-extension-installer "https://github.com/brunelli/gnome-shell-extension-installer/raw/master/gnome-shell-extension-installer"
chmod +x gnome-shell-extension-installer
./gnome-shell-extension-installer 1160 2741 5040

#killall -3 gnome-shell
#echo Esperamos a que se reinicie gnome-shell
#sleep 10

echo Activamos las extensiones
gnome-extensions enable dash-to-panel@jderose9.github.com
gnome-extensions enable remove-alt-tab-delay@daase.net
gnome-extensions enable start-overlay-in-application-view@Hex_cz

echo Forzamos la recarga de las extensiones
gsettings set org.gnome.shell disable-user-extensions false
gsettings set org.gnome.shell disable-user-extensions true

echo Preparamos los schemas de las extensiones para gsettings
mkdir -p ~/.local/share/glib-2.0/schemas/
find ~/.local/share/gnome-shell/extensions/ -name *gschema.xml -exec ln {} -sfn ~/.local/share/glib-2.0/schemas/ \;
glib-compile-schemas ~/.local/share/glib-2.0/schemas/

echo == Gnome - Windows 10 Dark mode
#NO FUNCIONA gsettings set org.gnome.shell.extensions.user-theme name 'Yaru-purple-dark'

echo - Número de escritorios virtuales: 1
gsettings set org.gnome.mutter dynamic-workspaces false
gsettings set org.gnome.desktop.wm.preferences num-workspaces 1

echo - Posición de los iconos nuevos - Superior izquierda
gsettings set org.gnome.shell.extensions.ding start-corner 'top-left'

echo - Tamaño de los iconos del escritorio - Pequeño
gsettings set org.gnome.shell.extensions.ding icon-size 'small'

echo - Barra abajo
#INNECESARIO gsettings set org.gnome.shell.extensions.dash-to-dock dock-position 'BOTTOM'

echo - Animación al pasar sobre los iconos
gsettings set org.gnome.shell.extensions.dash-to-panel animate-appicon-hover true

echo - Iconos Yaru-purple
gsettings set org.gnome.desktop.interface icon-theme 'Yaru-purple'

echo - Gnome Shell Estilo oscuro: Yaru-purple-dark / Tono preferido: Morado
gsettings set org.gnome.desktop.interface gtk-theme 'Yaru-purple-dark'

echo - Cursor blanco
gsettings set org.gnome.desktop.interface cursor-theme "Adwaita"

echo - Dark mode:
gsettings set org.gnome.desktop.interface color-scheme 'prefer-dark'

echo - Barra superior/Reloj: Sin fecha, ni segundos
gsettings set org.gnome.desktop.interface clock-show-date false

echo Tipografías:
echo - Texto de la interfaz: Ubuntu Regular 10
gsettings set org.gnome.desktop.interface font-name 'Ubuntu 10'

echo - Texto del documento: Sans Regular 10
gsettings set org.gnome.desktop.interface document-font-name 'Sans 10'

echo - Texto monoespaciado: Ubuntu Mono Regular 12
gsettings set org.gnome.desktop.interface monospace-font-name 'Ubuntu Mono 12'

echo - Títulos de ventanas heredadas: Ubuntu Bold 9
gsettings set org.gnome.desktop.wm.preferences titlebar-font 'Ubuntu Bold 9'

echo Dash to panel
echo - Estilo / Relleno de los iconos: 6
gsettings set org.gnome.shell.extensions.dash-to-panel appicon-padding 6

echo - Margen de los iconos 4
gsettings set org.gnome.shell.extensions.dash-to-panel appicon-margin 4

echo - Vista rápida de ventanas: Tamaño por defecto 180
gsettings set org.gnome.shell.extensions.dash-to-panel window-preview-size 180

echo - Usar atajos de teclado para activar aplicaciones
# INNECESARIO

echo - Ocultar overview al iniciar
gsettings set org.gnome.shell.extensions.dash-to-panel hide-overview-on-startup true

echo - Otros:
echo Mostrar papelera de reciclaje
gsettings set org.gnome.shell.extensions.ding show-trash true

echo - Posición de la fecha: Debajo de sistema
echo no hay forma de automatizarlo!!
gnome-extensions prefs dash-to-panel@jderose9.github.com