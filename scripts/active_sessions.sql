Rem
Rem    NAME
Rem      active_sessions.sql
Rem
Rem    DESCRIPTION
Rem      List database active sessions.
Rem
Rem    NOTES
Rem      Run with DBA grants.
Rem
Rem    REQUISITOS
Rem      - Oracle 9.2.0.3 ou late
Rem
Rem    MODIFIED   (MM/DD/YYYY)
Rem      martyn     04/01/2024 - Created

SET SERVEROUTPUT ON
  SELECT s.sid AS "SID",
         s.serial# AS "Serial#",
         p.spid,                                              
         s.machine AS "Máquina",
         s.osuser AS "Usuário OS",
         s.username AS "Usuário DB",
         s.program AS "Programa",
         s.service_name AS "Serviço",
         sw.event AS "Evento",
         s.seconds_in_wait AS "Espera (s)",
         to_char (s.logon_time, 'YYYY-MM-DD HH24:MI:SS') AS "Hora do Logon", 
         s.sql_id AS "SQL Id",
         s.status AS "Status"
    FROM v$session s, v$session_wait sw, v$process p
   WHERE s.sid = sw.sid AND p.addr = s.paddr AND s.username IS NOT NULL
AND s.status = 'ACTIVE'
ORDER BY "Espera (s)" DESC;
