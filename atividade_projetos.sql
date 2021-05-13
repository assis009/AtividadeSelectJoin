create database projetos 

go 

use projetos 


CREATE TABLE projects (
id				INT			NOT NULL	IDENTITY(10001,1),
name			VARCHAR(45)	NOT NULL,
description		VARCHAR(45)	NULL,
date			VARCHAR(45)	NOT NULL
PRIMARY KEY(id)
)

go 

drop table users
CREATE TABLE users (
id				INT			NOT NULL	IDENTITY,
name			VARCHAR(45)	NOT NULL,
username		VARCHAR(45)	NOT NULL	UNIQUE,
password		VARCHAR(45)	NOT NULL	DEFAULT('mudar123'),
email			VARCHAR(45)	NOT NULL
PRIMARY KEY(id)
)

go

drop table users_has_projects

CREATE TABLE users_has_projects (
users_id	INT		NOT NULL,
projects_id	INT		NOT NULL

PRIMARY KEY(users_id,projects_id)

FOREIGN KEY(users_id) REFERENCES users(id),
FOREIGN KEY(projects_id) REFERENCES projects(id)
)



ALTER TABLE projects
ALTER COLUMN date DATE NOT NULL 
 
ALTER TABLE projects
ADD CONSTRAINT chk_dt CHECK(date > '2014-09-01')
 
exec sp_help users

ALTER TABLE users
DROP CONSTRAINT UQ__users__F3DBC572BAA1803F
 
ALTER TABLE users
ALTER COLUMN username VARCHAR(10) NOT NULL
 
ALTER TABLE users
ADD CONSTRAINT UQ__users__F3DBC572BAA1803F UNIQUE(username)
 
 
ALTER TABLE users
ALTER COLUMN password VARCHAR(8) NOT NULL

select*from users

INSERT INTO users VALUES
('Maria', 'Rh_maria', '123mudar', 'maria@empresa.com'),
('Paulo','Ti_paulo','123@456','paulo@empresa.com'),
('Ana','Rh_ana','123mudar','ana@empresa.com'),
('Clara','Ti_clara','123mudar','clara@empresa.com'),
('Aparecido','Rh_apareci','55@!cido','aparecido@empresa.com')

select*from projects
 

INSERT INTO projects VALUES
('Re-folha','Refatoração das Folhas','2014-09-05'),
('Manutenção PCs','Manutenção PCs','2014-09-05'),
('Auditoria', NULL, '2014-09-07')

select*from users_has_projects

INSERT INTO users_has_projects (users_id, projects_id)VALUES
(1, 10001),
(5, 10001),
(3, 10003),
(4, 10002),
(2, 10002)
 
UPDATE projects
SET date = '2014-09-12'
WHERE id = 10002
 
UPDATE users 
SET username = 'Rh_cido'
WHERE name = 'Aparecido'
 
UPDATE users 
SET password = '888@*'
WHERE username = 'Rh_maria' AND password = '123mudar'
 
DELETE users_has_projects
WHERE users_id = 2 AND projects_id = 10002
 
SELECT * FROM users
SELECT * FROM projects
SELECT * FROM users_has_projects


INSERT INTO users VALUES ( 'Joao', 'Ti_joao', '123mudar', 'joao@empresa.com')

INSERT INTO projects VALUES ('Atualização de Sistemas',' Modificação de Sistemas Operacionais nos PCs',' 12/09/2014')


--SQL3:
SELECT users.id, users.name, users.email, 
		projects.id, projects.name, projects.description, projects.date
FROM users, projects, users_has_projects
WHERE users.id = users_has_projects.users_id
	--AND projects.id = users_has_projects.projects_id
	AND  projects.name LIKE 'Re-folha'
	ORDER BY users.name

-- SQL2:
SELECT users.id, users.name, users.email, 
		projects.id, projects.name, projects.description, projects.date
FROM users INNER JOIN users_has_projects
ON users.id = users_has_projects.users_id
INNER JOIN projects
ON projects.id = users_has_projects.projects_id
WHERE projects.name LIKE 'Re-folha'
ORDER BY users.name



SELECT projects.name
FROM projects LEFT OUTER JOIN users_has_projects
ON projects.id = users_has_projects.projects_id
WHERE users_has_projects.users_id IS NULL


SELECT users.name
FROM users LEFT OUTER JOIN users_has_projects
ON users.id = users_has_projects.users_id
WHERE users_has_projects.projects_id IS NULL
