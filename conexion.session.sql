CREATE OR REPLACE VIEW Carrito_Productos as
SELECT k.id as carritoID,
    p.id as id_producto,
    p.nombre as producto,
    c.cantidad as cantidad,
    p.precio as precio
from Producto p,
    Compra c,
    Carrito k
where p.id = c.Productoid
    and c.Carritoid = k.id;
------------------------
Select *
from Carrito_Productos;