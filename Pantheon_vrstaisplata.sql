
select s.ackey,acworker,acperiod,anvalue,annet,anhours,e.acName
  FROM [tHR_SlryCalcET] s
  left join thr_setslryet e on s.acET=e.acET 
  where s.acworker like '%1173%'
  order by acperiod,acname