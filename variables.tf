variable "location" {
  description = "Emplacement de la ressource"
  type        = string
  default     = "francecentral"
}

variable "subscription_id" {
  description = "ID de l'abonnement Azure"
  type        = string
  default     = "765266c6-9a23-4638-af32-dd1e32613047"
}

variable "resource_group_name" {
  description = "Nom du groupe de ressources"
  type        = string
  default     = "ADDA84-CTP"
}

variable "network_name" {
  description = "Nom du réseau"
  type        = string
  default     = "network-tp4"
}

variable "subnet_name" {
  description = "Nom du sous-réseau"
  type        = string
  default     = "internal"
}

variable "vm_name" {
  description = "Nom de la machine virtuelle"
  type        = string
  default     = "devops-20220131"
}

variable "vm_size" {
  description = "Taille de la machine virtuelle"
  type        = string
  default     = "Standard_D2s_v3"
}

variable "admin_username" {
  description = "Nom d'utilisateur administrateur de la machine virtuelle"
  type        = string
  default     = "devops"
}

variable "os_offer" {
  description = "Offre du système d'exploitation"
  type        = string
  default     = "UbuntuServer"
}

variable "os_sku" {
  description = "SKU du système d'exploitation"
  type        = string
  default     = "16.04-LTS"
}