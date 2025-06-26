# Grupo

Nombre: **COMPLETAR ACA**

Integrantes: **COMPLETAR ACA**

# Consigna TP Integrador

Hacer un juego aplicando los conceptos de la materia. El tp tiene una parte práctica, que es programar el juego en sí, y una parte teórica, que es justificar decisiones que hayan tomado y mencionar para resolver qué problemas utilizaron los conceptos de la materia.
El TP debe:
- aplicar los conceptos que vemos durante la materia.
- tener tests para las funcionalidades que definan.
- evitar la repetición de lógica.

# Como correrlo

Con la extensión de VSCode, pararse sobre el program y correr `Run Game`

![image](https://github.com/user-attachments/assets/532b04d4-dca8-4887-aa47-a3c631b42568)


# Entregas

Van a haber varios checkpoints presenciales en los cuales vamos a ver el estado del tp, dar correcciones y junto con ustedes decidir en qué continuar trabajando.
Los checkpoints presenciales están en la página: https://www.pdep.com.ar/cursos/lunes-tarde

# Parte teórica

Les vamos a ir dando preguntas para cada checkpoint que **tienen que** dejar contestadas por escrito. Pueden directamente editar este README.md con sus respuestas:

--------------------

## Checkpoint 1: 23/9

a) Detectar un conjunto de objetos que sean polimórficos entre sí, aclarando cuál es la interfaz según la cuál son polimórficos, y _quién_ los trata de manera polimórfica.

Para detectar un conjunto de objetos que sean polimórficos entre sí, podemos observar que los objetos de dirección (arribaTecla, derechaTecla, izquierdaTecla, abajoTecla) son polimórficos entre sí porque todos tienen los métodos "imagen".

b) Tomar alguna clase definida en su programa y justificar por qué es una clase y no se definió con `object`.

Definimos "moneda" como clase debido a que las distintas modenas aparecen en distintas posiciones, entonces no podemos definirlo como un objeto.

c) De haber algún objeto definido con `object`, justificar por qué.

Sonic se define como un object porque representa una entidad unica en el juego.
Al ser un object, se asegura que solo exista una instancia de "sonic" en todo el programa, lo cual es adecuado para un personaje principal en un juego. 
