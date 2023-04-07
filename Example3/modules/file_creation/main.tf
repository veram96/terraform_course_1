resource "local_file" "module_file" {
  filename = "module_file.txt"
  content  = "This is a file created by a module"
}

output "file_name"{
  value = local_file.module_file.filename
}