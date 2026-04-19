--
-- PostgreSQL database dump
--

\restrict ykpe4nkQVnFK2dy8lxvS123EKKBeDE2UqQSVV4IdtW7BvLv9BORr2vgUozeimAq

-- Dumped from database version 16.13 (Ubuntu 16.13-1.pgdg24.04+1)
-- Dumped by pg_dump version 16.13 (Ubuntu 16.13-1.pgdg24.04+1)

-- Started on 2026-04-12 01:37:04 -03

SET statement_timeout = 0;
SET lock_timeout = 0;
SET idle_in_transaction_session_timeout = 0;
SET client_encoding = 'UTF8';
SET standard_conforming_strings = on;
SELECT pg_catalog.set_config('search_path', '', false);
SET check_function_bodies = false;
SET xmloption = content;
SET client_min_messages = warning;
SET row_security = off;

--
-- TOC entry 4 (class 2615 OID 2200)
-- Name: public; Type: SCHEMA; Schema: -; Owner: pg_database_owner
--

CREATE SCHEMA public;


ALTER SCHEMA public OWNER TO pg_database_owner;

--
-- TOC entry 3661 (class 0 OID 0)
-- Dependencies: 4
-- Name: SCHEMA public; Type: COMMENT; Schema: -; Owner: pg_database_owner
--

COMMENT ON SCHEMA public IS 'standard public schema';


--
-- TOC entry 268 (class 1255 OID 16927)
-- Name: validachavepessoa(); Type: FUNCTION; Schema: public; Owner: mauricio
--

CREATE FUNCTION public.validachavepessoa() RETURNS trigger
    LANGUAGE plpgsql
    AS $$
 declare existe integer;
BEGIN


existe = (select count(1) from pessoa_fisica where  id = NEW.pessoa_fornecedor_id);
if(existe <= 0) then
existe = (select count(1) from pessoa_juridica where  id =  NEW.pessoa_fornecedor_id );
if(existe <=0) then 

RAISE EXCEPTION 'Não  foi encontrado  o ID ou PK da pessoa para realizar a assocoação do cadastro';
end if ;
 end if;

RETURN NEW;
END;

$$;


ALTER FUNCTION public.validachavepessoa() OWNER TO mauricio;

SET default_tablespace = '';

SET default_table_access_method = heap;

--
-- TOC entry 215 (class 1259 OID 16392)
-- Name: acesso; Type: TABLE; Schema: public; Owner: mauricio
--

CREATE TABLE public.acesso (
    id bigint NOT NULL,
    descricao character varying(255) NOT NULL
);


ALTER TABLE public.acesso OWNER TO mauricio;

--
-- TOC entry 245 (class 1259 OID 16727)
-- Name: avaliacao_produto; Type: TABLE; Schema: public; Owner: mauricio
--

CREATE TABLE public.avaliacao_produto (
    id bigint NOT NULL,
    descricao character varying(255) NOT NULL,
    nota integer NOT NULL,
    pessoa_id bigint NOT NULL,
    produto_id bigint NOT NULL
);


ALTER TABLE public.avaliacao_produto OWNER TO mauricio;

--
-- TOC entry 216 (class 1259 OID 16397)
-- Name: categoria_produto; Type: TABLE; Schema: public; Owner: mauricio
--

CREATE TABLE public.categoria_produto (
    id bigint NOT NULL,
    "nome_descrição" character varying(255) NOT NULL
);


ALTER TABLE public.categoria_produto OWNER TO mauricio;

--
-- TOC entry 218 (class 1259 OID 16410)
-- Name: conta_pagar; Type: TABLE; Schema: public; Owner: mauricio
--

CREATE TABLE public.conta_pagar (
    id bigint NOT NULL,
    data_pagamento date,
    data_vencimento date,
    descricao character varying(255),
    status character varying(255),
    valor_desconto numeric(38,2),
    valor_total numeric(38,2),
    pessoa_id bigint NOT NULL,
    pessoa_fornecedor_id bigint NOT NULL,
    CONSTRAINT conta_rpagar_status_check CHECK (((status)::text = ANY ((ARRAY['COBRANCA'::character varying, 'VENCIDA'::character varying, 'ABERTA'::character varying, 'QUITADA'::character varying, 'NEGOCIADA'::character varying])::text[])))
);


ALTER TABLE public.conta_pagar OWNER TO mauricio;

--
-- TOC entry 217 (class 1259 OID 16402)
-- Name: conta_receber; Type: TABLE; Schema: public; Owner: mauricio
--

CREATE TABLE public.conta_receber (
    id bigint NOT NULL,
    data_pagamento date NOT NULL,
    data_vencimento date NOT NULL,
    descricao character varying(255) NOT NULL,
    status character varying(255) NOT NULL,
    valor_total numeric(38,2) NOT NULL,
    pessoa_id bigint NOT NULL,
    valor_desconto numeric(38,2),
    CONSTRAINT conta_receber_status_check CHECK (((status)::text = ANY ((ARRAY['COBRANCA'::character varying, 'VENCIDA'::character varying, 'ABERTA'::character varying, 'QUITADA'::character varying])::text[])))
);


ALTER TABLE public.conta_receber OWNER TO mauricio;

--
-- TOC entry 219 (class 1259 OID 16418)
-- Name: cupom_de_desconto; Type: TABLE; Schema: public; Owner: mauricio
--

CREATE TABLE public.cupom_de_desconto (
    id bigint NOT NULL,
    codigo_descricao character varying(255) NOT NULL,
    data_vlidade_cupom time(6) without time zone NOT NULL,
    valor_porcent_desconto numeric(38,2),
    valor_real_desconto numeric(38,2)
);


ALTER TABLE public.cupom_de_desconto OWNER TO mauricio;

--
-- TOC entry 220 (class 1259 OID 16423)
-- Name: endereco; Type: TABLE; Schema: public; Owner: mauricio
--

CREATE TABLE public.endereco (
    id bigint NOT NULL,
    bairro character varying(255) NOT NULL,
    cep character varying(255) NOT NULL,
    cidade character varying(255) NOT NULL,
    complemento character varying(255),
    numero character varying(255) NOT NULL,
    rualogradouro character varying(255) NOT NULL,
    tipo_endereco smallint NOT NULL,
    uf character varying(255),
    pessoa_id bigint NOT NULL,
    CONSTRAINT endereco_tipo_endereco_check CHECK (((tipo_endereco >= 0) AND (tipo_endereco <= 1)))
);


ALTER TABLE public.endereco OWNER TO mauricio;

--
-- TOC entry 221 (class 1259 OID 16431)
-- Name: forma_pagamento; Type: TABLE; Schema: public; Owner: mauricio
--

