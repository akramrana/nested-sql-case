SELECT 
case 
	when order_items.vat_charges > 0 then (order_items.price * order_items.quantity)/(1+(order_items.vat_charges/100))
	else (order_items.price * order_items.quantity)
end as website_price_total,
case 
	when shops.shop_id = 24 then 
		case 
			when order_items.vat_charges > 0 then (order_items.cost_price * order_items.quantity)/(1+(order_items.vat_charges/100))
			else (order_items.cost_price * order_items.quantity)
		end
	else
		case 
			when order_items.vat_charges > 0 then ((order_items.price * order_items.quantity) - (if( product.product_margin > 0,
					((order_items.price * order_items.quantity * product.product_margin)/ 100),
					( if( brands.commission_percentage > 0,
					((order_items.price * order_items.quantity * brands.commission_percentage)/ 100),
					((order_items.price * order_items.quantity * shop_orders.shop_commission)/ 100)))))) / (1+(order_items.vat_charges/100))
			else ((order_items.price * order_items.quantity) - (if( product.product_margin > 0,
					((order_items.price * order_items.quantity * product.product_margin)/ 100),
					( if( brands.commission_percentage > 0,
					((order_items.price * order_items.quantity * brands.commission_percentage)/ 100),
					((order_items.price * order_items.quantity * shop_orders.shop_commission)/ 100))))))
		end
end as amt_tobe_paid,
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
case 
	when shops.shop_id = 24 then 
		case 
			when order_items.vat_charges > 0 then (100 - (((order_items.cost_price * order_items.quantity)/(1+(order_items.vat_charges/100)))/((order_items.price * order_items.quantity)/(1+(order_items.vat_charges/100))))*100)
			else (100 - ((order_items.cost_price * order_items.quantity)/(order_items.price * order_items.quantity))*100)
		end
	else (if( product.product_margin > 0,
			(product.product_margin),
			( if( brands.commission_percentage > 0,
			(brands.commission_percentage),
			(shop_orders.shop_commission)))))
end as total_shop_commission,
case 
	when orders.discount > 0 then ((order_items.price * order_items.quantity)*(orders.discount)/100)
	else 0
end as total_discount_amt,
case
	when order_items.vat_charges > 0 then (order_items.price * order_items.quantity) - ((order_items.price * order_items.quantity)/(1+(order_items.vat_charges/100)))
	else 0
end as total_vat_amt,
case
	when shops.shop_id = 24 then 
		case
			when order_items.vat_charges > 0 then ((order_items.price * order_items.quantity)/(1+(order_items.vat_charges/100)))-((order_items.cost_price * order_items.quantity)/(1+(order_items.vat_charges/100)))-(case when orders.discount > 0 then ((order_items.price * order_items.quantity)*(orders.discount)/100) else 0 end)
			else ((order_items.price * order_items.quantity)/(1+(order_items.vat_charges/100)))-(order_items.cost_price * order_items.quantity)-(case when orders.discount > 0 then ((order_items.price * order_items.quantity)*(orders.discount)/100) else 0 end)
		end
	else 
		case 
			when order_items.vat_charges > 0 then ((if( product.product_margin > 0,
					((order_items.price * order_items.quantity * product.product_margin)/ 100),
					( if( brands.commission_percentage > 0,
					((order_items.price * order_items.quantity * brands.commission_percentage)/ 100),
					((order_items.price * order_items.quantity * shop_orders.shop_commission)/ 100)))))-(case when orders.discount > 0 then ((order_items.price * order_items.quantity)*(orders.discount)/100) else 0 end))/(1+(order_items.vat_charges/100))
			else ((if( product.product_margin > 0,
					((order_items.price * order_items.quantity * product.product_margin)/ 100),
					( if( brands.commission_percentage > 0,
					((order_items.price * order_items.quantity * brands.commission_percentage)/ 100),
					((order_items.price * order_items.quantity * shop_orders.shop_commission)/ 100)))))-(case when orders.discount > 0 then ((order_items.price * order_items.quantity)*(orders.discount)/100) else 0 end))
		end
end as total_revenue_amt

FROM your_table
WHERE ....
JOIN ....
ORDER BY ....
GROUP BY ....
