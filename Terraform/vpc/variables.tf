variable "vpc_cidr" {
    type = string
    default = "10.0.0.0/16"
}

variable "subnet_count" {
    type = number
    default = 3
}

variable "public_subnet_cidr" {
    type = list(string)
    default = ["10.0.10.0/24", "10.0.11.0/24", "10.0.12.0/24"]
    }

variable "private_subnet_cidr" {
    type = list(string)
    default = ["10.0.20.0/24", "10.0.21.0/24", "10.0.22.0/24"]
    }


variable "db_sg_name" {
    type = string
    default =  "DB SG"
}

variable "app_sg_name" {
    type = string
    default =  "app SG"
}