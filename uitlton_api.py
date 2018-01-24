import base64
import requests


URL = 'https://integrations.thethingsnetwork.org/ttn-us-west/api/v2/down/app_modem_iog/123123?key=ttn-account-v2.h65db3wLw9f1LOMnd5BWzF9wzu7MgKNRNSXV5PbhOF0'
SET_RELAY_ON = "FE 06 01 52 04 FE"
dev_id = 'modem_iog_rn2903_modulo2'
port = 13


payload = bytearray.fromhex(SET_RELAY_ON)


pl64 = base64.b64encode(payload)



params = {
             "dev_id": dev_id,\
             "port": port,\
             "payload_raw": pl64}

print(params)

r = requests.post(URL, json=params, verify=False)
