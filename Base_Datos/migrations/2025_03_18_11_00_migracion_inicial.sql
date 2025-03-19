CREATE DATABASE IF NOT EXISTS tienda;
USE tienda;

-- Tabla de Roles
CREATE TABLE roles (
    id INT PRIMARY KEY AUTO_INCREMENT,
    nombre VARCHAR(100) UNIQUE NOT NULL
);

-- Tabla de Usuarios
CREATE TABLE usuarios (
    id INT PRIMARY KEY AUTO_INCREMENT,
    nombre VARCHAR(100) NOT NULL,
    apellido VARCHAR(100) NOT NULL,
    correo VARCHAR(255) UNIQUE NOT NULL,
    contrasena VARCHAR(255) NOT NULL,
    fecha_registro DATETIME DEFAULT CURRENT_TIMESTAMP,
    id_rol INT,
    FOREIGN KEY (id_rol) REFERENCES roles(id)
);

-- Tabla de Departamentos
CREATE TABLE departamentos (
    id INT PRIMARY KEY AUTO_INCREMENT,
    nombre VARCHAR(100) UNIQUE NOT NULL
);

-- Tabla de Municipios
CREATE TABLE municipios (
    id INT PRIMARY KEY AUTO_INCREMENT,
    nombre VARCHAR(100) NOT NULL,
    id_departamento INT,
    codigo_postal VARCHAR(10) NOT NULL,
    FOREIGN KEY (id_departamento) REFERENCES departamentos(id)
);

-- Tabla de Direcciones
CREATE TABLE direcciones (
    id INT PRIMARY KEY AUTO_INCREMENT,
    id_usuario INT,
    direccion TEXT NOT NULL,
    id_departamento INT NOT NULL,
    id_municipio INT NOT NULL,
    FOREIGN KEY (id_usuario) REFERENCES usuarios(id),
    FOREIGN KEY (id_departamento) REFERENCES departamentos(id),
    FOREIGN KEY (id_municipio) REFERENCES municipios(id)
);

-- Tabla de Categorías
CREATE TABLE categorias (
    id INT PRIMARY KEY AUTO_INCREMENT,
    nombre VARCHAR(100) UNIQUE NOT NULL
);

-- Tabla de Temáticas
CREATE TABLE tematicas (
    id INT PRIMARY KEY AUTO_INCREMENT,
    nombre VARCHAR(100) UNIQUE NOT NULL
);

-- Tabla de Productos
CREATE TABLE productos (
    id INT PRIMARY KEY AUTO_INCREMENT,
    nombre VARCHAR(255) NOT NULL,
    id_categoria INT NOT NULL,
    id_tematica INT NOT NULL,
    descripcion TEXT,
    precio_base DECIMAL(10,2) NOT NULL CHECK (precio_base > 0),
    FOREIGN KEY (id_categoria) REFERENCES categorias(id),
    FOREIGN KEY (id_tematica) REFERENCES tematicas(id)
);

-- Tabla de Materiales
CREATE TABLE materiales (
    id INT PRIMARY KEY AUTO_INCREMENT,
    nombre VARCHAR(100) UNIQUE NOT NULL
);

-- Tabla de Atributos de Producto
CREATE TABLE atributos_producto (
    id INT PRIMARY KEY AUTO_INCREMENT,
    talla ENUM('M', 'L', 'Única') NOT NULL,
    id_producto INT NOT NULL,
    id_material INT NOT NULL,
    FOREIGN KEY (id_producto) REFERENCES productos(id),
    FOREIGN KEY (id_material) REFERENCES materiales(id)
);

-- Tabla de Detalle de Productos
CREATE TABLE detalle_producto (
    id INT PRIMARY KEY AUTO_INCREMENT,
    id_producto INT NOT NULL,
    stock INT NOT NULL CHECK (stock >= 0),
    precio DECIMAL(10,2) NOT NULL CHECK (precio >= 0),
    id_usuario INT,
    FOREIGN KEY (id_producto) REFERENCES productos(id),
    FOREIGN KEY (id_usuario) REFERENCES usuarios(id)
);

