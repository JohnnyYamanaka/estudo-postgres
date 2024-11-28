# Ambiente para estudar SQL
Repositório para estudar postgres.  
Foi configurado dentro do docker o Postgres + PgAdmin.

## Instrução

### Configuração inicial
Antes de instanciar o ambiente, primeiramente criar o arquivo `.env` contendo as seguintes variáveis:


```
    POSTGRES_PASSWORD=senha_postgres
    PGADMIN_DEFAULT_EMAIL=email_pgadmin@email.com
    PGADMIN_DEFAULT_PASSWORD=senha_pgadmin
```

Sem criar esse arquivo, a imagem do docker não será criada.  
Assim que o docker estiver rodando, utilizar o comando `docker-compose up -d`. Se tudo estiver correto, o docker rodará o container.


### Acessar o ambiente  
Para acessar o PG Admin, onde será feita as manipulações no banco, acessar a página [localhost:16543](http://localhost:16543/) com o docker rodando.  

Ao acessar o pgadmin, para realizar a carga inicial do banco de dados copiar o script contido [neste arquivo](comandos%20sql/create_table.sql) e executar dentro da ferramenta.

## Sobre o banco de dados  
Para este estudo, estamos utilizando a base de dados da [Northwind](https://github.com/pthom/northwind_psql), que é um banco de dados gerado pela Microsoft para servir como amostra para os seus produtos. Contém dados de vendas de uma empresa fictícia chamada Northwind.  
Segue abaixo o esquema do banco de dados.

![Diagrama](/estudo-postgres/img/northwind-er-diagram.png "Diagrama ER")  

Mais informações sobre esta base de dados pode ser consultado [aqui](https://docs.yugabyte.com/preview/sample-data/northwind/).