SELECT account_balances.*

FROM account_balances

INNER JOIN (SELECT account_id, MAX(date) AS MaxDate

    FROM account_balances

    GROUP BY account_id) groupedab

ON account_balances.account_id = groupedab.account_id

AND account_balances.date = groupedab.MaxDate

ORDER BY account_id;