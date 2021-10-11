CREATE OR REPLACE VIEW Carrito_Productos as
SELECT k.id as carritoID,
    p.id as id_producto,
    p.nombre as producto,
    c.cantidad as cantidad,
    p.precio as precio,
from Producto p,
    Compra c,
    Carrito k
where p.id = c.Productoid
    and c.Carritoid = k.id;


select p.nombre as producto,SUM(c.cantidad)*c.precio as total_producto,SUM(c.cantidad) cantidad
from Carrito_Productos c, Producto p
where c.id_producto =p.id
group by c.carritoID,c.id_producto;

select * from Impuesto