-- Tabla de Pedidos
CREATE TABLE pedidos (
    id INT PRIMARY KEY AUTO_INCREMENT,
    id_usuario INT NOT NULL,
    fecha_pedido DATETIME DEFAULT CURRENT_TIMESTAMP,
    estado ENUM('Imprimiendo', 'Pintando', 'Enviando', 'Entregado') NOT NULL,
    FOREIGN KEY (id_usuario) REFERENCES usuarios(id)
);

-- Tabla de Detalle de Pedidos
CREATE TABLE detalle_pedidos (
    id INT PRIMARY KEY AUTO_INCREMENT,
    id_pedido INT NOT NULL,
    id_detalle_producto INT NOT NULL,
    cantidad INT NOT NULL CHECK (cantidad > 0),
    precio_unitario DECIMAL(10,2) NOT NULL CHECK (precio_unitario > 0),
    FOREIGN KEY (id_pedido) REFERENCES pedidos(id),
    FOREIGN KEY (id_detalle_producto) REFERENCES detalle_producto(id)
);

-- Tabla de Pagos
CREATE TABLE pagos (
    id INT PRIMARY KEY AUTO_INCREMENT,
    id_pedido INT NOT NULL,
    monto DECIMAL(10,2) NOT NULL CHECK (monto > 0),
    metodo_pago ENUM('visa', 'mastercard', 'american_express') NOT NULL,
    estado ENUM('pendiente', 'completado', 'fallido') NOT NULL,
    FOREIGN KEY (id_pedido) REFERENCES pedidos(id)
);

-- Tabla de Envíos
CREATE TABLE envios (
    id INT PRIMARY KEY AUTO_INCREMENT,
    id_pedido INT UNIQUE NULL,
    id_direccion INT NOT NULL,
    fecha_envio DATETIME,
    FOREIGN KEY (id_pedido) REFERENCES pedidos(id),
    FOREIGN KEY (id_direccion) REFERENCES direcciones(id)
);

-- Tabla de Carrito de Compras
CREATE TABLE carrito_compras (
    id INT PRIMARY KEY AUTO_INCREMENT,
    id_usuario INT UNIQUE NOT NULL,
    FOREIGN KEY (id_usuario) REFERENCES usuarios(id)
);

-- Tabla de Detalle de Carrito
CREATE TABLE detalle_carrito (
    id INT PRIMARY KEY AUTO_INCREMENT,
    id_carrito INT NOT NULL,
    id_detalle_producto INT NOT NULL,
    cantidad INT NOT NULL CHECK (cantidad > 0),
    FOREIGN KEY (id_carrito) REFERENCES carrito_compras(id),
    FOREIGN KEY (id_detalle_producto) REFERENCES detalle_producto(id)
);

-- Tabla de Historial de Ventas
CREATE TABLE historial_ventas (
    id INT PRIMARY KEY AUTO_INCREMENT,
    id_pedido INT UNIQUE NOT NULL,
    fecha_venta DATETIME DEFAULT CURRENT_TIMESTAMP,
    monto_total DECIMAL(10,2) NOT NULL CHECK (monto_total > 0),
    FOREIGN KEY (id_pedido) REFERENCES pedidos(id)
);

-- Tabla de Inventario
CREATE TABLE inventario (
    id INT PRIMARY KEY AUTO_INCREMENT,
    id_detalle_producto INT UNIQUE NOT NULL,
    stock_actual INT NOT NULL CHECK (stock_actual >= 0),
    cantidad_en_produccion INT NOT NULL CHECK (cantidad_en_produccion >= 0),
    fecha_actualizacion DATETIME DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (id_detalle_producto) REFERENCES detalle_producto(id)
);
