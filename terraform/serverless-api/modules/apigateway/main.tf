resource "aws_api_gateway_rest_api" "serverless_api" {
  name        = var.apiName
  description = "This is my API for demonstration purposes"
}

#health
resource "aws_api_gateway_resource" "health" {
  rest_api_id = aws_api_gateway_rest_api.serverless_api.id
  parent_id   = aws_api_gateway_rest_api.serverless_api.root_resource_id
  path_part   = "health"
}

resource "aws_api_gateway_method" "get_health" {
  rest_api_id   = aws_api_gateway_rest_api.serverless_api.id
  resource_id   = aws_api_gateway_resource.health.id
  http_method   = "GET"
  authorization = "NONE"
}

resource "aws_api_gateway_integration" "get_health_integration" {
  rest_api_id             = aws_api_gateway_rest_api.serverless_api.id
  resource_id             = aws_api_gateway_resource.health.id
  http_method             = aws_api_gateway_method.get_health.http_method
  integration_http_method = "GET"
  type                    = "AWS_PROXY"
  uri                     = var.lambdaArn
}


#products
resource "aws_api_gateway_resource" "products" {
  rest_api_id = aws_api_gateway_rest_api.serverless_api.id
  parent_id   = aws_api_gateway_rest_api.serverless_api.root_resource_id
  path_part   = "products"
}

resource "aws_api_gateway_method" "get_products" {
  rest_api_id   = aws_api_gateway_rest_api.serverless_api.id
  resource_id   = aws_api_gateway_resource.products.id
  http_method   = "GET"
  authorization = "NONE"
}

resource "aws_api_gateway_integration" "get_products_integration" {
  rest_api_id             = aws_api_gateway_rest_api.serverless_api.id
  resource_id             = aws_api_gateway_resource.products.id
  http_method             = aws_api_gateway_method.get_products.http_method
  integration_http_method = "GET"
  type                    = "AWS_PROXY"
  uri                     = var.lambdaArn
}



/*
#product
resource "aws_api_gateway_resource" "product" {
  rest_api_id = aws_api_gateway_rest_api.serverless_api.id
  parent_id   = aws_api_gateway_rest_api.serverless_api.root_resource_id
  path_part   = "product"
}

resource "aws_api_gateway_method" "get_product" {
  rest_api_id   = aws_api_gateway_rest_api.serverless_api.id
  resource_id   = aws_api_gateway_resource.product.id
  http_method   = "GET"
  authorization = "NONE"
}

resource "aws_api_gateway_method" "post_product" {
  rest_api_id   = aws_api_gateway_rest_api.serverless_api.id
  resource_id   = aws_api_gateway_resource.product.id
  http_method   = "POST"
  authorization = "NONE"
}

resource "aws_api_gateway_method" "patch_product" {
  rest_api_id   = aws_api_gateway_rest_api.serverless_api.id
  resource_id   = aws_api_gateway_resource.product.id
  http_method   = "PATCH"
  authorization = "NONE"
}

resource "aws_api_gateway_method" "delete_product" {
  rest_api_id   = aws_api_gateway_rest_api.serverless_api.id
  resource_id   = aws_api_gateway_resource.product.id
  http_method   = "DELETE"
  authorization = "NONE"
}

*/

/*
resource "aws_api_gateway_deployment" "prod" {
  rest_api_id = aws_api_gateway_rest_api.serverless_api.id

  depends_on = [
    aws_api_gateway_method.get_health,
    aws_api_gateway_method.get_products,
    aws_api_gateway_method.get_product,
    aws_api_gateway_method.post_product,
    aws_api_gateway_method.patch_product,
    aws_api_gateway_method.delete_product
  ]
}

resource "aws_api_gateway_stage" "example" {
  deployment_id = aws_api_gateway_deployment.prod.id
  rest_api_id   = aws_api_gateway_rest_api.serverless_api.id
  stage_name    = "prod"
}
*/