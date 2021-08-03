# ********************************* #
# RDS
# ref: https://github.com/terraform-aws-modules/terraform-aws-rds
# ********************************* #

module "postgres" {
  source = "terraform-aws-modules/rds/aws"

  identifier = local.base_name

  # All available versions: https://docs.aws.amazon.com/AmazonRDS/latest/UserGuide/CHAP_PostgreSQL.html#PostgreSQL.Concepts
  engine               = "postgres"
  engine_version       = "13.3"
  family               = "postgres13" # DB parameter group
  major_engine_version = "13"         # DB option group

  # instance resource size
  instance_class    = "db.t3.micro"
  allocated_storage = 5
  #max_allocated_storage = 8
  storage_encrypted = false
  storage_type      = "gp2" # gp2:SSD, io1:IOPS SSD

  # NOTE: Do NOT use 'user' as the value for 'username' as it throws:
  # "Error creating DB Instance: InvalidParameterValue: MasterUsername
  # user cannot be used as it is a reserved word used by the engine"
  name     = local.base_name # db name
  username = "postgres"
  password = "postgres"
  port     = 5432

  multi_az               = false
  subnet_ids             = local.vpc_state.vpc.database_subnets # subnet group
  vpc_security_group_ids = [local.vpc_state.security_group.postgres.id]

  maintenance_window              = "fri:17:00-fri:18:00" # Sat:02:00-03:00(JST)
  backup_window                   = "18:00-19:00"         # 03:00-04:00(JST)
  enabled_cloudwatch_logs_exports = ["postgresql", "upgrade"]

  #backup_retention_period = 0
  skip_final_snapshot = true # false is recommended
  deletion_protection = false

  #performance_insights_enabled          = true
  #performance_insights_retention_period = 7
  #create_monitoring_role                = true
  #monitoring_interval                   = 60

  parameters = [
    {
      name  = "autovacuum"
      value = 1
    },
    {
      name  = "client_encoding"
      value = "utf8"
    },
    {
      name  = "timezone"
      value = "jst-9"
    },
  ]

  tags = {
    Name        = "db_instance_${local.base_name}"
    Terraform   = "true"
    Environment = "dev"
  }
  db_option_group_tags = {
    Name        = "db_option_group_${local.base_name}"
    Terraform   = "true"
    Environment = "dev"
  }
  db_parameter_group_tags = {
    Name        = "db_parameter_group_${local.base_name}"
    Terraform   = "true"
    Environment = "dev"
  }
  db_subnet_group_tags = {
    Name        = "db_subnet_group_${local.base_name}"
    Terraform   = "true"
    Environment = "dev"
  }
}
