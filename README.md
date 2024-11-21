# Ambiente para estudar SQL
Repositório para estudar postgres.  
Foi configurado dentro do docker o Postgres + PgAdmin.

## Instrução
Para instanciar o ambiente, primeiramente criar o arquivo `.env` contendo as seguintes variáveis:


```
    POSTGRES_PASSWORD=senha_postgres
    PGADMIN_DEFAULT_EMAIL=email_pgadmin@email.com
    PGADMIN_DEFAULT_PASSWORD=senha_pgadmin
```

Sem criar esse arquivo, a imagem do docker não será criada.  