CREATE TABLE public.forma_pagamento (
    id bigint NOT NULL,
    descricao character varying(255) NOT NULL
);


ALTER TABLE public.forma_pagamento OWNER TO mauricio;

--
-- TOC entry 236 (class 1259 OID 16572)
-- Name: imagem_produto; Type: TABLE; Schema: public; Owner: mauricio
--

CREATE TABLE public.imagem_produto (
    id bigint NOT NULL,
    imagem_miniatura text NOT NULL,
    imagem_original text NOT NULL,
    produto_id bigint NOT NULL
);


ALTER TABLE public.imagem_produto OWNER TO mauricio;

--
-- TOC entry 243 (class 1259 OID 16711)
-- Name: item_de_venda; Type: TABLE; Schema: public; Owner: mauricio
--

CREATE TABLE public.item_de_venda (
    id bigint NOT NULL,
    quantidade double precision NOT NULL,
    produto_id bigint NOT NULL,
    venda_id bigint NOT NULL
);


ALTER TABLE public.item_de_venda OWNER TO mauricio;

--
-- TOC entry 222 (class 1259 OID 16436)
-- Name: marca_produto; Type: TABLE; Schema: public; Owner: mauricio
--

CREATE TABLE public.marca_produto (
    id bigint NOT NULL,
    nome_descricao character varying(255) NOT NULL
);


ALTER TABLE public.marca_produto OWNER TO mauricio;

--
-- TOC entry 249 (class 1259 OID 16768)
-- Name: nota_fical_venda; Type: TABLE; Schema: public; Owner: mauricio
--

CREATE TABLE public.nota_fical_venda (
    id bigint NOT NULL,
    numero character varying(255) NOT NULL,
    pdf text NOT NULL,
    serie character varying(255) NOT NULL,
    tipo character varying(255) NOT NULL,
    xml text NOT NULL,
    venda_id bigint NOT NULL
);


ALTER TABLE public.nota_fical_venda OWNER TO mauricio;

--
-- TOC entry 247 (class 1259 OID 16750)
-- Name: nota_fiscal_compra; Type: TABLE; Schema: public; Owner: mauricio
--

CREATE TABLE public.nota_fiscal_compra (
    id bigint NOT NULL,
    data_compra date NOT NULL,
    descricao_observacao character varying(255),
    numero_da_nota character varying(255) NOT NULL,
    serie_nota character varying(255) NOT NULL,
    valor_desconto numeric(38,2),
    valor_icms numeric(38,2) NOT NULL,
    valor_total numeric(38,2) NOT NULL,
    conta_pagar_id bigint NOT NULL,
    pessoa_id bigint NOT NULL
);


ALTER TABLE public.nota_fiscal_compra OWNER TO mauricio;

--
-- TOC entry 250 (class 1259 OID 16787)
-- Name: nota_item_produto; Type: TABLE; Schema: public; Owner: mauricio
--

CREATE TABLE public.nota_item_produto (
    id bigint NOT NULL,
    quantidade double precision NOT NULL,
    nota_fiscal_compra_id bigint NOT NULL,
    produto_id bigint NOT NULL
);


ALTER TABLE public.nota_item_produto OWNER TO mauricio;

--
-- TOC entry 256 (class 1259 OID 16897)
-- Name: pessoa_fisica; Type: TABLE; Schema: public; Owner: mauricio
--

CREATE TABLE public.pessoa_fisica (
    id bigint NOT NULL,
    email character varying(255) NOT NULL,
    nome character varying(255) NOT NULL,
    telefone character varying(255) NOT NULL,
    cpf character varying(255) NOT NULL,
    data_nascimento date
);


ALTER TABLE public.pessoa_fisica OWNER TO mauricio;

--
-- TOC entry 252 (class 1259 OID 16803)
-- Name: pessoa_juridica; Type: TABLE; Schema: public; Owner: mauricio
--

CREATE TABLE public.pessoa_juridica (
    id bigint NOT NULL,
    email character varying(255) NOT NULL,
    nome character varying(255) NOT NULL,
    telefone character varying(255) NOT NULL,
    categoria character varying(255),
    cnpj character varying(255) NOT NULL,
    inscricao_estadual character varying(255) NOT NULL,
    inscricao_municipal character varying(255),
    nome_fantasia character varying(255) NOT NULL,
    razao_social character varying(255) NOT NULL
);


ALTER TABLE public.pessoa_juridica OWNER TO mauricio;

--
-- TOC entry 253 (class 1259 OID 16811)
-- Name: produto; Type: TABLE; Schema: public; Owner: mauricio
--

CREATE TABLE public.produto (
    id bigint NOT NULL,
    alerta_quantidade_estoque boolean,
    altura double precision NOT NULL,
    ativo boolean NOT NULL,
    descricao text NOT NULL,
    largura double precision NOT NULL,
    link_youtube character varying(255),
    nome character varying(255) NOT NULL,
    peso double precision NOT NULL,
    profundidade double precision NOT NULL,
    quantidade_alerta_estoque integer,
    quantidade_clique integer,
    quantidade_estoque integer NOT NULL,
    tipo_unidade character varying(255) NOT NULL,
    valor_de_venda numeric(38,2) NOT NULL
);


ALTER TABLE public.produto OWNER TO mauricio;

--
-- TOC entry 224 (class 1259 OID 16467)
-- Name: seq_acesso; Type: SEQUENCE; Schema: public; Owner: mauricio
--

CREATE SEQUENCE public.seq_acesso
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.seq_acesso OWNER TO mauricio;

--
-- TOC entry 246 (class 1259 OID 16732)
-- Name: seq_avaliacao_produto; Type: SEQUENCE; Schema: public; Owner: mauricio
--

CREATE SEQUENCE public.seq_avaliacao_produto
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.seq_avaliacao_produto OWNER TO mauricio;

--
-- TOC entry 225 (class 1259 OID 16468)
-- Name: seq_categoria_produto; Type: SEQUENCE; Schema: public; Owner: mauricio
--

CREATE SEQUENCE public.seq_categoria_produto
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.seq_categoria_produto OWNER TO mauricio;

--
-- TOC entry 226 (class 1259 OID 16469)
-- Name: seq_conta_pagar; Type: SEQUENCE; Schema: public; Owner: mauricio
--

CREATE SEQUENCE public.seq_conta_pagar
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.seq_conta_pagar OWNER TO mauricio;

--
-- TOC entry 227 (class 1259 OID 16470)
-- Name: seq_conta_receber; Type: SEQUENCE; Schema: public; Owner: mauricio
--

CREATE SEQUENCE public.seq_conta_receber
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.seq_conta_receber OWNER TO mauricio;

