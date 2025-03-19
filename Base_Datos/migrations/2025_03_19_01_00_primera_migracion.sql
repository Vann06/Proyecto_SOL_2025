CREATE TABLE IF NOT EXISTS atributos_producto (
    id INT PRIMARY KEY AUTO_INCREMENT,
    talla ENUM('M', 'L', 'Única') NOT NULL,
    id_producto INT NOT NULL,
    id_material INT NOT NULL,
    FOREIGN KEY (id_producto) REFERENCES productos(id),
    FOREIGN KEY (id_material) REFERENCES materiales(id)
);

-- 2. Tabla de Detalle de Productos
CREATE TABLE IF NOT EXISTS detalle_producto (
    id INT PRIMARY KEY AUTO_INCREMENT,
    id_producto INT NOT NULL,
    stock INT NOT NULL,
    precio DECIMAL(10,2) NOT NULL,
    id_usuario INT,
    FOREIGN KEY (id_producto) REFERENCES productos(id),
    FOREIGN KEY (id_usuario) REFERENCES usuarios(id)
);

-- Agregamos los CHECK de stock y precio (MySQL a veces no aplica strict, pero los dejamos para documentación).
ALTER TABLE detalle_producto
  MODIFY COLUMN stock INT NOT NULL CHECK (stock >= 0),
  MODIFY COLUMN precio DECIMAL(10,2) NOT NULL CHECK (precio >= 0);

-- 3. Tabla de Pedidos
CREATE TABLE IF NOT EXISTS pedidos (
    id INT PRIMARY KEY AUTO_INCREMENT,
    id_usuario INT NOT NULL,
    fecha_pedido DATETIME DEFAULT CURRENT_TIMESTAMP,
    estado ENUM('Imprimiendo', 'Pintando', 'Enviando', 'Entregado') NOT NULL,
    FOREIGN KEY (id_usuario) REFERENCES usuarios(id)
);

-- 4. Tabla de Detalle de Pedidos
CREATE TABLE IF NOT EXISTS detalle_pedidos (
    id INT PRIMARY KEY AUTO_INCREMENT,
    id_pedido INT NOT NULL,
    id_detalle_producto INT NOT NULL,
    cantidad INT NOT NULL,
    precio_unitario DECIMAL(10,2) NOT NULL,
    FOREIGN KEY (id_pedido) REFERENCES pedidos(id),
    FOREIGN KEY (id_detalle_producto) REFERENCES detalle_producto(id)
);

-- Agregamos los CHECK de cantidad y precio_unitario
ALTER TABLE detalle_pedidos
  MODIFY COLUMN cantidad INT NOT NULL CHECK (cantidad > 0),
  MODIFY COLUMN precio_unitario DECIMAL(10,2) NOT NULL CHECK (precio_unitario > 0);

-- 5. Tabla de Pagos
CREATE TABLE IF NOT EXISTS pagos (
    id INT PRIMARY KEY AUTO_INCREMENT,
    id_pedido INT NOT NULL,
    monto DECIMAL(10,2) NOT NULL,
    metodo_pago ENUM('visa', 'mastercard', 'american_express') NOT NULL,
    estado ENUM('pendiente', 'completado', 'fallido') NOT NULL,
    FOREIGN KEY (id_pedido) REFERENCES pedidos(id)
);

-- Agregamos el CHECK de monto
ALTER TABLE pagos
  MODIFY COLUMN monto DECIMAL(10,2) NOT NULL CHECK (monto > 0);

-- 6. Tabla de Envíos
CREATE TABLE IF NOT EXISTS envios (
    id INT PRIMARY KEY AUTO_INCREMENT,
    id_pedido INT UNIQUE NULL,
    id_direccion INT NOT NULL,
    fecha_envio DATETIME,
    FOREIGN KEY (id_pedido) REFERENCES pedidos(id),
    FOREIGN KEY (id_direccion) REFERENCES direcciones(id)
);

-- 7. Tabla de Carrito de Compras
CREATE TABLE IF NOT EXISTS carrito_compras (
    id INT PRIMARY KEY AUTO_INCREMENT,
    id_usuario INT UNIQUE NOT NULL,
    FOREIGN KEY (id_usuario) REFERENCES usuarios(id)
);

-- 8. Tabla de Detalle de Carrito
CREATE TABLE IF NOT EXISTS detalle_carrito (
    id INT PRIMARY KEY AUTO_INCREMENT,
    id_carrito INT NOT NULL,
    id_detalle_producto INT NOT NULL,
    cantidad INT NOT NULL,
    FOREIGN KEY (id_carrito) REFERENCES carrito_compras(id),
    FOREIGN KEY (id_detalle_producto) REFERENCES detalle_producto(id)
);

-- Agregar el CHECK de cantidad
ALTER TABLE detalle_carrito
  MODIFY COLUMN cantidad INT NOT NULL CHECK (cantidad > 0);

-- 9. Tabla de Historial de Ventas
CREATE TABLE IF NOT EXISTS historial_ventas (
    id INT PRIMARY KEY AUTO_INCREMENT,
    id_pedido INT UNIQUE NOT NULL,
    fecha_venta DATETIME DEFAULT CURRENT_TIMESTAMP,
    monto_total DECIMAL(10,2) NOT NULL,
    FOREIGN KEY (id_pedido) REFERENCES pedidos(id)
);

-- CHECK para monto_total
ALTER TABLE historial_ventas
  MODIFY COLUMN monto_total DECIMAL(10,2) NOT NULL CHECK (monto_total > 0);

-- 10. Tabla de Inventario
CREATE TABLE IF NOT EXISTS inventario (
    id INT PRIMARY KEY AUTO_INCREMENT,
    id_detalle_producto INT UNIQUE NOT NULL,
    stock_actual INT NOT NULL,
    cantidad_en_produccion INT NOT NULL,
    fecha_actualizacion DATETIME DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (id_detalle_producto) REFERENCES detalle_producto(id)
);

-- CHECKs para inventario
ALTER TABLE inventario
  MODIFY COLUMN stock_actual INT NOT NULL CHECK (stock_actual >= 0),
  MODIFY COLUMN cantidad_en_produccion INT NOT NULL CHECK (cantidad_en_produccion >= 0);

ALTER TABLE productos
  MODIFY COLUMN precio_base DECIMAL(10,2) NOT NULL CHECK (precio_base > 0);
  
ALTER TABLE productos
ADD COLUMN imagen_url VARCHAR(255) NULL;
