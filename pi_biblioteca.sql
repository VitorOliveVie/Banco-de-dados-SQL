show databases;

create database Bibliotecasenac;

use Bibliotecasenac;

show tables;

create table tb_editora
(
id_editora int primary key not null,
nome varchar(80) not null
);

create table tb_autor
(
id_autor int primary key not null,
nome varchar(80) not null,
sinopse text
);

create table tb_obra
(
ISBN varchar(13) primary key not null,
nome varchar(80) not null,
id_editora int not null,
sinopse text not null,
foreign key (id_editora) references tb_editora (id_editora)
);

alter table tb_obra add column id_editora int not null;

alter table tb_obra add foreign key (id_editora) references tb_editora (id_editora);

show tables;

desc tb_obra;

create table tb_classificacao
(
cod_cdd varchar(3) primary key not null,
nome varchar(80) not null
);

create table tb_locador
(
CPF varchar(11) primary key not null,
RG varchar(11) not null,
dt_nascimento date not null,
nome varchar(80) not null,
email varchar(100) not null,
telefone varchar(11) not null
);

create table tb_emprestimo
(
num_emprestimo int primary key not null,
dtehr_emp datetime not null,
dtehr_devol datetime not null,
multa boolean default false,
CPF varchar(11) not null,
foreign key (CPF) references tb_locador (CPF)
);

create table rl_obra_autor
(
ISBN varchar(13) NOT NULL,
id_autor int not null,
primary key (ISBN,id_autor),
foreign key (ISBN) references tb_obra (ISBN),
foreign key (id_autor) references tb_autor (id_autor)
);

show tables;

create table tb_exemplar 
(
num_exemplar int not null,
dt_entrada date not null,
qtde_exempls int not null,
ISBN varchar(14) not null,
cod_cdd varchar(3) not null,
primary key (num_exemplar,ISBN),
foreign key (ISBN) references tb_obra (ISBN),
foreign key (cod_cdd) references tb_classificacao (cod_cdd)
);

create table rl_exemplar_emprestimo
(
num_exemplar int not null,
num_emprestimo int not null,
primary key (num_exemplar, num_emprestimo),
foreign key (num_exemplar) references tb_exemplar (num_exemplar),
foreign key (num_emprestimo) references tb_emprestimo (num_emprestimo)
);

create table tb_estado
(
UF char(2) primary key not null,
nome varchar(80) not null
);

create table tb_cidade
(
id_cidade int primary key not null,
nome varchar(80) not null,
UF char(2) not null,
foreign key (UF) references tb_estado (UF)
);

create table tb_endereco
(
id_endereco int primary key not null,
CEP varchar(8) not null,
logradouro varchar(80) not null,
numero varchar(45) not null,
bairro varchar(80) not null,
CPF varchar(11) not null,
id_cidade int not null,
foreign key (CPF) references tb_locador (CPF),
foreign key (id_cidade) references tb_cidade (id_cidade)
);
select * from tb_exemplar;

alter table tb_exemplar add column cod_cdd varchar(3) not null;

alter table tb_exemplar add foreign key (cod_cdd) references tb_classificacao (cod_cdd);

alter table tb_exemplar modify column cod_cdd varchar(3) not null;

insert into tb_classificacao (cod_cdd, nome) values
('000', 'generalidades'),
('100', 'Filosofia e psicologia'),
('200', 'religião'),
('300', 'Ciências sociais'),
('400', 'Línguas'),
('500', 'Ciências Naturais e matemática'),
('600', 'Tecnologia (Ciências aplicadas)'),
('700', 'Artes'),
('800', 'Literatura e retórica'),
('900', 'Geografia e história');

select * from tb_classificacao;