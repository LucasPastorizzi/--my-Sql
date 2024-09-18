SELECT * FROM mysql.user;


CREATE ROLE 'app_relatorio','app_funcionario';

GRANT SELECT ON uc4atividades.* TO 'app_relatorio';
GRANT SELECT,INSERT,UPDATE,DELETE ON produto.* TO 'app_funcionario';
GRANT SELECT,INSERT,UPDATE,DELETE ON cliente.* TO 'app_funcionario';
GRANT SELECT,INSERT,UPDATE,DELETE ON venda.* TO 'app_funcionario';


CREATE USER 'user_relatorio'@'localhost' IDENTIFIED BY '324112';
CREATE USER 'user_funcionario'@'localhost'IDENTIFIED BY '31911';


GRANT 'app_relatorio' TO 'user_relatorio'@'localhost';
GRANT 'app_funcionario' TO 'user_funcionario'@'localhost';
GRANT 'app_funcionario' TO 'user_funcionario'@'localhost';
GRANT 'app_funcionario' TO 'user_funcionario'@'localhost';

