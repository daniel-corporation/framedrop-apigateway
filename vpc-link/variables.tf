variable "project_name" {
  description = "Prefixo para nomear recursos"
  type        = string
  default     = "framedrop"
}

variable "alb_name" {
  description = "Nome do Application Load Balancer existente na AWS (não o DNS, o nome do recurso)"
  type        = string
  default     = "framedrop-alb"
}