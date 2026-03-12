data "local_file" "openapi_spec" {
  filename = "${path.module}/../open-api/openapi-bundled.yaml"
}