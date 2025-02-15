-- 1. The names and the number of messages sent by each user---
SELECT 
  u.name, 
  COUNT(DISTINCT m.MessageID) AS messages_sent
FROM Users u
LEFT JOIN Messages m 
  ON u.UserID = m.UserIDSender
GROUP BY 1
ORDER BY 2 DESC

-- 2. The total number of messages sent stratified by weekday---

SELECT 
    DAYNAME(timestamp) AS weekday, 
    COUNT(DISTINCT MessageID) AS total_messages
FROM Messages 
GROUP BY weekday
ORDER BY CASE 
    WHEN weekday = 'Monday' THEN 1
    WHEN weekday = 'Tuesday' THEN 2
    WHEN weekday = 'Wednesday' THEN 3
    WHEN weekday = 'Thursday' THEN 4
    WHEN weekday = 'Friday' THEN 5
    WHEN weekday = 'Saturday' THEN 6
    WHEN weekday = 'Sunday' THEN 7
END

-- 3. The most recent message from each thread that has no response yet---


WITH RecentMessages AS (
    SELECT 
        ThreadID,
        MessageID,
        UserIDSender,
        UserIDRecipient,
        MessageContent,
        Timestamp
    FROM Messages 
    QUALIFY ROW_NUMBER() OVER (PARTITION BY ThreadID ORDER BY Timestamp DESC) = 1
)
  
SELECT 
    r.*
FROM RecentMessages r
LEFT JOIN Messages m
    ON r.ThreadID = m.ThreadID               -- join message of the same thread
    AND r.UserIDSender = m.UserIDRecipient   -- checks that the  sender's message was replied to
    AND r.Timestamp < m.Timestamp            -- only considers messages sent after r's message
WHERE m.MessageID IS NULL



-- 4. For the conversation with the most messages: all user data and message contents ordered chronologically---

WITH ThreadMessageCounts AS (
SELECT
  ThreadID,
  COUNT(DISTINCT MessageID) AS total_messages
FROM Messages
GROUP BY 1
ORDER BY 2 DESC
LIMIT 1
)

SELECT 
  m.*,
  sender.UserID AS SenderID, 
  sender.UserName AS SenderName,
  recipient.UserID AS RecipientID, 
  recipient.UserName AS RecipientName
FROM Messages m
LEFT JOIN Users sender 
    ON sender.UserID = m.UserIDSender
LEFT JOIN Users recipient 
    ON recipient.UserID = m.UserIDRecipient
WHERE m.ThreadID = (SELECT ThreadID FROM ThreadMessageCounts)
ORDER BY m.Timestamp;
