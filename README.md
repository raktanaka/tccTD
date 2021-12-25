
# MAC0499 - TCC - Tower Defense (2021)

### Autor:
 - [Daniel Hotta](https://github.com/HiimHotta)
 - [Rafael Silva](https://github.com/RGPRafael)
 - [Ricardo Tanaka](https://github.com/raktanaka)


## Descrição

Esse repositório foi criado para armazenar um jogo feito em Godot para experimentos com Algoritmos Genéticos em Criação de Waves. Mais detalhes podem ser encontrados abaixo:

- O outro jogo criado para comparação (Space Shooter) pode ser encontrado [aqui](https://github.com/RGPRafael/godot/)

- O dataset com os resultados pode ser encontrado [aqui](https://github.com/raktanaka/tcc-results).


## Atribuições:

- Os assets utilizados são propriedade de [Kenney](https://www.kenney.nl/assets/tower-defense-top-down), utilizados sob [CC0](https://creativecommons.org/publicdomain/zero/1.0/) / Modificados do original.

- A playlist usada para a criação do jogo pode ser encontrada [aqui](https://www.youtube.com/watch?v=wFdpCGbrVXI&list=PLZ-54sd-DMAJltIzTtZ6ZhC-9hkqYXyp6).

- Os tutoriais usado para embasar a criação do algoritmo genéticos podem ser encontrados [aqui](https://towardsdatascience.com/genetic-algorithm-implementation-in-python-5ab67bb124a6) (de Ahmed Gad) e [aqui](https://towardsdatascience.com/introduction-to-genetic-algorithms-including-example-code-e396e98d8bf3) (de Vijini Mallawaarachchi)

## Função fitness e taxa de mutação:

A função de fitness e mutação tem grande importância na exploração das possíveis soluções do problema, a função fitness irá ditar quem são os indivíduos mais aptos de uma população (selecionar os melhores candidatos) enquanto a taxa de mutação permite que você explore as diversas combinações de indivíduos possíveis, evitando que fique preso em máximos locais nas primeiras interações.

## Versões

A diferença entre as versões está na taxa de mutação e na função *fitness*.


### v1

A Função fitness usada na v1 é:

    (reached_goal(x) + offset(x)) / 2
    
    reached_goal (x) := se o inimigo x chegou ao final do trajeto (1 se chegou, 0 caso contrário)
    offset(x) := quanto do trajeto o inimigo x percorreu.
    
Taxa de mutação que decrementa com o tempo (começa em 100% e decai 5% a cada iteração, até chegar em 0%)

O código pode ser encontrado [aqui](https://github.com/raktanaka/tccTD/blob/7a7de6b0a4ad35efba54f233dd4fb6e05f58962a/Singletons/AI.gd).

### v2

A Função fitness usada na v2 é:

    (hp(x) + offset(x)) / 2
    
    hp (x) := quanto de vida de x sobrou ao final do trajeto (float de 0 a 1, com 1 equivalente a 100%)
    offset(x) := quanto do trajeto o inimigo x percorreu.
    
Taxa de mutação fixa em 1/12 na 1a wave e 1 nas waves seguintes.

O código pode ser encontrado [aqui](https://github.com/raktanaka/tccTD/blob/3d3fd4361a5699e4d9f0f5b1332389fc418ba444/Elements/Enemy/Enemies.gd).


### v3 (Versão atual)

A função fitness é equivalente a v2 (anterior).

Taxa de mutação constante de 1/12.
