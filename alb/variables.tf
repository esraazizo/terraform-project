#-------------------------------General Instances------------------
variable "alb-name" {
  
}
variable "check-internal" {
  
}

variable "lb-type" {
  
}


variable "SG-lb" {

}

variable "subnets-id" {
  
}

variable "checking-cross-zone-lb" {
  type = bool
  default = true
}

variable "check-deny" {
  type = bool
  default = false
}

variable "name-lb" {

}
#--------------------------------------
variable "grp-name-target" {
  
}

variable "grp-type-target" {
  
}

variable "port-of-instances" {
  
}

variable "protocol-of-instances" {
  
}
variable "vpc-id" {
  
}


#------------------------------------------------

variable "healthy-threshold-instances" {
  type = number
  default = 2
}

variable "unhealthy-threshold-instances" {
  type = number
  default = 2
}

variable "interval-of-hc" {
  type = number
  default = 30
}
variable "timeout-instances" {
  type = number
  default = 3
}

variable "path-of-hc" {
  type = string
  default = "/"
}

#------------------------------------------------

variable "instances-id" {

}

variable "dependencies" {
  
}

variable "lisnter-type" {
  type = string
  default = "forward"
}