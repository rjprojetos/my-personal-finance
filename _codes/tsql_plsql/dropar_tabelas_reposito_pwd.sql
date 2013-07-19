select 'DROP TABLE ' + NAME 
from sys.objects
where type = 'u' and left(name,2) = 'pm'