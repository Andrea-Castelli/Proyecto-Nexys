# Proyecto-Nexys
GENERADOR GAMA DE COLORES
*********************************************************************************************************************************************************************************

El proyecto realizado en este repositorio consiste en la generación de una gama de colores con el LED RGB de la placa Nexys. Esto se consigue controlando los tres canales del LED de forma independiente, aumentando y disminuyendo la luminosidad con un botón de aumento y uno de disminución. El número resultante de esta operación servirá para determinar el ciclo de trabajo de un PWM, de cuyo módulo se obtendrá la salida de cada canal, en forma de color rojo, verde o azul. Cada uno de los canales proporcionará 16 colores distintos, de manera que el color resultante entre en una gama de 4096 colores.

Los canales, a su vez, se seleccionan a partir de una combinación de dos interruptores. 
