-- Gerado por Oracle SQL Developer Data Modeler 23.1.0.087.0806
--   em:        2024-05-23 18:53:08 BRT
--   site:      Oracle Database 11g
--   tipo:      Oracle Database 11g



-- predefined type, no DDL - MDSYS.SDO_GEOMETRY

-- predefined type, no DDL - XMLTYPE

CREATE TABLE tb_agenda (
    id_agenda  NUMBER NOT NULL,
    id_tarefa  NUMBER NOT NULL,
    id_usuario NUMBER NOT NULL,
    dsc_agenda VARCHAR2(100) NOT NULL,
    dat_agenda DATE NOT NULL,
    hor_inicio DATE,
    hor_fim    DATE,
    dsc_local  VARCHAR2(100)
);

ALTER TABLE tb_agenda
    ADD CONSTRAINT pk_tb_agenda PRIMARY KEY ( id_agenda,
                                              id_tarefa,
                                              id_usuario );

CREATE TABLE tb_desejos (
    id_desejo         NUMBER NOT NULL,
    id_usuario        NUMBER NOT NULL,
    dsc_desejo        VARCHAR2(100) NOT NULL,
    vl_custo_estimado NUMBER NOT NULL,
    dat_meta_desejo   DATE NOT NULL,
    sts_meta          VARCHAR2(100) NOT NULL
);

COMMENT ON COLUMN tb_desejos.id_desejo IS
    'Id do desejo.';

COMMENT ON COLUMN tb_desejos.dsc_desejo IS
    'Descrição do desejo.';

COMMENT ON COLUMN tb_desejos.vl_custo_estimado IS
    'Valor estimado paa o desejo.';

COMMENT ON COLUMN tb_desejos.dat_meta_desejo IS
    'Data de meta para o desejo.';

COMMENT ON COLUMN tb_desejos.sts_meta IS
    'Status da meta para o desejo.';

ALTER TABLE tb_desejos ADD CONSTRAINT pk_tb_desejos PRIMARY KEY ( id_desejo,
                                                                  id_usuario );

CREATE TABLE tb_despesas_fixas (
    id_despesa  NUMBER NOT NULL,
    id_usuario  NUMBER NOT NULL,
    dsc_despesa VARCHAR2(100) NOT NULL,
    vl_despesa  NUMBER NOT NULL,
    dat_despesa DATE NOT NULL
);

COMMENT ON COLUMN tb_despesas_fixas.id_despesa IS
    'Id da despesa.';

COMMENT ON COLUMN tb_despesas_fixas.dsc_despesa IS
    'Descrição da despesa.';

COMMENT ON COLUMN tb_despesas_fixas.vl_despesa IS
    'Valor da despesa.';

ALTER TABLE tb_despesas_fixas ADD CONSTRAINT pk_tb_despesas_fixas PRIMARY KEY ( id_despesa,
                                                                                id_usuario );

CREATE TABLE tb_dividas (
    id_divida      NUMBER NOT NULL,
    id_usuario     NUMBER NOT NULL,
    nm_credor      VARCHAR2(100) NOT NULL,
    vl_divida      NUMBER NOT NULL,
    dat_vencimento DATE NOT NULL,
    sts_divida     VARCHAR2(100) NOT NULL
);

COMMENT ON COLUMN tb_dividas.id_divida IS
    'Id da divida.';

COMMENT ON COLUMN tb_dividas.nm_credor IS
    'Nome do credor.';

ALTER TABLE tb_dividas ADD CONSTRAINT pk_tb_dividas PRIMARY KEY ( id_divida,
                                                                  id_usuario );

CREATE TABLE tb_gastos_imprevistos (
    id_gasto            NUMBER NOT NULL,
    id_usuario          NUMBER NOT NULL,
    dsc_gasto           VARCHAR2(100) NOT NULL,
    dsc_categoria_gasto VARCHAR2(100) NOT NULL,
    vl_gasto            NUMBER NOT NULL,
    dat_gasto           DATE NOT NULL
);

ALTER TABLE tb_gastos_imprevistos ADD CONSTRAINT pk_tb_gastos_imprevistos PRIMARY KEY ( id_gasto,
                                                                                        id_usuario );

CREATE TABLE tb_poupanca (
    id_poupanca  NUMBER NOT NULL,
    id_usuario   NUMBER NOT NULL,
    vl_poupanca  NUMBER NOT NULL,
    dat_poupanca DATE,
    dsc_poupanca VARCHAR2(100)
);

COMMENT ON COLUMN tb_poupanca.id_poupanca IS
    'Id da poupança.';

COMMENT ON COLUMN tb_poupanca.vl_poupanca IS
    'Valor reservado para poupança.';

COMMENT ON COLUMN tb_poupanca.dat_poupanca IS
    'Data da poupança.';

ALTER TABLE tb_poupanca ADD CONSTRAINT pk_tb_poupanca PRIMARY KEY ( id_poupanca,
                                                                    id_usuario );

CREATE TABLE tb_renda (
    id_renda              NUMBER NOT NULL,
    tb_usuario_id_usuario NUMBER NOT NULL,
    dsc_renda             VARCHAR2(100) NOT NULL,
    vl_renda              NUMBER,
    dat_renda             DATE NOT NULL
);

COMMENT ON COLUMN tb_renda.id_renda IS
    'Id da renda.';

