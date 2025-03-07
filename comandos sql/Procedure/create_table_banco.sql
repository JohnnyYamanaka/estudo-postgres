CREATE EXTENSION IF NOT EXISTS "uuid-ossp";

CREATE TABLE IF NOT EXISTS clients (
    id UUID PRIMARY KEY DEFAULT uuid_generate_v4(),
    limite INTEGER NOT NULL,
    saldo INTEGER NOT NULL
    CONSTRAINT clients_check CHECK (saldo >= (- limite)),
    CONSTRAINT clients_limite_check CHECK (limite > 0)
);

CREATE TABLE IF NOT EXISTS transactions (
    id uuid NOT NULL DEFAULT uuid_generate_v4(),
    tipo CHAR(1) NOT NULL,
    descricao VARCHAR(10) NOT NULL,
    valor INTEGER NOT NULL,
    cliente_id uuid NOT NULL,
    realizada_em TIMESTAMP NOT NULL DEFAULT NOW()
);