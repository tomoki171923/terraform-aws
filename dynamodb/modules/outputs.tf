output "tables" {
  value = {
    saviola-table    = aws_dynamodb_table.saviola
    nuancebook-table = aws_dynamodb_table.nuancebook
  }
}
