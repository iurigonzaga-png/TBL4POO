# TBL4POO

1. O que é o estado Terminated?
É quando o app está totalmente fechado (o usuário limpou das abas recentes ou o sistema operacional matou o processo). Não tem nada dele rodando na memória.

2. Por que o Android limita execução em background?
Principalmente para economizar bateria e memória RAM. Se qualquer app ficasse rodando livre em segundo plano, o celular ia descarregar rápido e travar por falta de recursos.

3. Por que Timer.periodic não é confiável em apps reais?
Porque ele roda na memória do app. Se o app vai para o background, o sistema operacional pode pausar ou matar a thread para economizar recursos, fazendo o timer parar ou atrasar. Para coisas sérias em segundo plano, usa-se ferramentas nativas (como WorkManager).

4. Explique o fluxo do Flutter
Resumindo o ciclo de renderização:

Você escreve o código em Dart criando Widgets (a interface).

O Flutter transforma isso em árvores de Elements (gerencia o ciclo de vida) e RenderObjects (calcula tamanho e posição).

O motor gráfico (como o Impeller) pinta tudo na tela a 60 ou 120 FPS.

5. Qual a diferença entre esses termos de notificação (Firebase/Flutter)?
Foreground: O app está aberto e na tela principal do usuário.

Background: O app está aberto, mas minimizado (segundo plano).

Servidor: O backend externo que decide enviar a notificação.

FCM (Firebase Cloud Messaging): O serviço do Google que pega a notificação do seu servidor e entrega no celular.

Android: O sistema operacional do celular.

onMessage: O evento que dispara quando a notificação chega com o app aberto (foreground).

onMessageOpenedApp: O evento que dispara quando o usuário clica na notificação e o app estava em background (minimizado).

getInitialMessage: Verifica se o app abriu porque o usuário clicou numa notificação enquanto ele estava totalmente fechado (terminated).
