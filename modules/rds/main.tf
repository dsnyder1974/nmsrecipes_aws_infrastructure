##############################
# RDS PostgreSQL Database Module
##############################

resource "aws_security_group" "postgres_db_sg" {
  name        = "${var.environment_name}-rds-sg"
  description = "Security group for RDS PostgreSQL database"
  vpc_id      = var.vpc_id

  tags = {
    Name = "${var.environment_name}-rds-sg"
  }
}

# Allow Lambda to access RDS
resource "aws_security_group_rule" "allow_rds_inbound_from_lambda" {
  type                     = "ingress"
  from_port                = 5432
  to_port                  = 5432
  protocol                 = "tcp"
  security_group_id        = aws_security_group.postgres_db_sg.id
  source_security_group_id = var.lambda_security_group_id
  description              = "Allow Lambda to access RDS on port 5432"
}

# Allow Bastion Host to access RDS
resource "aws_security_group_rule" "allow_rds_inbound_from_bastion" {
  type                     = "ingress"
  from_port                = 5432
  to_port                  = 5432
  protocol                 = "tcp"
  security_group_id        = aws_security_group.postgres_db_sg.id
  source_security_group_id = var.bastion_security_group_id
  description              = "Allow Bastion to access RDS on port 5432"
}


resource "aws_db_subnet_group" "rds_subnet_group" {
  name       = "${var.environment_name}-rds-subnet-group"
  subnet_ids = var.private_subnet_ids

  tags = {
    Name = "${var.environment_name}-rds-subnet-group"
  }
}

resource "aws_db_instance" "postgresql" {
  identifier              = "${var.environment_name}-postgresql-db"
  engine                  = "postgres"
  engine_version          = "16.8"
  instance_class          = "db.t4g.micro"
  allocated_storage       = 20
  username                = var.db_username
  password                = var.db_password
  db_subnet_group_name    = aws_db_subnet_group.rds_subnet_group.name
  vpc_security_group_ids  = [aws_security_group.postgres_db_sg.id]
  publicly_accessible     = false
  multi_az                = false
  backup_retention_period = 0

  skip_final_snapshot = true

  tags = {
    Name = "${var.environment_name}-postgresql-db"
  }
}
