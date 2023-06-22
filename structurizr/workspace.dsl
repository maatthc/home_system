workspace "Alex's Home Systems" "Documentation of services running at home" {
    model {
        user = person "Alex" {
            tags "Microsoft Azure - Bug"
        }

        host = softwareSystem "Host" {
            description "Debian GNU/Linux 11 (Bullseye) - Dell Alienware 14"
            tags "Microsoft Azure - Network Interfaces"

            docker = container "Docker" {
                technology "Docker"
                description "A container framework"
                tags "Microsoft Azure - Container Services (Deprecated)"
            }
            storage = container "Storage" {
                technology "Disk"
                description "SSD at /home/$USER/tv"
                tags "Microsoft Azure - Disks"
            }
        }

        homeSytem = softwareSystem "Home System" {
            description "Entertainment, security and utilities."
            tags "Microsoft Azure - Website Power"
            
            pihole = container "Pihole" {
                description "A black hole for Internet advertisements "
                technology "Java"
                tags "Microsoft Azure - DNS Zones"
                url "http://tv.home:8080/admin/login.php"
            }
            
            jupyterlabs = container "Jupyter Labs" {
                description "Development environment for notebooks, code, and data"
                tags "Microsoft Azure - Code"
                url "http://tv.home:8888/lab/"
            }
            
            structurizr = container "Structurizr" {
                description "C4 model for visualising software architecture"
                tags "Microsoft Azure - Dashboard"
                url "http://tv.home:8066/workspace/diagrams"
            }
            
            homeAssistant = container "Home Assistant" {
                description "Home Automation/ IoT"
                tags "Microsoft Azure - IoT Hub"
                url "http://tv.home:8123/"
            }
            
            mediaServer = container "MediaServer" {
                description "Media Server"
                tags "Microsoft Azure - Images"

                jellyfin = component "Jellyfin" {
                    description "Media Server"
                    tags "Microsoft Azure - Images"
                    url "http://tv.home:8096/web/index.html"
                }

                jackett = component "Jackett" {
                    description "Proxy server that translates queries into tracker-site-specific"
                    tags "Microsoft Azure - Resource Group List"
                    url "http://tv.home:9117/UI/Dashboard"
                }

                sonarr = component "Sonarr" {
                    description "Smart PVR for newsgroup and bittorrent users"
                    tags "Microsoft Azure - Device Provisioning Services"
                    url "http://tv.home:8989/"
                }

                transmission = component "Transmission" {
                    description "Torrent client"
                    tags "Microsoft Azure - Download"
                    url "http://tv.home:9091/transmission/web/"
                }
            }

        }

        user -> homeSytem "Uses"
        homeSytem -> host "Runs on"
        user -> pihole "Queries DNS"
        user -> jupyterlabs "Creates Notebook"
        user -> structurizr "Create Docs"
        user -> homeAssistant "Automate devices"
        user -> jellyfin "Watches TV"
        jellyfin -> sonarr "Pulls media"
        sonarr -> transmission "Triggers download"
        sonarr -> jackett "Searches episode"
    }

    views {
        systemContext homeSytem {
            include *
            autoLayout lr
        }
        container homeSytem {
            include *
            autoLayout
        }
        component mediaServer {
            include *
            autoLayout lr
        }

        container host {
            include *
            autoLayout lr
        }
        
        styles {
            element "Person" {
                shape Person
            }
            
            element "Element" {
                background #ffffff
                shape RoundedBox
            }
            
            relationship "Relationship" {
                color #ff0000
                dashed false
            }

        }

        # theme https://static.structurizr.com/themes/amazon-web-services-2020.04.30/theme.json
        theme https://static.structurizr.com/themes/microsoft-azure-2021.01.26/theme.json

        branding {
            logo https://i.ibb.co/fqnLGmr/dark-rabbit.jpg
            # font <name> [url]
        }
    }

}