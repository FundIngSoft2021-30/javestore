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
    and c.Carritoid = k.id
    and k.estado = '0';
-------------------------
select producto,
    sum(cantidad) as cantidad,
    precio
from Carrito_Productos
group by id_producto;
<<<<<<< HEAD
select sum(total_producto) from 
(select c.carritoID as idcar,p.nombre as producto,SUM(c.cantidad)*c.precio as total_producto,SUM(c.cantidad) cantidad, i.porcentaje as impuestos
from Carrito_Productos c, Producto p,Carrito_Impuesto ci,Impuesto i,Carrito as ca
where c.id_producto =p.id and i.id=ci.Impuestoid and ci.Carritoid=ca.id
group by c.carritoID,c.id_producto,i.id
) as Cart;

<<<<<<< HEAD
select * from Impuesto
=======

select * 
from Producto p
where p.Categoriaid=3 and p.estado='A';

SELECT * from Producto
>>>>>>> b504a8f79dad8b955eb40da88dd82462d287cca7
=======
--------------------------
select sum(total_producto)
from (
        select c.carritoID as idcar,
            p.nombre as producto,
            SUM(c.cantidad) * c.precio as total_producto,
            SUM(c.cantidad) cantidad,
            i.porcentaje as impuestos
        from Carrito_Productos c,
            Producto p,
            Carrito_Impuesto ci,
            Impuesto i,
            Carrito as ca
        where c.id_producto = p.id
            and i.id = ci.Impuestoid
            and ci.Carritoid = ca.id
            and ca.estado = '0'
        group by c.carritoID,
            c.id_producto,
            i.id
    ) as Cart;
----------------------------------------------------
SELECT c.fecha as fecha,
    select sum(total_producto)
from (
        select c.carritoID as idcar,
            p.nombre as producto,
            SUM(c.cantidad) * c.precio as total_producto,
            SUM(c.cantidad) cantidad,
            i.porcentaje as impuestos
        from Carrito_Productos c,
            Producto p,
            Carrito_Impuesto ci,
            Impuesto i,
            Carrito as ca
        where c.id_producto = p.id
            and i.id = ci.Impuestoid
            and ci.Carritoid = ca.id
            and ca.estado = '1'
        group by c.carritoID,
            c.id_producto,
            i.id
    ) as costo,
    from Carrito c
where c.Usuarioid = 1
    and c.estado = "1"
SELECT *
from Pedido
<<<<<<< HEAD
>>>>>>> 114713b110022fa474172e8abd6f5181ca1197d1
=======

select sum(total_producto)
from (
        select c.carritoID as idcar,
            p.nombre as producto,
            SUM(c.cantidad) * c.precio as total_producto,
            SUM(c.cantidad) cantidad,
            i.porcentaje as impuestos
        from Carrito_Productos c,
            Producto p,
            Carrito_Impuesto ci,
            Impuesto i,
            ItemsxCarrito as ca
        where c.id_producto = p.id
            and i.id = ci.Impuestoid
            and ci.Carritoid = ca.id
            and ca.estado = '0'
        group by c.carritoID,
            c.id_producto,
            i.id
    ) as Cart
>>>>>>> 0e1a56ad092f4d8155257286dbc827de476a8887
