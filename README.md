# 🌴 Teresina Turística Flutter App

Este projeto é o Trabalho Final da disciplina de Programação para Dispositivos Móveis, desenvolvido em Flutter seguindo a arquitetura MVC (Model-View-Controller). O objetivo é ser um guia interativo para turistas e moradores, apresentando pontos turísticos e restaurantes típicos de Teresina, Piauí.

**Dupla:** Shara e Alanda

**Professor:** Otilio Paulo

---

## 🧭 Funcionalidades Principais

O aplicativo oferece uma experiência completa de exploração e interação:

### 1. Sistema de Usuário e Autenticação
* Tela de Login e Cadastro para novos usuários.
* Configuração de Perfil.

### 2. Mapas Interativos e Localização
* Utiliza a **API do Google Maps Flutter** [cite: 95] para exibir todos os pontos de interesse de Teresina.
* Pontos marcados no mapa com **ícones diferenciados** para distinguir entre Restaurantes e Pontos Turísticos.
* Exibe a **localização atual** do usuário no mapa[cite: 73].
* Opção para **favoritar** pontos de interesse.

### 3. Interação e Conteúdo
* Ao clicar em um marcador no mapa, é exibida uma **breve descrição** do local.
* Opção para acessar a tela de **Detalhes** do ponto.
* Na tela de Detalhes, o usuário pode **avaliar e sugerir** atividades ou experiências no local.
* Usuários podem **curtir** avaliações e sugestões de outros.
* As avaliações são exibidas por **relevância** (baseada no número de curtidas) e pelo **momento da postagem** (data).

---

## 🏗️ Arquitetura e Tecnologia

* **Framework:** Flutter (Dart)
* **Arquitetura:** MVC (Model-View-Controller) [cite: 10]
* **Gerenciamento de Estado:** [Provider / BlOC/Cubit - *Escolha o seu*]
* **Armazenamento Local:** SQFlite (SQLite) para gerenciar dados de usuários, pontos, avaliações e sugestões[cite: 9].
* **Geolocalização:** Google Maps Flutter [cite: 95] e Geolocator.

---

## 🚀 Como Executar o Projeto

Para rodar o projeto em seu ambiente local, siga as instruções de configuração abaixo.

### Pré-requisitos
1.  **Flutter SDK** instalado e configurado.
2.  **API Key do Google Maps** configurada (Google Cloud Console).

### Passos de Instalação

1.  **Clone o Repositório:**
    ```bash
    git clone [https://github.com/SeuUsuario/Teresina-turistica-flutter.git](https://github.com/SeuUsuario/Teresina-turistica-flutter.git)
    cd Teresina-turistica-flutter
    ```

2.  **Instale as Dependências:**
    ```bash
    flutter pub get
    ```

3.  **Configuração da API Key (Crítico)**
    * **Android:** Insira sua chave de API no arquivo `android/app/src/main/AndroidManifest.xml` (dentro da tag `<application>`).
    * **iOS:** Insira sua chave de API no arquivo `ios/Runner/AppDelegate.m`.

4.  **Execute o App:**
    Inicie um emulador (ou conecte um dispositivo físico) e execute:
    ```bash
    flutter run
    ```

---

## 🤝 Contribuições

Este é um projeto de trabalho final acadêmico. Para fins de avaliação, o código será desenvolvido por Shara e Alanda.

