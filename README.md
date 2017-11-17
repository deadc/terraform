# Terraform structure

```
├── envs
│   ├── dev
│   │   ├── network
│   │   │   └── vpc
│   │   │       └── main.tf
│   │   ├── outputs.tf
│   │   └── services
│   │       └── app
│   ├── prd
│   │   ├── network
│   │   │   └── vpc
│   │   │       └── main.tf
│   │   ├── outputs.tf
│   │   └── services
│   │       └── app
│   └── stg
│       ├── network
│       │   └── vpc
│       │       └── main.tf
│       ├── outputs.tf
│       └── services
│           └── app
└── modules
    └── vpc
        ├── main.tf
        └── vars.tf
```

