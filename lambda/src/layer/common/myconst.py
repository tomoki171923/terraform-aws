import os
from src.layer.base import const as cst


class myconst:
    # ***********************************************
    # Development Config
    # ***********************************************
    cst.END_POINT_URL_LOCAL = 'http://localhost:8000'
    cst.END_POINT_URL_DOCKER = 'http://host.docker.internal:8000'

    # ***********************************************
    # AWS Config
    # ***********************************************
    cst.REGION = 'ap-northeast-1'

    # ***********************************************
    # Botocore Config
    # ***********************************************
    # The maximum number of connections to keep in a connection pool. If this value is not set, the default value of 10 is used.
    cst.MAX_POOL_CONNECTIONS = 50

    # ***********************************************
    # Simple Email Service (SES) Config
    # ***********************************************

    # ***********************************************
    # CloudWatch Config
    # ***********************************************
    cst.RETENTION_IN_DAYS = 90  # CloudWatch Logsのロググループ保持期間(単位は日数)

    # ***********************************************
    # Simple Storage Service (S3) Config
    # ***********************************************
    cst.NUANCEBOOK_BUCKET = 'nuancebook' if os.environ.get('AWS_LAMBDA_FUNCTION_VERSION', 'no_env') != '$LATEST' \
        and os.environ.get('AWS_LAMBDA_FUNCTION_ALIAS', 'no_env') == 'pro' \
        else 'nuancebook-st'
    cst.DATAFILE_DIR = 'datafiles'  # data files are placed
    cst.DATAFILE_OLD_DIR = cst.DATAFILE_DIR + '/old'  # old data files are placed
