CREATE OR REPLACE VIEW Carrito_Productos as
SELECT k.id as carritoID,
    p.id as id_producto,
    p.nombre as producto,
    c.cantidad as cantidad,
    p.precio as precio
from Producto p,Compra c,Carrito k
where p.id = c.Productoid
    and c.Carritoid = k.id and k.estado='0';


select producto,sum(cantidad) as cantidad ,precio from Carrito_Productos
group by id_producto;
select sum(total_producto) from 
(select c.carritoID as idcar,p.nombre as producto,SUM(c.cantidad)*c.precio as total_producto,SUM(c.cantidad) cantidad, i.porcentaje as impuestos
from Carrito_Productos c, Producto p,Carrito_Impuesto ci,Impuesto i,Carrito as ca
where c.id_producto =p.id and i.id=ci.Impuestoid and ci.Carritoid=ca.id
group by c.carritoID,c.id_producto,i.id
) as Cart;


select * 
from Producto p
where p.Categoriaid=3 and p.estado='A';

SELECT * from Producto