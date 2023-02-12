 #---Security Groups of public-EC2
resource "aws_security_group" "security-grp-instance-pub" {
  name        = var.SG-pub-name
  description = var.SG-pub-desc
  vpc_id      = var.vpc-cidr-block-id
  
  ingress {
    from_port   = var.port-http
    to_port     = var.port-http
    protocol    = var.tcp-protocol
    cidr_blocks = var.cidr-public-of-traffics
  }
  ingress {
    from_port   = var.port-ssh
    to_port     = var.port-ssh
    protocol    = var.tcp-protocol
    cidr_blocks = var.cidr-public-of-traffics
  }

  egress {
    from_port   = var.port-all-traffic
    to_port     = var.port-all-traffic
    protocol    = var.all-traffic-protocol
    cidr_blocks = var.cidr-public-of-traffics
  }
  
  tags = {
    Name = var.SG-public-tags
  }
}

#---Security Groups of private-EC2

resource "aws_security_group" "security-grp-instance-private" {
  name        = var.SG-private-name
  description = var.SG-private-desc
  vpc_id      = var.vpc-cidr-block-id
  
  ingress {
    from_port   = var.port-http
    to_port     = var.port-http
    protocol    = var.tcp-protocol
    security_groups = ["${aws_security_group.security-grp-private-alb.id}"]
  }

  egress {
    from_port   = var.port-all-traffic
    to_port     = var.port-all-traffic
    protocol    = var.all-traffic-protocol
    cidr_blocks = var.cidr-public-of-traffics
  }
  
  tags = {
    Name = var.SG-private-tags
  }
}

#---Security Groups of public-alb

resource "aws_security_group" "security-grp-public-alb" {
  name        = var.SG-alb-name
  description = var.SG-alb-desc
  vpc_id      = var.vpc-cidr-block-id
  
  ingress {
    from_port   = var.port-http
    to_port     = var.port-http
    protocol    = var.tcp-protocol
    cidr_blocks = var.cidr-public-of-traffics
  }

  egress {
    from_port   = var.port-all-traffic
    to_port     = var.port-all-traffic
    protocol    = var.all-traffic-protocol
    cidr_blocks = var.cidr-public-of-traffics
  }
  
  tags = {
    Name = var.SG-alb-public-tags
  }
}

#---Security Groups of private-alb

resource "aws_security_group" "security-grp-private-alb" {
  name        = var.SG-private-alb-name
  description = var.SG-private-alb-desc
  vpc_id      = var.vpc-cidr-block-id
  
  ingress {
    from_port   = var.port-http
    to_port     = var.port-http
    protocol    = var.tcp-protocol
    security_groups = ["${aws_security_group.security-grp-instance-pub.id}"]
  }

  egress {
    from_port   = var.port-all-traffic
    to_port     = var.port-all-traffic
    protocol    = var.all-traffic-protocol
    cidr_blocks = var.cidr-public-of-traffics
  }
  
  tags = {
    Name = var.SG-private-alb-tags
  }
}