# Haskell Project

This course is given in portuguese

## Enunciado

Uma técnica em aprendizado de máquina é chamada de classificação semi-supervisionada. 
Alguns dados recebem um label (uma classe) e varios dados não. 
O objetivo é atribuir uma classe/label para cada um dos dados sem classe.

Faremos esta atribuição por proximidade - se um dado X sem label esta mais proximo de um dado do label A que de qualquer outro dado com label, ele assume o label A.
Mas agora X é um dado com label e ele vai propagar seu label para o dado mais proximo sem label (que nao esta ainda mais proximo de outro dado com outro label).

O algoritmo que usaremos é

   - separar os pontos com e sem label
   - calcular a distancia entre os pontos dos 2 grupos
   - selecionar o ponto do grupo sem classe mais proximo de algum do grupo com classe
   - atribuir a classe a este ponto e atualizar os 2 grupos
   - repetir

Este algoritmo é cubico no pior caso.

###Exemplo

Input:
```
aa 0 0 0
b3  0 1 0
ez34 30 40 40
```
Output:
```
1 aa b3 
2 ez34 
```
 

## Autores
* **Lucas Koiti**
* **Esdras Rodrigues**
