output "tables" {
  value = {
      saviola-table = aws_dynamodb_table.saviola-table
      nuancebook-table = aws_dynamodb_table.nuancebook-table
  }
}
