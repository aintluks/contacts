# Contacts

Este repositorio contem uma aplicacao interface de linha de comando (CLI) de contatos de pessoas feita no intuito de reforcar meus conhecimentos na linguagem Ruby.

A aplicacao e capaz de:

- Adicionar pessoa
- Deletar pessoa
- Editar pessoa
- Visualizar todas ou apenas uma pessoa dos contatos
- Manipulacoes (CRUD) dos dados sao realizados atraves de um CSV

## Como rodar

Para rodar a aplicacao e bem simples, basta executar o seguinte comando que e responsavel pela instalacao das dependencias:

```
bundle install
```

depois disso a aplicacao ja esta pronta para ser usada

## Como utilizar

Esse projeto conta com alguns simples comandos, veja como usar:

### Listar todos os comandos

Basta rodar o comando baixo que no terminal serao listados os comandos disponiveis da CLI

```
bundle exec exe/contacts
```

### Descricao da CLI

Uma breve descricao da aplicacao

```
bundle exec exe/contacts about
```

### Adicionar pessoa

Comando capaz de adicionar uma pessoa aos contatos

- flags obrigatorias: --name, --phone
- flags opcionais: --email, --bithday

```
bundle exec exe/contacts add --name=NAME --phone=PHONE
```

### Listando pessoa(s)

Comando capaz de listar pessoa(s) cadastrada(s)

- flag opcional: --name

```
bundle exec exe/contacts list
```

### Editando pessoa

Comando capaz de editar pessoa cadastrada

- flag obrigatoria: --name

```
bundle exec exe/contacts update --name=NAME
```

### Deletando pessoa

Comando capaz de deletar pessoa cadastrada

- flag obrigatoria: --name

```
bundle exec exe/contacts del --name=NAME
```

## Testes

Este projeto conta com a realizacao de testes automatizandos criados com o Minitest

#### Para rodar os testes

```
ruby -Ilib:test test/file_test.rb
```

### csv_handler_test.rb

```
Run options: --seed 45692

# Running:

..........

Finished in 0.006987s, 1431.2499 runs/s, 1574.3749 assertions/s.
10 runs, 11 assertions, 0 failures, 0 errors, 0 skips
```

### person_test.rb

```
Run options: --seed 59330

# Running:

..

Finished in 0.001711s, 1169.2214 runs/s, 4676.8857 assertions/s.
2 runs, 8 assertions, 0 failures, 0 errors, 0 skips
```

### iperson_test.rb

```
Run options: --seed 57985

# Running:

.....

Finished in 0.004027s, 1241.5038 runs/s, 1241.5038 assertions/s.
5 runs, 5 assertions, 0 failures, 0 errors, 0 skips
```