--
-- TOC entry 228 (class 1259 OID 16471)
-- Name: seq_cupom_de_desconto; Type: SEQUENCE; Schema: public; Owner: mauricio
--

CREATE SEQUENCE public.seq_cupom_de_desconto
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.seq_cupom_de_desconto OWNER TO mauricio;

--
-- TOC entry 229 (class 1259 OID 16472)
-- Name: seq_endereco; Type: SEQUENCE; Schema: public; Owner: mauricio
--

CREATE SEQUENCE public.seq_endereco
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.seq_endereco OWNER TO mauricio;

--
-- TOC entry 230 (class 1259 OID 16473)
-- Name: seq_forma_pagamento; Type: SEQUENCE; Schema: public; Owner: mauricio
--

CREATE SEQUENCE public.seq_forma_pagamento
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.seq_forma_pagamento OWNER TO mauricio;

--
-- TOC entry 235 (class 1259 OID 16517)
-- Name: seq_imagem_produto; Type: SEQUENCE; Schema: public; Owner: mauricio
--

CREATE SEQUENCE public.seq_imagem_produto
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.seq_imagem_produto OWNER TO mauricio;

--
-- TOC entry 244 (class 1259 OID 16716)
-- Name: seq_item_de_venda; Type: SEQUENCE; Schema: public; Owner: mauricio
--

CREATE SEQUENCE public.seq_item_de_venda
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.seq_item_de_venda OWNER TO mauricio;

--
-- TOC entry 231 (class 1259 OID 16474)
-- Name: seq_marca_produto; Type: SEQUENCE; Schema: public; Owner: mauricio
--

CREATE SEQUENCE public.seq_marca_produto
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.seq_marca_produto OWNER TO mauricio;

--
-- TOC entry 237 (class 1259 OID 16591)
-- Name: seq_nota-fiscal-compra; Type: SEQUENCE; Schema: public; Owner: mauricio
--

CREATE SEQUENCE public."seq_nota-fiscal-compra"
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public."seq_nota-fiscal-compra" OWNER TO mauricio;

--
-- TOC entry 238 (class 1259 OID 16604)
-- Name: seq_nota-item-produto; Type: SEQUENCE; Schema: public; Owner: mauricio
--

CREATE SEQUENCE public."seq_nota-item-produto"
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public."seq_nota-item-produto" OWNER TO mauricio;

--
-- TOC entry 241 (class 1259 OID 16635)
-- Name: seq_nota_fical_venda; Type: SEQUENCE; Schema: public; Owner: mauricio
--

CREATE SEQUENCE public.seq_nota_fical_venda
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.seq_nota_fical_venda OWNER TO mauricio;

--
-- TOC entry 248 (class 1259 OID 16757)
-- Name: seq_nota_fiscal_compra; Type: SEQUENCE; Schema: public; Owner: mauricio
--

CREATE SEQUENCE public.seq_nota_fiscal_compra
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.seq_nota_fiscal_compra OWNER TO mauricio;

--
-- TOC entry 251 (class 1259 OID 16802)
-- Name: seq_nota_item_produto; Type: SEQUENCE; Schema: public; Owner: mauricio
--

CREATE SEQUENCE public.seq_nota_item_produto
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.seq_nota_item_produto OWNER TO mauricio;

--
-- TOC entry 232 (class 1259 OID 16475)
-- Name: seq_pessoa; Type: SEQUENCE; Schema: public; Owner: mauricio
--

CREATE SEQUENCE public.seq_pessoa
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.seq_pessoa OWNER TO mauricio;

--
-- TOC entry 234 (class 1259 OID 16492)
-- Name: seq_produto; Type: SEQUENCE; Schema: public; Owner: mauricio
--

CREATE SEQUENCE public.seq_produto
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.seq_produto OWNER TO mauricio;

--
-- TOC entry 240 (class 1259 OID 16627)
-- Name: seq_status_rastreio; Type: SEQUENCE; Schema: public; Owner: mauricio
--

CREATE SEQUENCE public.seq_status_rastreio
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.seq_status_rastreio OWNER TO mauricio;

--
-- TOC entry 233 (class 1259 OID 16476)
-- Name: seq_usuario; Type: SEQUENCE; Schema: public; Owner: mauricio
--

CREATE SEQUENCE public.seq_usuario
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.seq_usuario OWNER TO mauricio;

--
-- TOC entry 242 (class 1259 OID 16641)
-- Name: seq_venda; Type: SEQUENCE; Schema: public; Owner: mauricio
--

CREATE SEQUENCE public.seq_venda
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.seq_venda OWNER TO mauricio;

--
-- TOC entry 239 (class 1259 OID 16620)
-- Name: status_rastreio; Type: TABLE; Schema: public; Owner: mauricio
--

CREATE TABLE public.status_rastreio (
    id bigint NOT NULL,
    centro_distribuicao character varying(255),
    cidade character varying(255),
    estado character varying(255),
    status character varying(255),
    venda_id bigint NOT NULL
);


ALTER TABLE public.status_rastreio OWNER TO mauricio;

--
-- TOC entry 254 (class 1259 OID 16838)
-- Name: usuario; Type: TABLE; Schema: public; Owner: mauricio
--

CREATE TABLE public.usuario (
    id bigint NOT NULL,
    data_senha_atual date NOT NULL,
    login character varying(255) NOT NULL,
    senha character varying(255) NOT NULL,
    pessoa_id bigint NOT NULL
);


ALTER TABLE public.usuario OWNER TO mauricio;

--
-- TOC entry 223 (class 1259 OID 16462)
-- Name: usurios_acesso; Type: TABLE; Schema: public; Owner: mauricio
--

CREATE TABLE public.usurios_acesso (
    usuario_id bigint NOT NULL,
    acesso_id bigint NOT NULL
);


ALTER TABLE public.usurios_acesso OWNER TO mauricio;

--
-- TOC entry 255 (class 1259 OID 16850)
-- Name: venda; Type: TABLE; Schema: public; Owner: mauricio
--

CREATE TABLE public.venda (
    id bigint NOT NULL,
    data_entrga date NOT NULL,
    dia_entrega date NOT NULL,
    valor_desconto numeric(38,2),
    valor_frete numeric(38,2) NOT NULL,
    valor_total numeric(38,2) NOT NULL,
    cupom_desconto_id bigint,
    endereco_cobranca_id bigint NOT NULL,
    endereco_entrega_id bigint NOT NULL,
    nota_fiscal_venda_id bigint NOT NULL,
    forma_pagamento_id bigint NOT NULL,
    pessoa_id bigint NOT NULL
);


ALTER TABLE public.venda OWNER TO mauricio;

