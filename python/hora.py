from datetime import datetime

date_time_str = "28 January 2023 08:20:00"

date_object = datetime.strptime(date_time_str, "%d %B %Y %H:%M:%S").time()

print(date_object)

#print(type(date_object))
