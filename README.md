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

- **Flex**: Herramienta para generación de analizadores léxicos.
- **Bison**: Herramienta para generación de analizadores sintácticos.
- **gcc**: Compilador de C.

Configurar en la variable de entorno PATH : 
- C:\GnuWin32\bin


## Instrucciones de Compilación

```bash
bison -d json_parser.y
flex json_lexer.l
gcc -o json_parser json_parser.tab.c lex.yy.c -lfl
```
-d : Esto indica que Bison debe generar el archivo de encabezado

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