COMMENT ON COLUMN tb_renda.dsc_renda IS
    'Descrição da fonte de renda.';

COMMENT ON COLUMN tb_renda.vl_renda IS
    'Valor da fonte de renda.';

COMMENT ON COLUMN tb_renda.dat_renda IS
    'Data de recebimento da renda.';

ALTER TABLE tb_renda ADD CONSTRAINT tb_renda_pk PRIMARY KEY ( id_renda,
                                                              tb_usuario_id_usuario );

CREATE TABLE tb_tarefas (
    id_tarefa       NUMBER NOT NULL,
    id_usuario      NUMBER NOT NULL,
    dsc_tarefa      VARCHAR2(100) NOT NULL,
    dat_venc_tarefa DATE NOT NULL,
    sts_tarefa      VARCHAR2(50) NOT NULL,
    ind_prioridade  VARCHAR2(50) NOT NULL
);

ALTER TABLE tb_tarefas ADD CONSTRAINT pk_tb_tarefas PRIMARY KEY ( id_tarefa,
                                                                  id_usuario );

CREATE TABLE tb_usuario (
    id_usuario  NUMBER NOT NULL,
    nm_usuario  VARCHAR2(50) NOT NULL,
    dsc_senha   VARCHAR2(50) NOT NULL,
    dsc_email   VARCHAR2(100),
    dat_criacao DATE NOT NULL
);

COMMENT ON COLUMN tb_usuario.id_usuario IS
    'Id do usuário.';

COMMENT ON COLUMN tb_usuario.nm_usuario IS
    'Nome do usuáro.';

COMMENT ON COLUMN tb_usuario.dsc_senha IS
    'Senha do usuário.';

COMMENT ON COLUMN tb_usuario.dsc_email IS
    'E-mail do usuáro.';

COMMENT ON COLUMN tb_usuario.dat_criacao IS
    'Data de criação do usuário.';

ALTER TABLE tb_usuario ADD CONSTRAINT pk_tb_usuario PRIMARY KEY ( id_usuario );

ALTER TABLE tb_agenda
    ADD CONSTRAINT fk_tb_tarefas FOREIGN KEY ( id_tarefa,
                                               id_usuario )
        REFERENCES tb_tarefas ( id_tarefa,
                                id_usuario );

ALTER TABLE tb_tarefas
    ADD CONSTRAINT fk_tb_usuario FOREIGN KEY ( id_usuario )
        REFERENCES tb_usuario ( id_usuario );

ALTER TABLE tb_desejos
    ADD CONSTRAINT fk_tb_usuario_desejos FOREIGN KEY ( id_usuario )
        REFERENCES tb_usuario ( id_usuario );

ALTER TABLE tb_despesas_fixas
    ADD CONSTRAINT fk_tb_usuario_despesas_fixas FOREIGN KEY ( id_usuario )
        REFERENCES tb_usuario ( id_usuario );

ALTER TABLE tb_dividas
    ADD CONSTRAINT fk_tb_usuario_dividas FOREIGN KEY ( id_usuario )
        REFERENCES tb_usuario ( id_usuario );

ALTER TABLE tb_gastos_imprevistos
    ADD CONSTRAINT fk_tb_usuario_gastos_imp FOREIGN KEY ( id_usuario )
        REFERENCES tb_usuario ( id_usuario );

ALTER TABLE tb_poupanca
    ADD CONSTRAINT fk_tb_usuario_poupanca FOREIGN KEY ( id_usuario )
        REFERENCES tb_usuario ( id_usuario );

ALTER TABLE tb_renda
    ADD CONSTRAINT fk_tb_usuario_renda FOREIGN KEY ( tb_usuario_id_usuario )
        REFERENCES tb_usuario ( id_usuario );



-- Relatório do Resumo do Oracle SQL Developer Data Modeler: 
-- 
-- CREATE TABLE                             9
-- CREATE INDEX                             0
-- ALTER TABLE                             17
-- CREATE VIEW                              0
-- ALTER VIEW                               0
-- CREATE PACKAGE                           0
-- CREATE PACKAGE BODY                      0
-- CREATE PROCEDURE                         0
-- CREATE FUNCTION                          0
-- CREATE TRIGGER                           0
-- ALTER TRIGGER                            0
-- CREATE COLLECTION TYPE                   0
-- CREATE STRUCTURED TYPE                   0
-- CREATE STRUCTURED TYPE BODY              0
-- CREATE CLUSTER                           0
-- CREATE CONTEXT                           0
-- CREATE DATABASE                          0
-- CREATE DIMENSION                         0
-- CREATE DIRECTORY                         0
-- CREATE DISK GROUP                        0
-- CREATE ROLE                              0
-- CREATE ROLLBACK SEGMENT                  0
-- CREATE SEQUENCE                          0
-- CREATE MATERIALIZED VIEW                 0
-- CREATE MATERIALIZED VIEW LOG             0
-- CREATE SYNONYM                           0
-- CREATE TABLESPACE                        0
-- CREATE USER                              0
-- 
-- DROP TABLESPACE                          0
-- DROP DATABASE                            0
-- 
-- REDACTION POLICY                         0
-- 
-- ORDS DROP SCHEMA                         0
-- ORDS ENABLE SCHEMA                       0
-- ORDS ENABLE OBJECT                       0
-- 
-- ERRORS                                   0
-- WARNINGS                                 0
