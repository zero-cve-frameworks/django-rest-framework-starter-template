from decouple import config

DEV = 'DEV'
PROD = 'PROD'
BRAND_NAME = config('BRAND_NAME', default='Core')
