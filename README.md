# 20220131_TP4

    1. Introduction
    Ce rapport documente le travail que j'ai réalisé dans le cadre du TP4 sur la création d'une machine virtuelle Azure à l'aide de Terraform. L'objectif principal de ce TP était de créer une machine virtuelle avec une adresse IP publique dans un réseau existant, en utilisant Terraform comme outil de gestion d'infrastructure.

    Choix techniques
    2.1. Infrastructure Azure
    Pour ce TP, j'ai choisi d'utiliser Azure comme fournisseur de cloud. Azure offre une gamme de services cloud et une intégration étroite avec Terraform, ce qui facilite la création et la gestion des ressources.

2.2. Terraform
J'ai choisi Terraform comme outil principal pour la gestion de l'infrastructure. Terraform est un outil open-source qui permet de définir et de provisionner l'infrastructure en utilisant une syntaxe déclarative. Il offre une approche simple et efficace pour créer, modifier et détruire les ressources cloud de manière reproductible.

2.3. Azure CLI
J'ai utilisé Azure CLI pour l'authentification avec Azure. Il permet de se connecter à un compte Azure et d'effectuer des opérations sur les ressources via la ligne de commande. L'utilisation d'Azure CLI m'a permis de simplifier le processus d'authentification et d'accéder aux ressources Azure requises pour le déploiement.

2.4. Système d'exploitation
J'ai choisi le système d'exploitation Ubuntu 16.04-LTS pour la machine virtuelle. Ubuntu est une distribution Linux populaire et largement utilisée, offrant une stabilité et une compatibilité élevées.

    Étapes réalisées
    3.1. Configuration initiale

    J'ai créé un compte GitHub et un repository pour le projet.
    J'ai cloné le repository pour pouvoir travailler localement.

3.2. Installation des outils requis

    J'ai installé Terraform pour la gestion de l'infrastructure.
    J'ai installé Azure CLI pour l'authentification avec Azure.

3.3. Authentification avec Azure

    J'ai utilisé la commande az login pour me connecter à mon compte Azure et autoriser Terraform à accéder aux ressources.

3.4. Définition des fichiers de configuration
3.4.1. Fichier variables.tf

    J'ai créé le fichier variables.tf pour définir les variables nécessaires au déploiement.
    Ce fichier contient les variables suivantes:
        location: L'emplacement de la ressource.
        subscription_id: L'ID de l'abonnement Azure.
        resource_group_name: Le nom du groupe de ressources.
        network_name: Le nom du réseau.
        subnet_name: Le nom du sous-réseau.
        vm_name: Le nom de la machine virtuelle.
        vm_size: La taille de la machine virtuelle.
        admin_username: Le nom d'utilisateur administrateur de la machine virtuelle.
        os_offer: L'offre du système d'exploitation.
        os_sku: Le SKU du système d'exploitation.

3.4.2. Fichier vm.tf

    J'ai créé le fichier vm.tf.
    Le fichier vm.tf est un fichier de configuration Terraform qui définit les ressources nécessaires à la création de ma machine virtuelle dans Azure. Voici ce que contient ce fichier:

    Provider :
    Le fichier commence par la configuration du fournisseur AzureRM. Cette section spécifie les informations d'identification et les fonctionnalités par défaut à utiliser lors de l'interfaçage avec Azure.

    Data blocks :
    Le fichier utilise deux blocs de données (data) pour récupérer des informations sur les réseaux virtuels et les sous-réseaux existants. Ces blocs de données permettent de référencer des ressources existantes et d'obtenir des détails spécifiques nécessaires à la création de la machine virtuelle.

    Resource blocks :
    Le fichier contient plusieurs blocs de ressources (resource) qui définissent les ressources nécessaires à la création de la machine virtuelle.

    azurerm_public_ip : Ce bloc de ressources crée une adresse IP publique pour la machine virtuelle. Il spécifie des paramètres tels que le nom, l'emplacement, le groupe de ressources, la méthode d'allocation et le SKU de l'adresse IP publique.

    azurerm_network_interface : Ce bloc de ressources crée une interface réseau pour la machine virtuelle. Il spécifie des paramètres tels que le nom, l'emplacement et le groupe de ressources. Il configure également la configuration IP de l'interface réseau en utilisant le sous-réseau et l'adresse IP publique précédemment créés.

    tls_private_key : Ce bloc de ressources génère une clé privée TLS pour la connexion SSH à la machine virtuelle. Il spécifie l'algorithme de chiffrement et la taille de clé souhaitée.

    azurerm_virtual_machine : Ce bloc de ressources crée la machine virtuelle elle-même. Il spécifie des paramètres tels que le nom, l'emplacement, le groupe de ressources, la taille de la machine virtuelle, etc. Il configure également le disque OS de la machine virtuelle, l'image utilisée, le profil OS pour l'authentification SSH, etc.

