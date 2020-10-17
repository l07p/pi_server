select orders.id, date, type
from orders, order_type_ref, order_types
where order_type_ref.order_id = orders.id AND order_type_ref.type_id = order_types.id;