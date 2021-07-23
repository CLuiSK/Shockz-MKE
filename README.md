# Shockz MKE

Shockz MKE es mi entorno de trabajo profesional enfocado al pentesting y Capture The Flag. Este cuenta con varias utilidades como una estilo personalizado del prompt con powerlevel10k, una diversas barras superiores con ciertas funcionalidad útiles gracias a polybar, etc. Además contiene configuraciones personales, scripts, diccionarios, atajos y herramientas necesarias en caso de ser instalado el máquinas virtuales.

Sientete libre de aprovechar mis scripts o archivos de configuración.

Recuerda que esta hecho para que funcione para mi user especifico así que si quieres usarlo para ti tendrás que editar muchos archivos.

## Testeado en las siguientes distribuciones de Linux:
- Kali Linux 2021.2
- Kali Linux 2020.4

### Características que empleo en mis Kali VM's

* **CPU**
    * 2 Cores y 2 Threads/core
* **RAM**
    * 6GB
* **VHD**
    * 80 GB
* **Particiones**
    * /home = 40 GB
    * / = 30 GB
    * /var = 5 GB
    * /swap = 4 GB
    * /temp = 1 GB

## Instalación:
> Se recomienda hacer la instalación en una nueva ISO. Si esto no es posible, es decir, si está usando una máquina virtual usada, clonada o preconfigurada, recomiendo hacer una snapshot (instántanea) del estado actual de la máquina, debido a que puede generar problemas y/o conflictos en el transcurso de la instalación. La solución a esto está fuera de mi alcance.


**1)** Cambiamos al usuario root
```
sudo su
```
**2)** Clonamos el repositorio, damos permisos de ejecución al archivo install.sh y lo ejecutamos

```
git clone https://github.com/jmlgomez73/Shockz-MKE && cd Shockz-MKE && chmod +x install.sh && ./install.sh
```

## Vista general
<p align="center"><img src='img/general.png'></p>


