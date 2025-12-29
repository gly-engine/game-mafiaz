# Mafia Z<br/>(game design document)

é um jogo de ação arcade para TV, com controles simples e duros, focado em pressão constante, decisões de risco e runs curtas. 

O jogador controla **um único mafioso armado com uma metralhadora**, enfrentando **ondas infinitas de zumbis** em uma rua que colapsa com o tempo.

O jogo não premia sobrevivência longa — **premia risco, ousadia e aceitação do caos**.

## Controles

os controles são simples pensado em uma progressão linear, sem obstaculos pelo cenário,
além dos zombies como uma barreira impossível de ultrapassar.

### Basicos 

 - direcional andar para frente
 - direcionar retroceder
 - botão de ação atirar
 - botão de ação recarregar
 - botão de ação coronhada
 - botão pressinado e direcional para correr para frente


### Combos (sams mode)

O modo de combo nada mais que atalhos para quando os botões de ação não estão acessíveis ao jogador,
permitindo efeteua-las com conbinações lentas de tecla respeitando a dureza do controle remoto.

 - direcional e depois direcional para correr
 - direcional e depois direcional para atirar
 - direcional para ação de recarregar
 - direcional para ação de coronhada

## Objetivo do Jogador

 - Sobreviver por **120 segundos**
 - Progredir ou não durante a run. (influencia na sorte)
 - Escolher um bonus para próxima run. (run sem progresso, não recebe bonus)
 - Evitar contato direto com zumbis. (morte instantânea)
 

## Zumbis

 - Spawn sempre a direita
 - Só existe 1 tipo de zombie
 - Movimentam e atacam a esquerda
 - Não possuem habilidades especiais
 - Velocidade variada durante a orda

## Sistema de Sorte

A sorte é influenciada pela **corrida agressiva** (avanço constante).

### Carta de efeitos

Quanto mais o jogador avança:

- Menor chance de efeitos neutros
- Maior chance de efeitos extremos (bons ou ruins)

| Corrida | Neutro | Bom | Ruim |
|---------|--------|-----|------|
| Parada  | 00% | 00% | 50% |
| Segura  | 70% | 20% | 10% |
| Boa     | 30% | 35% | 35% |
| Agresiva| 10% | 45% | 45% |

é sorteado após a escolha de uma carta bonûs.

 - pode ser sorteado de 1 a 3 efeitos. (depende do multiplicador)
 - os efeitos não são acumulativos

#### Exemplos

 - Zombies só morrem com acerto critico
 - Zombies com 2x de vida
 - Zombies com 0.5x de vida
 - Zombies com 200x de vida (apenas qunado vier 1 unico zombie)
 - Zombies em 2x quantidade
 - Zombies não recebem dano critico (contradiz com a primeira)
 - Zombies dançam trilher
 - Jogador faz moonwalk ao andar para trás

### Cartas de Bônus

 - Escolha de **1 bônus por vez**
 - Nunca empilham
 - Nunca facilitam controles

#### Exemplos

 - Jogador com 2x mais chances de critico
 - Arma com 2 cartuchos de 50 balas


## Multiplicador

 - cada vez que atingir uma corrida boa ou acima, você aumenta em 1 o multiplicador.
 - se você fazer uma corrida segura ou menos você perde o multiplicador
 - multiplicador aumenta a quantidade de inimigos para enfrentar