--
-- TOC entry 3614 (class 0 OID 16392)
-- Dependencies: 215
-- Data for Name: acesso; Type: TABLE DATA; Schema: public; Owner: mauricio
--

COPY public.acesso (id, descricao) FROM stdin;
\.


--
-- TOC entry 3644 (class 0 OID 16727)
-- Dependencies: 245
-- Data for Name: avaliacao_produto; Type: TABLE DATA; Schema: public; Owner: mauricio
--

COPY public.avaliacao_produto (id, descricao, nota, pessoa_id, produto_id) FROM stdin;
\.


--
-- TOC entry 3615 (class 0 OID 16397)
-- Dependencies: 216
-- Data for Name: categoria_produto; Type: TABLE DATA; Schema: public; Owner: mauricio
--

COPY public.categoria_produto (id, "nome_descrição") FROM stdin;
\.


--
-- TOC entry 3617 (class 0 OID 16410)
-- Dependencies: 218
-- Data for Name: conta_pagar; Type: TABLE DATA; Schema: public; Owner: mauricio
--

COPY public.conta_pagar (id, data_pagamento, data_vencimento, descricao, status, valor_desconto, valor_total, pessoa_id, pessoa_fornecedor_id) FROM stdin;
\.


--
-- TOC entry 3616 (class 0 OID 16402)
-- Dependencies: 217
-- Data for Name: conta_receber; Type: TABLE DATA; Schema: public; Owner: mauricio
--

COPY public.conta_receber (id, data_pagamento, data_vencimento, descricao, status, valor_total, pessoa_id, valor_desconto) FROM stdin;
\.


--
-- TOC entry 3618 (class 0 OID 16418)
-- Dependencies: 219
-- Data for Name: cupom_de_desconto; Type: TABLE DATA; Schema: public; Owner: mauricio
--

COPY public.cupom_de_desconto (id, codigo_descricao, data_vlidade_cupom, valor_porcent_desconto, valor_real_desconto) FROM stdin;
\.


--
-- TOC entry 3619 (class 0 OID 16423)
-- Dependencies: 220
-- Data for Name: endereco; Type: TABLE DATA; Schema: public; Owner: mauricio
--

COPY public.endereco (id, bairro, cep, cidade, complemento, numero, rualogradouro, tipo_endereco, uf, pessoa_id) FROM stdin;
\.


--
-- TOC entry 3620 (class 0 OID 16431)
-- Dependencies: 221
-- Data for Name: forma_pagamento; Type: TABLE DATA; Schema: public; Owner: mauricio
--

COPY public.forma_pagamento (id, descricao) FROM stdin;
\.


--
-- TOC entry 3635 (class 0 OID 16572)
-- Dependencies: 236
-- Data for Name: imagem_produto; Type: TABLE DATA; Schema: public; Owner: mauricio
--

COPY public.imagem_produto (id, imagem_miniatura, imagem_original, produto_id) FROM stdin;
\.


--
-- TOC entry 3642 (class 0 OID 16711)
-- Dependencies: 243
-- Data for Name: item_de_venda; Type: TABLE DATA; Schema: public; Owner: mauricio
--

COPY public.item_de_venda (id, quantidade, produto_id, venda_id) FROM stdin;
\.


--
-- TOC entry 3621 (class 0 OID 16436)
-- Dependencies: 222
-- Data for Name: marca_produto; Type: TABLE DATA; Schema: public; Owner: mauricio
--

COPY public.marca_produto (id, nome_descricao) FROM stdin;
\.


--
-- TOC entry 3648 (class 0 OID 16768)
-- Dependencies: 249
-- Data for Name: nota_fical_venda; Type: TABLE DATA; Schema: public; Owner: mauricio
--

COPY public.nota_fical_venda (id, numero, pdf, serie, tipo, xml, venda_id) FROM stdin;
\.


--
-- TOC entry 3646 (class 0 OID 16750)
-- Dependencies: 247
-- Data for Name: nota_fiscal_compra; Type: TABLE DATA; Schema: public; Owner: mauricio
--

COPY public.nota_fiscal_compra (id, data_compra, descricao_observacao, numero_da_nota, serie_nota, valor_desconto, valor_icms, valor_total, conta_pagar_id, pessoa_id) FROM stdin;
\.


--
-- TOC entry 3649 (class 0 OID 16787)
-- Dependencies: 250
-- Data for Name: nota_item_produto; Type: TABLE DATA; Schema: public; Owner: mauricio
--

COPY public.nota_item_produto (id, quantidade, nota_fiscal_compra_id, produto_id) FROM stdin;
\.


--
-- TOC entry 3655 (class 0 OID 16897)
-- Dependencies: 256
-- Data for Name: pessoa_fisica; Type: TABLE DATA; Schema: public; Owner: mauricio
--

COPY public.pessoa_fisica (id, email, nome, telefone, cpf, data_nascimento) FROM stdin;
\.


--
-- TOC entry 3651 (class 0 OID 16803)
-- Dependencies: 252
-- Data for Name: pessoa_juridica; Type: TABLE DATA; Schema: public; Owner: mauricio
--

COPY public.pessoa_juridica (id, email, nome, telefone, categoria, cnpj, inscricao_estadual, inscricao_municipal, nome_fantasia, razao_social) FROM stdin;
\.


--
-- TOC entry 3652 (class 0 OID 16811)
-- Dependencies: 253
-- Data for Name: produto; Type: TABLE DATA; Schema: public; Owner: mauricio
--

COPY public.produto (id, alerta_quantidade_estoque, altura, ativo, descricao, largura, link_youtube, nome, peso, profundidade, quantidade_alerta_estoque, quantidade_clique, quantidade_estoque, tipo_unidade, valor_de_venda) FROM stdin;
\.


--
-- TOC entry 3638 (class 0 OID 16620)
-- Dependencies: 239
-- Data for Name: status_rastreio; Type: TABLE DATA; Schema: public; Owner: mauricio
--

COPY public.status_rastreio (id, centro_distribuicao, cidade, estado, status, venda_id) FROM stdin;
\.


--
-- TOC entry 3653 (class 0 OID 16838)
-- Dependencies: 254
-- Data for Name: usuario; Type: TABLE DATA; Schema: public; Owner: mauricio
--

COPY public.usuario (id, data_senha_atual, login, senha, pessoa_id) FROM stdin;
\.


--
-- TOC entry 3622 (class 0 OID 16462)
-- Dependencies: 223
-- Data for Name: usurios_acesso; Type: TABLE DATA; Schema: public; Owner: mauricio
--

COPY public.usurios_acesso (usuario_id, acesso_id) FROM stdin;
\.