## Utilidades:
- **bspwm**: Tiling Window Manager (administrador de ventanas en mosaico). Autor: [baskerville](https://github.com/baskerville)
- **zsh**: Shell.
- **powerlevel10k**: Tema de la zsh. Autor: [romkatv](https://github.com/romkatv)
- **sxhkd**: Es un "demonio" que escucha los eventos del teclado y ejecuta comandos. Autor: [baskerville](https://github.com/baskerville)
- **polybar**: Herramienta rápida y fácil de usar para crear barras de estado.
- **polybar-themes**: Temas para la polybar. Autor: [adi1090x](https://github.com/adi1090x)
- **compton**: Es un compositor para X y una bifurcación de xcompmgr-dana. Autor: [chjj](https://github.com/chjj)
- **rofi**: Selector de ventana y lanzador de aplicaciones.
- **feh**: Visor de imágenes ligero, configurable y versátil.
- **Hack Nerd Font**: Fuente.
- **fzf**: Buscador difuso de línea de comandos de propósito general. Autor: [junegunn](https://github.com/junegunn)

## Shortcuts (atajos de teclado)

<kbd>Windows</kbd> + <kbd>Enter</kbd> : Abrir la consola (gnome-terminal).  
<kbd>Windows</kbd> + <kbd>W</kbd> : Cerrar la ventana actual.
<kbd>Windows</kbd> + <kbd>Alt</kbd> + <kbd>R</kbd> : Reiniciar la configuración del bspwm.  
<kbd>Windows</kbd> + <kbd>Alt</kbd> + <kbd>Q</kbd> : Cerrar sesión.  
<kbd>Windows</kbd> + <kbd>(⬆⬅⬇➡)</kbd> : Moverse por las ventanas en la workspace actual.  
<kbd>Windows</kbd> + <kbd>D</kbd> : Abrir el Rofi. <kbd>Esc</kbd> para salir.
<kbd>Windows</kbd> + <kbd>D</kbd> + escribir ```thunar```: Abrir explorador de archivos.
<kbd>Windows</kbd> + <kbd>(1,2,3,4,5,6,7,8,9,0)</kbd> : Cambiar el workspace.
<kbd>Windows</kbd> + <kbd>T</kbd> : Cambiar la ventana actual a modo "terminal" (normal). Nos sirve cuando la ventana está en modo pantalla completa o flotante.  
<kbd>Windows</kbd> + <kbd>M</kbd> : Cambiar la ventana actual a modo "completo" (no ocupa la polybar). Presione la mismas teclas para volver a modo "terminal" (normal).  
<kbd>Windows</kbd> + <kbd>F</kbd> : Cambiar la ventana actual a modo pantalla completa (ocupa todo incluyendo la polybar).  
<kbd>Windows</kbd> + <kbd>S</kbd> : Cambiar la ventana actual a modo "flotante".  
<kbd>Windows</kbd> + <kbd>Alt</kbd> + <kbd>(1,2,3,4,5,6,7,8,9,0)</kbd> : Mover la ventana actual a otro workspace.  
<kbd>Windows</kbd> + <kbd>Alt</kbd> + <kbd>(⬆⬅⬇➡)</kbd> : Cambiar el tamaño de la ventana actual (solo funciona si está en modo terminal o flotante).  
<kbd>Windows</kbd> + <kbd>Ctrl</kbd> + <kbd>(⬆⬅⬇➡)</kbd> : Cambiar la posición de la ventana actual (solo funciona en modo flotante).  
<kbd>Windows</kbd> + <kbd>Shift</kbd> + <kbd>G</kbd> : Abrir Google Chrome (es necesario instalarlo primero).  
<kbd>Windows</kbd> + <kbd>Ctrl</kbd> + <kbd>Alt</kbd> + <kbd>(⬆⬅⬇➡)</kbd> : Mostrar una preselección para luego abrir una ventana (una terminal, Google Chrome, un archivo, etc.). 
<kbd>Windows</kbd> + <kbd>Ctrl</kbd> + <kbd>Space</kbd> para deshacer la preselección.  

#### Atajos zsh

<kbd>Ctrl</kbd> + <kbd>A</kbd> : Principio de línea
<kbd>Ctrl</kbd> + <kbd>E</kbd> : final de línea
<kbd>Ctrl</kbd> + <kbd>L</kbd> :  Limpiar consola
<kbd>Alt</kbd> + <kbd>Q</kbd> :  Borra toda la línea
<kbd>Alt</kbd> + <kbd>Backspace</kbd> : Elimina la palabra anterior al cursor
<kbd>Alt</kbd> + <kbd>D</kbd> :  Elimina la palabra posterior al cursor
<kbd>Ctrl</kbd> + <kbd>K</kbd> :  Elimina todo lo que hay detrás del cursor
<kbd>Ctrl</kbd> + <kbd>D</kbd> :  Funciona igual que la tecla suprimir
<kbd>Ctrl</kbd> + <kbd>U</kbd> :  Elimina la línea entera y la guarda en el framebuffer
<kbd>Ctrl</kbd> + <kbd>Y</kbd> :  Pega el frambuffer

## Funcionalidades y Atajos

### Desplegar varias opciones a elegir entre los archivos del directorio actual 
```rm **``` + <kbd>Tab</kbd>

### Autocompletador inteligente de rutas
Si escribimos ```cd /u/s/w``` => al tabular se modifica a ```cd /usr/share/wordlists```

### Búsqueda inteligente de archivos y directorios
<kbd>Ctrl</kbd> + <kbd>T</kbd>

### Búsqueda en el historico de comandos
<kbd>Ctrl</kbd> + <kbd>R</kbd>

### Listado largo mostrando archivos ocultos

```la```
### Creacion de una escructura de directorios ideal para tests de instrusiones (Pentest/CTF's)

```mkt```
### Eliminación profunda de archivos

```rmk```
### Establecer una IP como objetivo

```settarget <IP>```
### Limpiar la IP establecida como objetivo

```cleartarget```
### Autocompleatador de sudo
Escribimos un comando y al presionar <kbd>Esc</kbd> + <kbd>Esc</kbd> , apareceria delante del comando "sudo"

### Navegador visual del explorador de archivos

```ranger```

### Poner un puerto a la escucha y obtener una reverse shell, posteriormente conseguir acto seguido una shell TTY 100% interactiva

```tty <port>```

#





> Ten en cuenta que cuando nos referimos a la tecla <kbd>Windows</kbd>, esta puede cambiar dependiendo del pointer_modifier seleccionado, que se encuentra en el archivo ~/.config/bspwm/bspwmrc

## Configuración manual:
- Editar el código a gusto

## Autor
- Jorge Manuel Lozano Gómez