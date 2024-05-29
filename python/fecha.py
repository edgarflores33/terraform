# from datetime import datetime

# date_time_str = "28/01/23  08:20:00"

# date_time_object = datetime.strptime(date_time_str, "%d/%m/%y %H:%M:%S")

# print(date_time_object)

# # Comprobamos la clase del objeto mediante type: date_time_object_type
# print(type(date_time_object))

####################################################################################################

from datetime import datetime

def convertir_a_fecha_hora(cadena_fecha_hora):
    try:
        fecha_hora_objeto = datetime.strptime(cadena_fecha_hora, "%d %m %Y %H:%M:%S")
        return fecha_hora_objeto
    except ValueError:
        return "Formato de fecha y hora incorrecto. Asegúrate de usar el formato correcto."

####################################################################################################

