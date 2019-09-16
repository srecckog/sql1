use rfind
select e.*,et.CodeName Eventtype,u.FirstName,u.LastName
from event e
left join eventtype et on e.EventType=et.Code
left join Badge b on b.BadgeNo=e.No
left join [dbo].[User] u on u.ExtId = b.ExtId

