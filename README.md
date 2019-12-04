# README
## Projeto de automação de regressão de testes UAT do PDV xStore
### Objetivo do projeto
Simular de maneira automatizada os fluxos de operação de operadores de caixa nas lojas <empresa>

## Setup do projeto
### Pré requisitos:
[Python 3](https://www.python.org/downloads/release/python-380/) (O projeto foi desenvolvido utilizando a versão 3.8.0)  
[Java Rutime Environment (JRE)](https://www.java.com/pt_BR/download/)  
[Git](https://git-scm.com/download/win)

## Instalando o Python:
Em ambientes Windows, faça o download da do pacote "Windows x86-64 executable installer" e siga as instruções do instalador.

## Demais instalações:
Baixe o instalador através do link acima e siga as intruções.

## Ambiente de Desenvolvimento:
(Este passo é opcional mas recomendado.)
Os Ambientes virtuais no python permitem que os projetos rodem de maneira isolada, protegendo o projeto de dependências desnecessárias, garantindo que rode na versão correta da linguagem, etc.
Para instalar, após ter instalado o Python 3, instale o `virtualenv` da seguinte maneira:  
```batchfile
> pip install virtualenv
```  
Após a instalação, navegue um diretório de sua escolha e execute:  
```batchfile
> virtualenv <nome_do_ambiente>
```  
Um diretório será criado com o nome escolhido para o ambiente com a seguinte estrutura:
```batchfile
Include/
Lib/
LICENSE.txt
Scripts/
tcl/
```  
Para iniciar o ambiente virtual, rode o script `activate.bat` contido no diretório `Scripts`:
```batchfile
> cd <nome_do_ambiente>
> Scripts\activate.bat
```

## Clonando repositório remoto
Dentro do ambiente virtual rode o comando:
```batchfile
> git clone <"remote-url">
``` 
- remote url: url do repositório do GitLab, de preferência por utilizar a SSH.  

[Configurando chave ssh no windows]

## Instalando dependências
Dentro do projeto existe um arquivo `requirements.txt` que contém todas as dependências do projeto.
Instale-as em seu ambiente usando o comando:
```batchfile
> pip install -r requirements.txt
```
