# Terraform structure

```
.
├── envs
│   ├── dev
│   │   ├── Makefile
│   │   ├── network
│   │   │   └── vpc
│   │   │       ├── main.tf
│   │   │       └── outputs.tf
│   │   ├── outputs.tf
│   │   └── services
│   │       └── app
│   │           ├── main.tf
│   │           └── outputs.tf
│   ├── Makefile
│   ├── prd
│   │   ├── Makefile
│   │   ├── network
│   │   │   └── vpc
│   │   │       ├── main.tf
│   │   │       └── outputs.tf
│   │   ├── outputs.tf
│   │   └── services
│   │       └── app
│   │           ├── main.tf
│   │           └── outputs.tf
│   └── stg
│       ├── Makefile
│       ├── network
│       │   └── vpc
│       │       ├── main.tf
│       │       └── outputs.tf
│       ├── outputs.tf
│       └── services
│           └── app
│               ├── main.tf
│               └── outputs.tf
├── modules
│   ├── ec2
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

