USE msdb 
EXEC sp_send_dbmail @profile_name='FxSqlMailProfile',
@recipients='vladimir.varnaliev@zg.t-com.hr', @subject='Test poruka',
@body='This is the body of the test message. Congrats Database Mail Received By you Successfully.' 