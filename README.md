# Example of nested SQL case
CASE Statement & Nested Case in SQL

```ruby
case 
		when shops.shop_id = 24 then 
			case 
				when order_items.vat_charges > 0 then ((order_items.price * order_items.quantity)/(1+(order_items.vat_charges/100)))-((order_items.cost_price * order_items.quantity)/(1+(order_items.vat_charges/100)))
				else ((order_items.price * order_items.quantity)/(1+(order_items.vat_charges/100)))-(order_items.cost_price * order_items.quantity)
			end
		else
			case
				when order_items.vat_charges > 0 then (if( product.product_margin > 0,
						((order_items.price * order_items.quantity * product.product_margin)/ 100),
						( if( brands.commission_percentage > 0,
						((order_items.price * order_items.quantity * brands.commission_percentage)/ 100),
						((order_items.price * order_items.quantity * shop_orders.shop_commission)/ 100)))))/(1+(order_items.vat_charges/100))
				else (if( product.product_margin > 0,
						((order_items.price * order_items.quantity * product.product_margin)/ 100),
						( if( brands.commission_percentage > 0,
						((order_items.price * order_items.quantity * brands.commission_percentage)/ 100),
						((order_items.price * order_items.quantity * shop_orders.shop_commission)/ 100)))))					
			end 
	end as admin_commission_total,
```
Check [nested-sql-case.sql](https://github.com/akramrana/nested-sql-case/blob/main/nested-case.sql) file for more example....
