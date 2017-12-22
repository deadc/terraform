# Terraform structure
```
.
├── envs
│   ├── dev
│   │   ├── data
│   │   │   └── rds
│   │   │       ├── main.tf
│   │   │       └── outputs.tf
│   │   ├── Makefile
│   │   ├── network
│   │   │   └── vpc
│   │   │       ├── main.tf
│   │   │       ├── outputs.tf
│   │   │       └── vars.tf
│   │   ├── outputs.tf
│   │   └── services
│   │       ├── app
│   │       │   ├── main.tf
│   │       │   ├── outputs.tf
│   │       │   └── vars.tf
│   │       ├── app-asg
│   │       │   ├── main.tf
│   │       │   └── outputs.tf
│   │       ├── app-elb
│   │       │   ├── main.tf
│   │       │   └── outputs.tf
│   │       └── nodejs-frontend
│   ├── Makefile
│   ├── prd
│   │   ├── data
│   │   │   └── rds
│   │   │       ├── main.tf
│   │   │       └── outputs.tf
│   │   ├── Makefile
│   │   ├── network
│   │   │   └── vpc
│   │   │       ├── main.tf
│   │   │       └── outputs.tf
│   │   ├── outputs.tf
│   │   └── services
│   │       ├── app
│   │       │   ├── main.tf
│   │       │   └── outputs.tf
│   │       ├── app-asg
│   │       │   ├── main.tf
│   │       │   └── outputs.tf
│   │       └── app-elb
│   │           ├── main.tf
│   │           └── outputs.tf
│   └── stg
│       ├── data
│       │   └── rds
│       │       ├── main.tf
│       │       └── outputs.tf
│       ├── Makefile
│       ├── network
│       │   └── vpc
│       │       ├── main.tf
│       │       └── outputs.tf
│       ├── outputs.tf
│       └── services
│           ├── app
│           │   ├── main.tf
│           │   └── outputs.tf
│           ├── app-asg
│           │   ├── main.tf
│           │   └── outputs.tf
│           └── app-elb
│               ├── main.tf
│               └── outputs.tf
├── modules
│   ├── asg
│   │   ├── main.tf
│   │   ├── outputs.tf
│   │   ├── README.md
│   │   └── vars.tf
│   ├── ec2
│   │   ├── main.tf
│   │   ├── outputs.tf
│   │   ├── README.md
│   │   └── vars.tf
│   ├── elb
│   │   ├── main.tf
│   │   ├── outputs.tf
│   │   ├── README.md
│   │   └── vars.tf
│   ├── rds
│   │   ├── main.tf
│   │   ├── outputs.tf
│   │   ├── README.md
│   │   └── vars.tf
│   ├── route53
│   │   ├── main.tf
│   │   ├── outputs.tf
│   │   ├── README.md
│   │   └── vars.tf
│   └── vpc
│       ├── main.tf
│       ├── outputs.tf
│       ├── README.md
│       └── vars.tf
└── README.md
```
