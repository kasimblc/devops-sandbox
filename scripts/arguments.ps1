# config.ps1

$setup = @{
    servers = @(
        @{
            id = "setup"
            name = "Setup Environment"
            args = @{
                SourcePath = "ShopExpressWebApp"
                Backup = "N"
                RollBack = "N"
                CheckSite = "N"
                SleepTime = "30"
                Environment = "setup"
            }
        }
    )
}

$staging_defaults = @{
    ProjectPath = "C:\Projects"
    SourcePath = "ShopExpressWebApp"
    Backup = "Y"
    RollBack = "Y"
    CheckSite = "Y"
    SleepTime = "90"
    Environment = "staging"
}

$staging = @{
    defaults = $staging_defaults
    servers = @(
        @{
            id = "firma-1-staging-1"
            args = @{
                FolderName = "staging.example.com.tr"
                SiteUrl = "https://staging.example.com.tr"
                ProjectPath = $staging_defaults.ProjectPath
                SourcePath = $staging_defaults.SourcePath
                Backup = $staging_defaults.Backup
                RollBack = $staging_defaults.RollBack
                CheckSite = $staging_defaults.CheckSite
                SleepTime = $staging_defaults.SleepTime
                Environment = $staging_defaults.Environment
            }
        },
        @{
            id = "firma-1-staging-2"
            args = @{
                FolderName = "staging.example-2.com.tr"
                SiteUrl = "https://staging.example-2.com.tr"
                ProjectPath = $staging_defaults.ProjectPath
                SourcePath = $staging_defaults.SourcePath
                Backup = $staging_defaults.Backup
                RollBack = $staging_defaults.RollBack
                CheckSite = $staging_defaults.CheckSite
                SleepTime = $staging_defaults.SleepTime
                Environment = $staging_defaults.Environment
            }
        }
    )
}

$prod_defaults = @{
    SourcePath = "C:\Projects\staging.example.com.tr"
    Backup = "Y"
    RollBack = "Y"
    CheckSite = "Y"
    SleepTime = "60"
    Environment = "production"
}

$prod = @{
    defaults = $prod_defaults
    servers = @(
        @{
            id = "firma-1-production-1"
            args = @{
                ProjectPath = "X:\Projects"
                FolderName = "example.com.tr"
                SiteUrl = "https://example.com.tr"
                SourcePath = $prod_defaults.SourcePath
                Backup = $prod_defaults.Backup
                RollBack = $prod_defaults.RollBack
                CheckSite = $prod_defaults.CheckSite
                SleepTime = $prod_defaults.SleepTime
                Environment = $prod_defaults.Environment
            }
        },
        @{
            id = "firma-1-batch-2"
            args = @{
                ProjectPath = "Z:\Projects"
                FolderName = "example-2.com.tr"
                SiteUrl = "https://example-2.com.tr"
                SourcePath = $prod_defaults.SourcePath
                Backup = $prod_defaults.Backup
                RollBack = $prod_defaults.RollBack
                CheckSite = $prod_defaults.CheckSite
                SleepTime = $prod_defaults.SleepTime
                Environment = $prod_defaults.Environment
            }
        },
        @{
            id = "firma-1-production-1"
            args = @{
                ProjectPath = "ZZ:\Projects"
                FolderName = "example-batch.com.tr"
                CheckSite = "N"
                SiteUrl = "None"
                SourcePath = $prod_defaults.SourcePath
                Backup = $prod_defaults.Backup
                RollBack = $prod_defaults.RollBack
                SleepTime = $prod_defaults.SleepTime
                Environment = $prod_defaults.Environment
            }
        }
    )
}