3.5. Initialisation de Terraform

    J'ai exécuté la commande terraform init pour initialiser le répertoire de travail Terraform avec les plugins requis.

3.6. Vérification et planification

    J'ai exécuté la commande terraform plan pour afficher le plan d'exécution des ressources à créer.

3.7. Problème avec la ressource détruite dans le plan

    Lors de l'exécution de la commande terraform plan, j'ai remarqué que la ressource de groupe de ressources était programmée pour être détruite dans le plan.
    Cependant, je n'ai pas créé la ressource groupe avec mon fichier vm.tf car elle avait déjà été créée par le professeur.
    Il était donc nécessaire de gérer ce problème en indiquant à Terraform de ne pas détruire la ressource de groupe de ressources existante. J'ai utilisé la commande terraform state rm azurerm_resource_group.resource_group_name pour supprimer la référence à la ressource qui devait être détruite.

3.8. Déploiement des ressources

    Après avoir résolu le problème de la ressource qui allait être détruite, j'ai exécuté la commande terraform apply pour déployer la machine virtuelle Azure.

3.9. Test de connexion à la machine virtuelle

    Pour récupérer la clé privée générée par Terraform, j'ai exécuté la commande terraform output -raw private_key_kg.
    J'ai stocké la clé privée dans un fichier nommé private_key_kg en exécutant la commande terraform output -raw private_key_kg > privata_key_kg
    Ensuite, j'ai modifié les permissions du fichier private_key_kg en utilisant la commande chmod 600 private_key_kg.
    Pour me connecter à la machine virtuelle via SSH, j'ai utilisé la commande ssh -i private_key_kg devops@<adresse IP>.

3.10. Fichier .gitignore

    J'ai créé un fichier .gitignore pour exclure certains fichiers et répertoires du suivi Git.
    Le fichier .gitignore contient les entrées suivantes:
        .terraform: Le répertoire de travail Terraform.
        .terraform.lock.hcl: Le verrou Terraform.
        terraform.tfstate: L'état Terraform.
        terraform.tfstate.1687517823.backup: La sauvegarde de l'état Terraform.
        terraform.tfstate.backup: La sauvegarde de l'état Terraform.

J'ai utilisé terraform destroy à la fin de mon tp pour détruire les ressources que j'avais créées.


L'utilisation de Terraform pour déployer des ressources sur le cloud présente plusieurs avantages par rapport à l'utilisation de la CLI (Command-Line Interface) ou de l'interface utilisateur :

    Infrastructure as Code (IaC) : Terraform permet de définir toute l'infrastructure dans un format déclaratif à l'aide de fichiers de configuration. Cela permet d'adopter une approche basée sur le code pour gérer et versionner l'infrastructure, ce qui facilite la collaboration, la reproductibilité et l'automatisation.

    Gestion de l'état : Terraform gère l'état de l'infrastructure déployée. Il garde une trace de tous les éléments créés, modifiés ou supprimés, ce qui facilite la gestion des changements et la prise de décisions basées sur l'état actuel de l'infrastructure.

    Planification et prévisualisation : Terraform fournit des fonctionnalités de planification qui permettent de visualiser les changements avant de les appliquer. Vous pouvez exécuter la commande terraform plan pour voir les modifications proposées sans les appliquer réellement. Cela permet de détecter les erreurs ou les conflits potentiels avant le déploiement réel.

    Infrastructure multi-cloud : Terraform prend en charge plusieurs fournisseurs de cloud, ce qui permet de gérer des ressources sur différents clouds (comme Azure, AWS, Google Cloud, etc.) avec une syntaxe et une approche cohérentes. Cela offre une flexibilité pour adopter des stratégies multi-cloud ou migrer d'un cloud à un autre.

    Gestion des dépendances : Terraform gère les dépendances entre les ressources. Il détecte et gère automatiquement l'ordre dans lequel les ressources doivent être créées ou supprimées pour éviter les erreurs de dépendance.

    Contrôle des versions : Étant basé sur des fichiers de configuration, Terraform facilite la gestion des versions de l'infrastructure. Vous pouvez utiliser un système de contrôle de version tel que Git pour suivre les modifications apportées aux fichiers de configuration et revenir à des versions précédentes si nécessaire.

    Automatisation : Terraform peut être facilement intégré à des pipelines de déploiement ou à des outils d'automatisation tels que Jenkins, GitLab CI/CD, ou encore des outils de gestion de configuration comme Ansible. Cela permet d'automatiser le déploiement et la gestion de l'infrastructure en utilisant des pratiques DevOps.