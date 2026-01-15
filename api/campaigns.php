<?php
require_once '../config/db.php';

$sql = "
SELECT
    MAX(c.name) AS name,
    MAX(a.ad_type) AS ad_type,
    MAX(a.ad_platform) AS ad_platform,
    DATEDIFF(c.end_date, c.start_date) + 1 AS campaign_days,
    MAX(c.total_budget) AS spend,
    SUM(CASE WHEN e.event_type = 'Purchase' THEN 1 ELSE 0 END) * 50 AS revenue,
    ROUND(
        (
            (SUM(CASE WHEN e.event_type = 'Purchase' THEN 1 ELSE 0 END) * 50)
            - MAX(c.total_budget)
        ) / MAX(c.total_budget),
        2
    ) AS roi
FROM campaigns c
LEFT JOIN ads_new a ON c.campaign_id = a.campaign_id
LEFT JOIN events e ON a.ad_id = e.ad_id
GROUP BY c.campaign_id, c.start_date, c.end_date
ORDER BY roi DESC
";

$stmt = $pdo->prepare($sql);
$stmt->execute();

header('Content-Type: application/json');
echo json_encode($stmt->fetchAll(PDO::FETCH_ASSOC));
