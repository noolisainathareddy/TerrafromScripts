variable "tags" {
  type = map(string)
  default = {
    "Env"        = "UAT"
    "Created_By" = "Terraform"
  }
}

variable "first_set_of_s3_buckets" {
  type    = list(string)
  default = ["sai-day-08-122025", "sai-day-08-121925"]
}

variable "second_set_of_s3_buckets" {

  type    = set(string)
  default = ["sai-day-08-121725", "sai-day-08-121825"]

}