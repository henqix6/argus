select /*+ ORDERED */ to_char(s.sid)||':'||to_char(s.serial#) sid, 
       substr(s.username,1,10) username,
       t.address adr, 
       t.sql_text,
       a.rows_processed rpr,
       a.executions exc,
       a.plan_hash_value
from   v$session s, 
       v$sqltext t,
       v$sqlarea a
where t.address = s.sql_address
and   t.address = a.address
and   S.SID <> (select sid from v$mystat where rownum=1)
and s.sid in (select s.sid
              from v$session s, 
              v$process p
              where s.status = 'ACTIVE'
              and s.username is not null
              and s.paddr = p.addr)
order by s.sid, piece
/