--
-- TOC entry 3654 (class 0 OID 16850)
-- Dependencies: 255
-- Data for Name: venda; Type: TABLE DATA; Schema: public; Owner: mauricio
--

COPY public.venda (id, data_entrga, dia_entrega, valor_desconto, valor_frete, valor_total, cupom_desconto_id, endereco_cobranca_id, endereco_entrega_id, nota_fiscal_venda_id, forma_pagamento_id, pessoa_id) FROM stdin;
\.


--
-- TOC entry 3662 (class 0 OID 0)
-- Dependencies: 224
-- Name: seq_acesso; Type: SEQUENCE SET; Schema: public; Owner: mauricio
--

SELECT pg_catalog.setval('public.seq_acesso', 1, false);


--
-- TOC entry 3663 (class 0 OID 0)
-- Dependencies: 246
-- Name: seq_avaliacao_produto; Type: SEQUENCE SET; Schema: public; Owner: mauricio
--

SELECT pg_catalog.setval('public.seq_avaliacao_produto', 1, false);


--
-- TOC entry 3664 (class 0 OID 0)
-- Dependencies: 225
-- Name: seq_categoria_produto; Type: SEQUENCE SET; Schema: public; Owner: mauricio
--

SELECT pg_catalog.setval('public.seq_categoria_produto', 1, false);


--
-- TOC entry 3665 (class 0 OID 0)
-- Dependencies: 226
-- Name: seq_conta_pagar; Type: SEQUENCE SET; Schema: public; Owner: mauricio
--

SELECT pg_catalog.setval('public.seq_conta_pagar', 1, false);


--
-- TOC entry 3666 (class 0 OID 0)
-- Dependencies: 227
-- Name: seq_conta_receber; Type: SEQUENCE SET; Schema: public; Owner: mauricio
--

SELECT pg_catalog.setval('public.seq_conta_receber', 1, false);


--
-- TOC entry 3667 (class 0 OID 0)
-- Dependencies: 228
-- Name: seq_cupom_de_desconto; Type: SEQUENCE SET; Schema: public; Owner: mauricio
--

SELECT pg_catalog.setval('public.seq_cupom_de_desconto', 1, false);


--
-- TOC entry 3668 (class 0 OID 0)
-- Dependencies: 229
-- Name: seq_endereco; Type: SEQUENCE SET; Schema: public; Owner: mauricio
--

SELECT pg_catalog.setval('public.seq_endereco', 1, false);


--
-- TOC entry 3669 (class 0 OID 0)
-- Dependencies: 230
-- Name: seq_forma_pagamento; Type: SEQUENCE SET; Schema: public; Owner: mauricio
--

SELECT pg_catalog.setval('public.seq_forma_pagamento', 1, false);


--
-- TOC entry 3670 (class 0 OID 0)
-- Dependencies: 235
-- Name: seq_imagem_produto; Type: SEQUENCE SET; Schema: public; Owner: mauricio
--

SELECT pg_catalog.setval('public.seq_imagem_produto', 1, false);


--
-- TOC entry 3671 (class 0 OID 0)
-- Dependencies: 244
-- Name: seq_item_de_venda; Type: SEQUENCE SET; Schema: public; Owner: mauricio
--

SELECT pg_catalog.setval('public.seq_item_de_venda', 1, false);


--
-- TOC entry 3672 (class 0 OID 0)
-- Dependencies: 231
-- Name: seq_marca_produto; Type: SEQUENCE SET; Schema: public; Owner: mauricio
--

SELECT pg_catalog.setval('public.seq_marca_produto', 1, false);


--
-- TOC entry 3673 (class 0 OID 0)
-- Dependencies: 237
-- Name: seq_nota-fiscal-compra; Type: SEQUENCE SET; Schema: public; Owner: mauricio
--

SELECT pg_catalog.setval('public."seq_nota-fiscal-compra"', 1, false);


--
-- TOC entry 3674 (class 0 OID 0)
-- Dependencies: 238
-- Name: seq_nota-item-produto; Type: SEQUENCE SET; Schema: public; Owner: mauricio
--

SELECT pg_catalog.setval('public."seq_nota-item-produto"', 1, false);


--
-- TOC entry 3675 (class 0 OID 0)
-- Dependencies: 241
-- Name: seq_nota_fical_venda; Type: SEQUENCE SET; Schema: public; Owner: mauricio
--

SELECT pg_catalog.setval('public.seq_nota_fical_venda', 1, false);


--
-- TOC entry 3676 (class 0 OID 0)
-- Dependencies: 248
-- Name: seq_nota_fiscal_compra; Type: SEQUENCE SET; Schema: public; Owner: mauricio
--

SELECT pg_catalog.setval('public.seq_nota_fiscal_compra', 1, false);


--
-- TOC entry 3677 (class 0 OID 0)
-- Dependencies: 251
-- Name: seq_nota_item_produto; Type: SEQUENCE SET; Schema: public; Owner: mauricio
--

SELECT pg_catalog.setval('public.seq_nota_item_produto', 1, false);


--
-- TOC entry 3678 (class 0 OID 0)
-- Dependencies: 232
-- Name: seq_pessoa; Type: SEQUENCE SET; Schema: public; Owner: mauricio
--

SELECT pg_catalog.setval('public.seq_pessoa', 1, false);


--
-- TOC entry 3679 (class 0 OID 0)
-- Dependencies: 234
-- Name: seq_produto; Type: SEQUENCE SET; Schema: public; Owner: mauricio
--

SELECT pg_catalog.setval('public.seq_produto', 1, false);


--
-- TOC entry 3680 (class 0 OID 0)
-- Dependencies: 240
-- Name: seq_status_rastreio; Type: SEQUENCE SET; Schema: public; Owner: mauricio
--

SELECT pg_catalog.setval('public.seq_status_rastreio', 1, false);


--
-- TOC entry 3681 (class 0 OID 0)
-- Dependencies: 233
-- Name: seq_usuario; Type: SEQUENCE SET; Schema: public; Owner: mauricio
--

SELECT pg_catalog.setval('public.seq_usuario', 1, false);


--
-- TOC entry 3682 (class 0 OID 0)
-- Dependencies: 242
-- Name: seq_venda; Type: SEQUENCE SET; Schema: public; Owner: mauricio
--

SELECT pg_catalog.setval('public.seq_venda', 1, false);


--
-- TOC entry 3392 (class 2606 OID 16396)
-- Name: acesso acesso_pkey; Type: CONSTRAINT; Schema: public; Owner: mauricio
--

ALTER TABLE ONLY public.acesso
    ADD CONSTRAINT acesso_pkey PRIMARY KEY (id);


