DROP TABLE IF EXISTS livro;

CREATE TABLE IF NOT EXISTS livro(
    _id                         INTEGER PRIMARY KEY AUTOINCREMENT NOT NULL,
    firebase_codigo             TEXT NOT NULL,
    ano_edicao                  TEXT NOT NULL,
    autor                       TEXT NOT NULL,
    descricao                   TEXT NOT NULL,
    editora                     TEXT NOT NULL,
    numero_paginas              INTEGER NOT NULL,
    pais_origem                 TEXT NOT NULL,
    titulo                      TEXT NOT NULL,
    status                      INTEGER NOT NULL,
    isbn_10                     TEXT,
    isbn_13                     TEXT,
    numero_edicao               INTEGER,
    data_compra                 TEXT,
    preco                       TEXT,
    link                        TEXT,
    subtitulo                   TEXT,
    categoria                   TEXT,
    data_hora_criacao           DATE NOT NULL,
    data_hora_alteracao         DATE NOT NULL
);
