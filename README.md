# Analizador Sintáctico JSON

Este proyecto es el trabajo final para el curso de compiladores, y consiste en un analizador sintáctico de JSON desarrollado utilizando Yacc (Bison) y Lex (Flex).

## Descripción
El analizador sintáctico JSON tiene como objetivo interpretar y validar archivos JSON, asegurando que cumplan con la sintaxis estándar. El proyecto incluye tanto el archivo de especificaciones de análisis léxico como el de análisis sintáctico.

## Características
- **Análisis Léxico** : Utiliza Flex para definir las reglas léxicas y generar tokens para elementos JSON como objetos, arreglos, cadenas, números, etc.
- **Análisis Sintáctico**: Emplea Bison para construir un árbol de análisis basado en la gramática JSON y validar la estructura del documento.
- **Mensajes de Error Detallados**: Proporciona retroalimentación clara sobre errores de sintaxis para facilitar la identificación de la misma.

## Requisitos 
Antes de compilar el proyecto, asegúrate de tener instalados los siguientes paquetes en tu sistema:

- [**Flex**](source/flex-2.5.4.exe): Herramienta para generación de analizadores léxicos.
- [**Bison**](source/bison-2.4.1.exe): Herramienta para generación de analizadores sintácticos.
- [**MinGW**](https://sourceforge.net/projects/mingw/): Compilador de C. (gcc v6.3.0-1 versión usada en este proyecto)

Configurar en la variable de entorno PATH : 
- C:\GnuWin32\bin
- C:\MinGW\bin


## Instrucciones de Compilación

#### 1. Generación del Analizador Sintáctico con Bison
```bash
bison -d json_parser.y
```
`bison`: Es la herramienta que convierte las gramáticas especificadas en el archivo .y en un analizador sintáctico en C.

`d` : Esto indica a Bison que genere un archivo de encabezado (json_parser.tab.h) que contiene definiciones para los tokens.

`json_parser.y` : Es el archivo de entrada que contiene las reglas de la gramática para el analizador sintáctico.

#### 2. Generación del Analizador Léxico con Flex
```bash
flex json_lexer.l
```
`flex`: Es la herramienta que convierte las reglas léxicas especificadas en el archivo .l en un analizador léxico en C.

`json_lexer.l` : Es el archivo de entrada que contiene las reglas para el analizador léxico.

#### 3. Compilación y Enlace con GCC
```bash
gcc -o json_parser json_parser.tab.c lex.yy.c -lfl
```
`gcc`: Es el compilador de C.

`-o json_parser` :  Indica que el nombre del ejecutable generado será json_parser.

`json_parser.tab.c` :  Es el archivo de código C generado por Bison.

`lex.yy.c` :  Es el archivo de código C generado por Flex.

`-lfl` :  Indica al enlazador que utilice la biblioteca fl, que es la biblioteca Flex, necesaria para resolver dependencias del analizador léxico.

## Bibliotecas auxiliares

**M4** es un preprocesador de macros ampliamente utilizado en sistemas Unix y Linux. Es una herramienta que procesa archivos de texto, reemplazando macros y realizando otras transformaciones antes de que el archivo se procese con otras herramientas. En el contexto de bison, m4 se utiliza para generar código a partir de definiciones de gramática.


## Solución de posibles errores
Si ocurre problemas con M4 :
- Instalar m4 con sed-4.2.1-setup en C:\GnuWin32

Si ocurre problemas con -lfl:

Probablemente se encuentre en C:\GnuWin32\lib y GCC no lo reconoce, para solucionar esto debemos asegurarnos que el enlazador MinGW pueda encontrar esta biblioteca.
- Agregar el Directorio de Bibliotecas a LIBRARY_PATH desde CMD
    ```bash
    set LIBRARY_PATH=%LIBRARY_PATH%;C:\GnuWin32\lib
    ```
- Verificar que el Directorio está en LIBRARY_PATH
    ```bash
    echo %LIBRARY_PATH%
    ```
- Actualizar la Variable PATH
    ```bash
    set PATH=%PATH%;C:\GnuWin32\bin
    ```
- Opcional***

    Abre la terminal de MinGW o MSYS y exporta la ruta a la biblioteca flex:
    ```bash
    export LIBRARY_PATH=$LIBRARY_PATH:/c/MinGW/lib
    ```