--
-- TOC entry 3418 (class 2606 OID 16731)
-- Name: avaliacao_produto avaliacao_produto_pkey; Type: CONSTRAINT; Schema: public; Owner: mauricio
--

ALTER TABLE ONLY public.avaliacao_produto
    ADD CONSTRAINT avaliacao_produto_pkey PRIMARY KEY (id);


--
-- TOC entry 3394 (class 2606 OID 16401)
-- Name: categoria_produto categoria_produto_pkey; Type: CONSTRAINT; Schema: public; Owner: mauricio
--

ALTER TABLE ONLY public.categoria_produto
    ADD CONSTRAINT categoria_produto_pkey PRIMARY KEY (id);


--
-- TOC entry 3396 (class 2606 OID 16409)
-- Name: conta_receber conta_receber_pkey; Type: CONSTRAINT; Schema: public; Owner: mauricio
--

ALTER TABLE ONLY public.conta_receber
    ADD CONSTRAINT conta_receber_pkey PRIMARY KEY (id);


--
-- TOC entry 3398 (class 2606 OID 16417)
-- Name: conta_pagar conta_rpagar_pkey; Type: CONSTRAINT; Schema: public; Owner: mauricio
--

ALTER TABLE ONLY public.conta_pagar
    ADD CONSTRAINT conta_rpagar_pkey PRIMARY KEY (id);


--
-- TOC entry 3400 (class 2606 OID 16422)
-- Name: cupom_de_desconto cupom_de_desconto_pkey; Type: CONSTRAINT; Schema: public; Owner: mauricio
--

ALTER TABLE ONLY public.cupom_de_desconto
    ADD CONSTRAINT cupom_de_desconto_pkey PRIMARY KEY (id);


--
-- TOC entry 3402 (class 2606 OID 16430)
-- Name: endereco endereco_pkey; Type: CONSTRAINT; Schema: public; Owner: mauricio
--

ALTER TABLE ONLY public.endereco
    ADD CONSTRAINT endereco_pkey PRIMARY KEY (id);


--
-- TOC entry 3404 (class 2606 OID 16435)
-- Name: forma_pagamento forma_pagamento_pkey; Type: CONSTRAINT; Schema: public; Owner: mauricio
--

ALTER TABLE ONLY public.forma_pagamento
    ADD CONSTRAINT forma_pagamento_pkey PRIMARY KEY (id);


--
-- TOC entry 3410 (class 2606 OID 16578)
-- Name: imagem_produto imagem_produto_pkey; Type: CONSTRAINT; Schema: public; Owner: mauricio
--

ALTER TABLE ONLY public.imagem_produto
    ADD CONSTRAINT imagem_produto_pkey PRIMARY KEY (id);


--
-- TOC entry 3416 (class 2606 OID 16715)
-- Name: item_de_venda item_de_venda_pkey; Type: CONSTRAINT; Schema: public; Owner: mauricio
--

ALTER TABLE ONLY public.item_de_venda
    ADD CONSTRAINT item_de_venda_pkey PRIMARY KEY (id);


--
-- TOC entry 3406 (class 2606 OID 16440)
-- Name: marca_produto marca_produto_pkey; Type: CONSTRAINT; Schema: public; Owner: mauricio
--

ALTER TABLE ONLY public.marca_produto
    ADD CONSTRAINT marca_produto_pkey PRIMARY KEY (id);


--
-- TOC entry 3422 (class 2606 OID 16774)
-- Name: nota_fical_venda nota_fical_venda_pkey; Type: CONSTRAINT; Schema: public; Owner: mauricio
--

ALTER TABLE ONLY public.nota_fical_venda
    ADD CONSTRAINT nota_fical_venda_pkey PRIMARY KEY (id);


--
-- TOC entry 3420 (class 2606 OID 16756)
-- Name: nota_fiscal_compra nota_fiscal_compra_pkey; Type: CONSTRAINT; Schema: public; Owner: mauricio
--

ALTER TABLE ONLY public.nota_fiscal_compra
    ADD CONSTRAINT nota_fiscal_compra_pkey PRIMARY KEY (id);


--
-- TOC entry 3426 (class 2606 OID 16791)
-- Name: nota_item_produto nota_item_produto_pkey; Type: CONSTRAINT; Schema: public; Owner: mauricio
--

ALTER TABLE ONLY public.nota_item_produto
    ADD CONSTRAINT nota_item_produto_pkey PRIMARY KEY (id);


--
-- TOC entry 3438 (class 2606 OID 16903)
-- Name: pessoa_fisica pessoa_fisica_pkey; Type: CONSTRAINT; Schema: public; Owner: mauricio
--

ALTER TABLE ONLY public.pessoa_fisica
    ADD CONSTRAINT pessoa_fisica_pkey PRIMARY KEY (id);


--
-- TOC entry 3428 (class 2606 OID 16809)
-- Name: pessoa_juridica pessoa_juridica_pkey; Type: CONSTRAINT; Schema: public; Owner: mauricio
--

ALTER TABLE ONLY public.pessoa_juridica
    ADD CONSTRAINT pessoa_juridica_pkey PRIMARY KEY (id);


--
-- TOC entry 3430 (class 2606 OID 16817)
-- Name: produto produto_pkey; Type: CONSTRAINT; Schema: public; Owner: mauricio
--

ALTER TABLE ONLY public.produto
    ADD CONSTRAINT produto_pkey PRIMARY KEY (id);


--
-- TOC entry 3412 (class 2606 OID 16626)
-- Name: status_rastreio status_rastreio_pkey; Type: CONSTRAINT; Schema: public; Owner: mauricio
--

ALTER TABLE ONLY public.status_rastreio
    ADD CONSTRAINT status_rastreio_pkey PRIMARY KEY (id);


--
-- TOC entry 3434 (class 2606 OID 16856)
-- Name: venda uk905af0rg360u8rw12gbq0p3rh; Type: CONSTRAINT; Schema: public; Owner: mauricio
--

ALTER TABLE ONLY public.venda
    ADD CONSTRAINT uk905af0rg360u8rw12gbq0p3rh UNIQUE (nota_fiscal_venda_id);


--
-- TOC entry 3408 (class 2606 OID 16466)
-- Name: usurios_acesso ukdoimqmjqv7fcf54tau3bq14xk; Type: CONSTRAINT; Schema: public; Owner: mauricio
--

ALTER TABLE ONLY public.usurios_acesso
    ADD CONSTRAINT ukdoimqmjqv7fcf54tau3bq14xk UNIQUE (acesso_id);


--
-- TOC entry 3414 (class 2606 OID 16705)
-- Name: status_rastreio ukhg6tbyhgryeffdcf7ft99daoy; Type: CONSTRAINT; Schema: public; Owner: mauricio
--

