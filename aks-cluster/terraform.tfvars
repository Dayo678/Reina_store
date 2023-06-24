variable "location" {
    type = string
    default = "eastus"
    description = "The location/region where the resources will be created"
}

variable "resource_group_name" {
    type = string
    default = "aksreact-cluster"
}

variable "subnet_name" {
    type = string
    default = "systempool-sunet"
}

variable "cluster_name" {
    type = string
    default = "aks-reina-cluster"
}

variable "default_node" {
    type = string
    default = "systempool"
}

variable "default_node_type" {
    type = string
    default = "VirtualMachineScaleSets"
}

variable "default_node_label" {
    type = string
    default = "system"
}
