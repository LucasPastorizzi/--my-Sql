USE `uc4atividades`;



DELIMITER //

CREATE PROCEDURE compras_realizadas ()

BEGINn
   SELECT c.id,c.cpf,c.nome FROM cliente c INNER JOIN venda v on c.id = v.cliente_id
END


DELIMITER ;








DELIMITER //

CREATE PROCEDURE ListarComprasCliente (
    IN p_IdCliente INT,
    IN p_DataInicial DATETIME,
    IN p_DataFinal DATETIME
)
BEGIN
    SELECT
        c.nome AS NomeCliente,
        v.id AS IdCompra,
        v.valor_total AS Total,
        iv.nome_produto AS NomeProduto,
        iv.quantidade AS Quantidade,
        iv.valor_unitario AS ValorUnitario,
        iv.subtotal AS Subtotal
    FROM
        venda v
    INNER JOIN
        cliente c ON v.cliente_id = c.id
    INNER JOIN
        item_venda iv ON v.id = iv.venda_id
    WHERE
        v.cliente_id = p_IdCliente
        AND v.data BETWEEN p_DataInicial AND p_DataFinal
    ORDER BY
        v.id, iv.nome_produto;
END //

DELIMITER ;


CALL ListarComprasCliente(
    1,                        
    '2023-05-01 00:00:00',   
    '2024-12-31 23:59:59'     
);









//////////////////////////





DELIMITER //

CREATE FUNCTION VerificarStatusCliente(p_IdCliente INT)
RETURNS VARCHAR(10)
DETERMINISTIC
BEGIN
    DECLARE total_compras DECIMAL(9,2);
    DECLARE status_cliente VARCHAR(10);

    SELECT COALESCE(SUM(valor_total), 0) INTO total_compras
    FROM venda
    WHERE cliente_id = p_IdCliente;

    IF total_compras > 10000 THEN
        SET status_cliente = 'PREMIUM';
    ELSE
        SET status_cliente = 'REGULAR';
    END IF;

    RETURN status_cliente;
END //

-- Restaurar delimitador padrão
DELIMITER ;


-- chamar cliente especificooo


SHOW FUNCTION STATUS WHERE Name = 'VerificarStatusCliente';




-- TRIGGER 



DELIMITER //

CREATE TRIGGER BeforeInsertUsuario
BEFORE INSERT ON usuario
FOR EACH ROW
BEGIN
    
    SET NEW.senha = MD5(NEW.senha);
END //


DELIMITER ;


INSERT INTO usuario (login, senha) VALUES ('usuario_teste', 'senha123');

SELECT login, senha FROM usuario WHERE login = 'usuario_teste';