ALTER TABLE ONLY public.status_rastreio
    ADD CONSTRAINT ukhg6tbyhgryeffdcf7ft99daoy UNIQUE (venda_id);


--
-- TOC entry 3424 (class 2606 OID 16776)
-- Name: nota_fical_venda ukqo2bhdkk5g3log9qsn41g1rfc; Type: CONSTRAINT; Schema: public; Owner: mauricio
--

ALTER TABLE ONLY public.nota_fical_venda
    ADD CONSTRAINT ukqo2bhdkk5g3log9qsn41g1rfc UNIQUE (venda_id);


--
-- TOC entry 3432 (class 2606 OID 16844)
-- Name: usuario usuario_pkey; Type: CONSTRAINT; Schema: public; Owner: mauricio
--

ALTER TABLE ONLY public.usuario
    ADD CONSTRAINT usuario_pkey PRIMARY KEY (id);


--
-- TOC entry 3436 (class 2606 OID 16854)
-- Name: venda venda_pkey; Type: CONSTRAINT; Schema: public; Owner: mauricio
--

ALTER TABLE ONLY public.venda
    ADD CONSTRAINT venda_pkey PRIMARY KEY (id);


--
-- TOC entry 3455 (class 2620 OID 16931)
-- Name: conta_receber validachavepessoa; Type: TRIGGER; Schema: public; Owner: mauricio
--

CREATE TRIGGER validachavepessoa BEFORE UPDATE ON public.conta_receber FOR EACH ROW EXECUTE FUNCTION public.validachavepessoa();


--
-- TOC entry 3461 (class 2620 OID 16932)
-- Name: endereco validachavepessoa; Type: TRIGGER; Schema: public; Owner: mauricio
--

CREATE TRIGGER validachavepessoa BEFORE UPDATE ON public.endereco FOR EACH ROW EXECUTE FUNCTION public.validachavepessoa();


--
-- TOC entry 3465 (class 2620 OID 16933)
-- Name: nota_fiscal_compra validachavepessoa; Type: TRIGGER; Schema: public; Owner: mauricio
--

CREATE TRIGGER validachavepessoa BEFORE UPDATE ON public.nota_fiscal_compra FOR EACH ROW EXECUTE FUNCTION public.validachavepessoa();


--
-- TOC entry 3467 (class 2620 OID 16943)
-- Name: usuario validachavepessoa; Type: TRIGGER; Schema: public; Owner: mauricio
--

CREATE TRIGGER validachavepessoa BEFORE UPDATE ON public.usuario FOR EACH ROW EXECUTE FUNCTION public.validachavepessoa();


--
-- TOC entry 3469 (class 2620 OID 16945)
-- Name: venda validachavepessoa; Type: TRIGGER; Schema: public; Owner: mauricio
--

CREATE TRIGGER validachavepessoa BEFORE UPDATE ON public.venda FOR EACH ROW EXECUTE FUNCTION public.validachavepessoa();


--
-- TOC entry 3463 (class 2620 OID 16937)
-- Name: avaliacao_produto validachavepessoa2; Type: TRIGGER; Schema: public; Owner: mauricio
--

CREATE TRIGGER validachavepessoa2 BEFORE INSERT ON public.avaliacao_produto FOR EACH ROW EXECUTE FUNCTION public.validachavepessoa();


--
-- TOC entry 3457 (class 2620 OID 16938)
-- Name: conta_pagar validachavepessoa2; Type: TRIGGER; Schema: public; Owner: mauricio
--

CREATE TRIGGER validachavepessoa2 BEFORE INSERT ON public.conta_pagar FOR EACH ROW EXECUTE FUNCTION public.validachavepessoa();


--
-- TOC entry 3456 (class 2620 OID 16940)
-- Name: conta_receber validachavepessoa2; Type: TRIGGER; Schema: public; Owner: mauricio
--

CREATE TRIGGER validachavepessoa2 BEFORE INSERT ON public.conta_receber FOR EACH ROW EXECUTE FUNCTION public.validachavepessoa();


--
-- TOC entry 3462 (class 2620 OID 16941)
-- Name: endereco validachavepessoa2; Type: TRIGGER; Schema: public; Owner: mauricio
--

CREATE TRIGGER validachavepessoa2 BEFORE INSERT ON public.endereco FOR EACH ROW EXECUTE FUNCTION public.validachavepessoa();


--
-- TOC entry 3466 (class 2620 OID 16942)
-- Name: nota_fiscal_compra validachavepessoa2; Type: TRIGGER; Schema: public; Owner: mauricio
--

CREATE TRIGGER validachavepessoa2 BEFORE INSERT ON public.nota_fiscal_compra FOR EACH ROW EXECUTE FUNCTION public.validachavepessoa();


--
-- TOC entry 3468 (class 2620 OID 16944)
-- Name: usuario validachavepessoa2; Type: TRIGGER; Schema: public; Owner: mauricio
--

CREATE TRIGGER validachavepessoa2 BEFORE INSERT ON public.usuario FOR EACH ROW EXECUTE FUNCTION public.validachavepessoa();


--
-- TOC entry 3470 (class 2620 OID 16946)
-- Name: venda validachavepessoa2; Type: TRIGGER; Schema: public; Owner: mauricio
--

CREATE TRIGGER validachavepessoa2 BEFORE INSERT ON public.venda FOR EACH ROW EXECUTE FUNCTION public.validachavepessoa();


--
-- TOC entry 3464 (class 2620 OID 16928)
-- Name: avaliacao_produto validachavepessoaavaliacaoproduto; Type: TRIGGER; Schema: public; Owner: mauricio
--

CREATE TRIGGER validachavepessoaavaliacaoproduto BEFORE UPDATE ON public.avaliacao_produto FOR EACH ROW EXECUTE FUNCTION public.validachavepessoa();


--
-- TOC entry 3458 (class 2620 OID 16929)
-- Name: conta_pagar validachavepessoacontapagar; Type: TRIGGER; Schema: public; Owner: mauricio
--

CREATE TRIGGER validachavepessoacontapagar BEFORE UPDATE ON public.conta_pagar FOR EACH ROW EXECUTE FUNCTION public.validachavepessoa();


--
-- TOC entry 3459 (class 2620 OID 16930)
-- Name: conta_pagar validachavepessoacontapagarpessoa_fornecedor_id; Type: TRIGGER; Schema: public; Owner: mauricio
--

CREATE TRIGGER validachavepessoacontapagarpessoa_fornecedor_id BEFORE UPDATE ON public.conta_pagar FOR EACH ROW EXECUTE FUNCTION public.validachavepessoa();


