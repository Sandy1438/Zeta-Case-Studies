// variable "ami_details" {
//     type = map
//     default = {
//         owner = "amazon"
//         ami-name = "amazon"
//         ami-values = "amazon"
//         ami-root-devce-type = "ebs"
//     }
// }

variable "ami_details" {
    type = string
    default =  "ami-0f1fb91a596abf28d"
}

variable "ssh_key_pair" {
    type = string
    default =  "zeta-case-study"
}

variable "app_instance_details" {
    type = map
    default = {
        instance_count = 2
        instance_type = "t2.micro"
    }
}

variable "db_instance_details" {
    type = map
    default = {
        instance_count = 1
        instance_type = "t2.micro"
    }
}

variable "vpc_id" {
    type = string
}

variable "public_subnet_ids" {
    type = list
}

variable "private_subnet_ids" {
    type = list
}

variable "app-sg" {
    type = string
}

variable "db-sg" {
    type = string
}