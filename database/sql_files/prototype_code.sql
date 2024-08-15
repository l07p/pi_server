SELECT u.id, u.last_name, u.email_address, COUNT(cuc.contract_id) AS num_contracts
FROM tbl_contract_user_conf cuc
JOIN tbl_users u ON cuc.user_id = u.id
WHERE u.blocked != 'true'
GROUP BY u.id, u.last_name
HAVING COUNT(cuc.contract_id) > 1;

SELECT u.id, u.last_name, u.first_name, c.id, c.title
FROM tbl_users u
JOIN tbl_contract_user_conf cuc ON u.id = cuc.user_id
JOIN tbl_contracts c ON cuc.contract_id = c.id
WHERE u.id IN (
    SELECT user_id
    FROM tbl_contract_user_conf
    GROUP BY user_id
    HAVING COUNT(contract_id) > 1
)
AND c.title NOT LIKE '%single%'
AND c.title NOT LIKE '%year%'
AND c.title NOT LIKE '%month%'
ORDER BY u.last_name;


SELECT
    u.*,
	wc.*
FROM
    tbl_users u
JOIN
    view_find_contract_the_user_belongs_to wc
ON
    u.id = wc.user_id
ORDER BY wc.title
;