--
-- TOC entry 3460 (class 2620 OID 16939)
-- Name: conta_pagar validachavepessoacontapagarpessoa_fornecedor_id2; Type: TRIGGER; Schema: public; Owner: mauricio
--

CREATE TRIGGER validachavepessoacontapagarpessoa_fornecedor_id2 BEFORE INSERT ON public.conta_pagar FOR EACH ROW EXECUTE FUNCTION public.validachavepessoa();


--
-- TOC entry 3446 (class 2606 OID 16763)
-- Name: nota_fiscal_compra conta_pagar_fk; Type: FK CONSTRAINT; Schema: public; Owner: mauricio
--

ALTER TABLE ONLY public.nota_fiscal_compra
    ADD CONSTRAINT conta_pagar_fk FOREIGN KEY (conta_pagar_id) REFERENCES public.conta_pagar(id);


--
-- TOC entry 3450 (class 2606 OID 16872)
-- Name: venda cupom_desconto_fk; Type: FK CONSTRAINT; Schema: public; Owner: mauricio
--

ALTER TABLE ONLY public.venda
    ADD CONSTRAINT cupom_desconto_fk FOREIGN KEY (cupom_desconto_id) REFERENCES public.cupom_de_desconto(id);


--
-- TOC entry 3451 (class 2606 OID 16877)
-- Name: venda endereco_cobranca_fk; Type: FK CONSTRAINT; Schema: public; Owner: mauricio
--

ALTER TABLE ONLY public.venda
    ADD CONSTRAINT endereco_cobranca_fk FOREIGN KEY (endereco_cobranca_id) REFERENCES public.endereco(id);


--
-- TOC entry 3452 (class 2606 OID 16882)
-- Name: venda endereco_entrega_fk; Type: FK CONSTRAINT; Schema: public; Owner: mauricio
--

ALTER TABLE ONLY public.venda
    ADD CONSTRAINT endereco_entrega_fk FOREIGN KEY (endereco_entrega_id) REFERENCES public.endereco(id);


--
-- TOC entry 3453 (class 2606 OID 16892)
-- Name: venda forma_pagamento_fk; Type: FK CONSTRAINT; Schema: public; Owner: mauricio
--

ALTER TABLE ONLY public.venda
    ADD CONSTRAINT forma_pagamento_fk FOREIGN KEY (forma_pagamento_id) REFERENCES public.forma_pagamento(id);


--
-- TOC entry 3448 (class 2606 OID 16792)
-- Name: nota_item_produto nota_fiscal_compra_fk; Type: FK CONSTRAINT; Schema: public; Owner: mauricio
--

ALTER TABLE ONLY public.nota_item_produto
    ADD CONSTRAINT nota_fiscal_compra_fk FOREIGN KEY (nota_fiscal_compra_id) REFERENCES public.nota_fiscal_compra(id);


--
-- TOC entry 3454 (class 2606 OID 16887)
-- Name: venda nota_fiscal_venda_fk; Type: FK CONSTRAINT; Schema: public; Owner: mauricio
--

ALTER TABLE ONLY public.venda
    ADD CONSTRAINT nota_fiscal_venda_fk FOREIGN KEY (nota_fiscal_venda_id) REFERENCES public.nota_fical_venda(id);


--
-- TOC entry 3445 (class 2606 OID 16818)
-- Name: avaliacao_produto produto_fk; Type: FK CONSTRAINT; Schema: public; Owner: mauricio
--

ALTER TABLE ONLY public.avaliacao_produto
    ADD CONSTRAINT produto_fk FOREIGN KEY (produto_id) REFERENCES public.produto(id);


--
-- TOC entry 3441 (class 2606 OID 16823)
-- Name: imagem_produto produto_fk; Type: FK CONSTRAINT; Schema: public; Owner: mauricio
--

ALTER TABLE ONLY public.imagem_produto
    ADD CONSTRAINT produto_fk FOREIGN KEY (produto_id) REFERENCES public.produto(id);


--
-- TOC entry 3443 (class 2606 OID 16828)
-- Name: item_de_venda produto_fk; Type: FK CONSTRAINT; Schema: public; Owner: mauricio
--

ALTER TABLE ONLY public.item_de_venda
    ADD CONSTRAINT produto_fk FOREIGN KEY (produto_id) REFERENCES public.produto(id);


--
-- TOC entry 3449 (class 2606 OID 16833)
-- Name: nota_item_produto produto_fk; Type: FK CONSTRAINT; Schema: public; Owner: mauricio
--

ALTER TABLE ONLY public.nota_item_produto
    ADD CONSTRAINT produto_fk FOREIGN KEY (produto_id) REFERENCES public.produto(id);


--
-- TOC entry 3439 (class 2606 OID 16477)
-- Name: usurios_acesso scesso_fk; Type: FK CONSTRAINT; Schema: public; Owner: mauricio
--

ALTER TABLE ONLY public.usurios_acesso
    ADD CONSTRAINT scesso_fk FOREIGN KEY (acesso_id) REFERENCES public.acesso(id);


--
-- TOC entry 3440 (class 2606 OID 16845)
-- Name: usurios_acesso usuario_fk; Type: FK CONSTRAINT; Schema: public; Owner: mauricio
--

ALTER TABLE ONLY public.usurios_acesso
    ADD CONSTRAINT usuario_fk FOREIGN KEY (usuario_id) REFERENCES public.usuario(id);


--
-- TOC entry 3444 (class 2606 OID 16857)
-- Name: item_de_venda venda_fk; Type: FK CONSTRAINT; Schema: public; Owner: mauricio
--

ALTER TABLE ONLY public.item_de_venda
    ADD CONSTRAINT venda_fk FOREIGN KEY (venda_id) REFERENCES public.venda(id);


--
-- TOC entry 3447 (class 2606 OID 16862)
-- Name: nota_fical_venda venda_fk; Type: FK CONSTRAINT; Schema: public; Owner: mauricio
--

ALTER TABLE ONLY public.nota_fical_venda
    ADD CONSTRAINT venda_fk FOREIGN KEY (venda_id) REFERENCES public.venda(id);


--
-- TOC entry 3442 (class 2606 OID 16867)
-- Name: status_rastreio venda_fk; Type: FK CONSTRAINT; Schema: public; Owner: mauricio
--

ALTER TABLE ONLY public.status_rastreio
    ADD CONSTRAINT venda_fk FOREIGN KEY (venda_id) REFERENCES public.venda(id);


-- Completed on 2026-04-12 01:37:06 -03

--
-- PostgreSQL database dump complete
--

\unrestrict ykpe4nkQVnFK2dy8lxvS123EKKBeDE2UqQSVV4IdtW7BvLv9BORr2vgUozeimAq
