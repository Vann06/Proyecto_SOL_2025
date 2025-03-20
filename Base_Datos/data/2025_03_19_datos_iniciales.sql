USE tienda;

-- 1. Insertar Roles
INSERT INTO roles (nombre) VALUES 
('Administrador'), ('Diseñador 3D'), ('Cliente');

-- 2. Insertar Usuarios 
INSERT INTO usuarios (nombre, apellido, correo, contrasena, fecha_registro, id_rol) VALUES 
('Diego', 'López', 'diego@solstore.com', 'admin123', NOW(), 1), 
('Andrea', 'Pérez', 'andrea@solstore.com', 'design3d', NOW(), 2),
('Mario', 'Hernández', 'mario@solstore.com', 'design3d', NOW(), 2),
('Luis', 'Fernández', 'luis@gmail.com', 'cliente123', NOW(), 3),
('Claudia', 'Martínez', 'claudia@gmail.com', 'cliente123', NOW(), 3),
('Ricardo', 'Gómez', 'ricardo@gmail.com', 'cliente123', NOW(), 3),
('Alejandra', 'Mendoza', 'alejandra@gmail.com', 'cliente123', NOW(), 3),
('Fernando', 'Ruiz', 'fernando@gmail.com', 'cliente123', NOW(), 3),
('Jessica', 'Castro', 'jessica@gmail.com', 'cliente123', NOW(), 3),
('Carlos', 'Santos', 'carlos@gmail.com', 'cliente123', NOW(), 3);

-- 3. Insertar Departamentos de Guatemala
INSERT INTO departamentos (nombre) VALUES 
('Guatemala'), ('Sacatepéquez'), ('Escuintla'), ('Quetzaltenango'), ('Alta Verapaz'),
('Jalapa'), ('Chimaltenango'), ('Petén'), ('Santa Rosa'), ('Izabal');

-- 4. Insertar Municipios de Guatemala
INSERT INTO municipios (nombre, id_departamento, codigo_postal) VALUES 
('Ciudad de Guatemala', 1, '01001'),
('Mixco', 1, '01057'),
('Antigua Guatemala', 2, '03001'),
('Escuintla', 3, '05001'),
('Quetzaltenango', 4, '09001'),
('Cobán', 5, '16001'),
('Jalapa', 6, '21001'),
('Chimaltenango', 7, '04001'),
('Flores', 8, '17001'),
('Cuilapa', 9, '06001');

-- 5. Insertar Direcciones
INSERT INTO direcciones (id_usuario, direccion, id_municipio) VALUES 
(4, 'Zona 10, Ciudad de Guatemala', 1),
(5, 'Centro Histórico, Antigua Guatemala', 3),
(6, 'Barrio El Centro, Escuintla', 4),
(7, 'Zona 3, Quetzaltenango', 5),
(8, 'Barrio El Calvario, Cobán', 6),
(9, 'Calle Principal, Jalapa', 7),
(10, 'Avenida Reforma, Chimaltenango', 8);

-- 6. Insertar Categorías
INSERT INTO categorias (nombre) VALUES 
('Cosplay'), ('Figuras'), ('Ropa'), ('Llaveros'), ('Combos');

-- 7. Insertar Temáticas
INSERT INTO tematicas (nombre) VALUES 
('Películas'), ('Anime'), ('Pokémon'), ('Cómics'), ('Videojuegos');

-- 8. Insertar Productos
INSERT INTO productos (nombre, id_categoria, id_tematica, descripcion, precio_base) VALUES 
('Figura Iron Man', 2, 1, 'Figura coleccionable de Iron Man en 3D', 250.00),
('Traje Spider-Man', 1, 4, 'Cosplay de Spider-Man', 180.00),
('Figura Naruto', 2, 2, 'Figura personalizada de Naruto Uzumaki', 230.00),
('Llaveros Zelda', 4, 5, 'Set de llaveros inspirados en Zelda', 80.00),
('Figura Vegeta', 2, 2, 'Figura de Vegeta con detalles únicos', 280.00),
('Camiseta Star Wars', 3, 1, 'Camiseta temática de Star Wars', 120.00),
('Figura Goku', 2, 2, 'Figura de Goku Super Saiyan', 260.00),
('Combo Marvel', 5, 4, 'Combo de productos Marvel', 400.00),
('Figura Pikachu', 2, 3, 'Figura coleccionable de Pikachu', 200.00),
('Llaveros One Piece', 4, 2, 'Llaveros con personajes de One Piece', 70.00);

-- 9. Insertar Materiales
INSERT INTO materiales (nombre) VALUES 
('PLA'), ('ABS'), ('Resina'), ('Filamento Flexible'), ('Metal'), ('Madera');

-- 10. Insertar Detalle de Productos
INSERT INTO detalle_producto (id_producto, stock, precio, id_usuario) VALUES 
(1, 15, 250.00, 2),
(2, 20, 180.00, 2),
(3, 10, 230.00, 2),
(4, 30, 80.00, 2),
(5, 8, 280.00, 2),
(6, 25, 120.00, 2),
(7, 12, 260.00, 2),
(8, 5, 400.00, 2),
(9, 18, 200.00, 2),
(10, 25, 70.00, 2);

-- 11. Insertar Pedidos
INSERT INTO pedidos (id_usuario, fecha_pedido, estado) VALUES 
(4, NOW(), 'Imprimiendo'),
(5, NOW(), 'Pintando'),
(6, NOW(), 'Enviando'),
(7, NOW(), 'Entregado'),
(8, NOW(), 'Imprimiendo'),
(9, NOW(), 'Enviando'),
(10, NOW(), 'Entregado');

-- 12. Insertar Pagos
INSERT INTO pagos (id_pedido, monto, metodo_pago, estado) VALUES 
(1, 250.00, 'visa', 'completado'),
(2, 160.00, 'mastercard', 'pendiente'),
(3, 230.00, 'visa', 'fallido');

-- 13. Insertar Carritos de Compras
INSERT INTO carrito_compras (id_usuario) VALUES 
(4), (5), (6), (7), (8), (9), (10);

-- 14. Insertar Historial de Ventas
INSERT INTO historial_ventas (id_pedido, fecha_venta, monto_total) VALUES 
(1, NOW(), 250.00),
(2, NOW(), 160.00),
(4, NOW(), 300.00),
(5, NOW(), 560.00);

-- 15. Insertar Inventario
INSERT INTO inventario (id_detalle_producto, stock_actual, cantidad_en_produccion, fecha_actualizacion) VALUES 
(1, 14, 5, NOW()),
(2, 19, 10, NOW()),
(3, 9, 3, NOW()),
(4, 29, 5, NOW()),
(5, 7, 8, NOW());

