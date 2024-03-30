--Cria a tabela habilidades
create table public.habilidades(
	hab_cd_id serial primary key not null,
	hab_tx_nome_hab varchar(20) not null,
	hab_tx_descricao varchar(100) not null
);

-- Cria a tabela recrutador
create table public.recrutador(
	rec_cd_id serial primary key not null,
	rec_tx_nome varchar(30) not null,
	rec_tx_cpf varchar(16) not null
);

-- Cria a tabela residentes
create table public.residentes(
	res_cd_id serial primary key not null,
	res_tx_nome varchar(50) not null,
	res_tx_cpf varchar(16) not null unique,
	res_tx_email varchar(50) not null,
	res_tx_data_nascimento date not null,
	res_tx_formacao varchar(30),
	res_fk_rec int4 unique, -- Opcional, porque pode ou não ser recrutado, ao final da residência
	foreign key (res_fk_rec) references recrutador(rec_cd_id)
);

-- Cria tabela de ligação de habilidades e residentes
create table public.habilidades_residentes(
	habres_cd_id serial primary key,
	habres_fk_hab int4 not null,
	habres_fk_res int4 not null,
	foreign key (habres_fk_hab) references habilidades(hab_cd_id),
	foreign key (habres_fk_res) references residentes(res_cd_id)
);

-- Inserts na tabela Habilidades
insert into habilidades (hab_cd_id, hab_tx_nome_hab, hab_tx_descricao)
values
(1,'HTML5', 'Proficiência na linguagem de marcação HTML5'),
(2,'Desenvolvimento Web', 'Proficiência em HTML5, CSS e Javascript'),
(3,'React', 'Habilidade no framework e tecnologias associadas'),
(4,'Product Owner', 'Habilidade e/ou experiência como Product Owner'),
(5,'Banco de dados', 'Conceitos de criação e manipulação de dados, linguagem SQL '),
(6, 'Python', 'Linguagem de programação versátil e poderosa'),
(7, 'Java', 'Linguagem de programação amplamente utilizada para desenvolvimento de aplicativos'),
(8, 'Machine Learning', 'Capacidade de criar modelos e sistemas que aprendem a partir de dados'),
(9, 'UX/UI Design', 'Design de interfaces de usuário e experiência do usuário'),
(10, 'Git', 'Sistema de controle de versão distribuído');

-- Inserts na tabela Residentes
insert into residentes (
res_cd_id, 
res_tx_nome, 
res_tx_cpf, 
res_tx_email,
res_tx_data_nascimento, 
res_tx_formacao) values
(1, 'João Silva', '123.456.789-00', 'joao@example.com', '1990-05-15', 'Engenharia Civil'),
(2, 'Maria Souza', '987.654.321-00', 'maria@example.com', '1985-10-20', 'Análise de Sistemas'),
(3, 'Pedro Oliveira', '456.789.123-00', 'pedro@example.com', '1992-03-12', 'Tecnologia da Informação'),
(4, 'Ana Santos', '321.654.987-00', 'ana@example.com', '1995-07-25', 'Técnico em Laboratório'),
(5, 'Carlos Ferreira', '654.321.987-00', 'carlos@example.com', '1988-12-30', 'Professor de Matemática'),
(6, 'Fernanda Lima', '789.123.456-00', 'fernanda@example.com', '1993-09-05', 'Administração de Empresas'),
(7, 'Rafaela Pereira', '159.357.852-00', 'rafaela@example.com', '1998-04-18', 'Engenharia Elétrica'),
(8, 'Lucas Oliveira', '456.123.789-00', 'lucas@example.com', '1991-06-20', 'Ciência da Computação'),
(9, 'Amanda Santos', '852.741.963-00', 'amanda@example.com', '1996-11-10', 'Arquitetura e Urbanismo'),
(10, 'Rodrigo Silva', '369.258.147-00', 'rodrigo@example.com', '1987-08-15', 'Direito');


-- Insert na tabela Recrutador
insert into recrutador (
rec_cd_id, 
rec_tx_nome, 
rec_tx_cpf) values
(1, 'Recrutador Niko', '123.456.789-01'),
(2, 'Recrutadora AlterTable', '123.456.789-02'),
(3, 'Recrutador T2M', '123.456.789-03'),
(4, 'Recrutador Beast2be', '123.456.789-04'),
(5, 'Recrutador Torange', '123.456.789-05'),
(6, 'Recrutadora TechPro', '123.456.789-06'),
(7, 'Recrutador MegaTalentos', '123.456.789-07'),
(8, 'Recrutadora SmartRecruit', '123.456.789-08'),
(9, 'Recrutador ExpertRH', '123.456.789-09'),
(10, 'Recrutador TopTalent', '123.456.789-10');

-- Tabela de relação muitos pra muitos
insert into habilidades_residentes (
habres_cd_id,
habres_fk_hab, -- Pegar um id que bate com algum item da tabela de habilidades
habres_fk_res -- Pegar um id que bate com algum item da tabela de residentes
) values
(1, 5, 8),
(2, 7, 4),
(3, 7, 8),
(4, 4, 4),
(5, 2, 9);

select * from residentes;
select * from habilidades;

-- Pega todas as turma em que o aluno de id 8 está
-- Lucas Oliveira, id = 8
select 
r.res_tx_nome,
h.hab_tx_nome_hab
from residentes r
join habilidades_residentes hr on r.res_cd_id = hr.habres_fk_res
join habilidades h on h.hab_cd_id = hr.habres_fk_hab
where r.res_cd_id = 8;

-- Consulta para verificar quantas habilidades um residente possui
select r.res_tx_nome, count(hr.habres_fk_hab) as total_de_habilidades
from residentes r
join habilidades_residentes hr on r.res_cd_id = hr.habres_fk_res
join habilidades h on h.hab_cd_id = hr.habres_fk_hab
group by r.res_tx_nome;

-- Consulta para saber o total de residentes por habilidade
select h.hab_tx_nome_hab, count(hr.habres_fk_res) as total_de_habilidades
from habilidades h
join habilidades_residentes hr on h.hab_cd_id = hr.habres_fk_hab
join residentes r on r.res_cd_id = hr.habres_fk_res
group by h.hab_tx_nome_hab;