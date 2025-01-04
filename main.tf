
### Criação de Web App Linux ###


resource "azurerm_linux_web_app" "app_webapp" {
  count               = var.web_app_os == "linux" ? 1 : 0
  name                = "app-${var.system}-${var.environment}"
  location            = var.location
  resource_group_name = var.rg_name
  service_plan_id     = var.enable_asp ? azurerm_service_plan.asp_webapp[0].id : var.asp_id

  site_config {
    always_on = false
    #  linux_fx_version  = var.language_version                o argumento linux_fx_version, é definido automaticamente pelo azurerm_service_plan, de acordo com o web_app_os escolhido. 
    http2_enabled       = false
    worker_count        = 1     # correspondente à number_of_workers no azurerm_app_service
    minimum_tls_version = "1.2" # correspondente à min_tls_version no azurerm_app_service
    ftps_state          = "FtpsOnly"
    health_check_path = var.enable_health_check_path ? var.health_check_path : null                                  # caso não seja habilitado, não será criado um path
    health_check_eviction_time_in_min = var.enable_health_check_path ? var.health_check_eviction_time_in_min : null  # por depender do health_check_path precisa utilizar o mesmo condicional
  }

  logs {
    http_logs {
      file_system {
        retention_in_days = 7
        retention_in_mb   = 35
      }
    }
  }


  app_settings = merge(
    {
      "APPINSIGHTS_INSTRUMENTATIONKEY"             = var.enable_appi_webapp ? azurerm_application_insights.appi_webapp[0].connection_string : null,
      "APPLICATIONINSIGHTS_CONNECTION_STRING"      = var.enable_appi_webapp ? azurerm_application_insights.appi_webapp[0].connection_string : null,
      "ApplicationInsightsAgent_EXTENSION_VERSION" = var.enable_appi_webapp ? "~3" : null
      # Outras configurações padrão que sejam comuns a todos os sistemas
    },
    var.app_settings_variables
  )

  https_only                 = true
  client_affinity_enabled    = false
  client_certificate_enabled = false #correspondente à client_cert_enabled no azurerm_app_service
}





### Criação de Web App Windows ###


resource "azurerm_windows_web_app" "app_webapp" {
  count               = var.web_app_os == "windows" ? 1 : 0
  name                = "app-${var.system}-${var.environment}"
  location            = var.location
  resource_group_name = var.rg_name
  service_plan_id     = var.enable_asp ? azurerm_service_plan.asp_webapp[0].id : var.asp_id

  site_config {
    always_on           = false
    http2_enabled       = false
    worker_count        = 1     # correspondente à number_of_workers no azurerm_app_service
    minimum_tls_version = "1.2" # correspondente à min_tls_version no azurerm_app_service
    ftps_state          = "FtpsOnly"

  }

  logs {
    http_logs {
      file_system {
        retention_in_days = 7
        retention_in_mb   = 35
      }
    }
  }


  app_settings = merge(
    {
      "APPINSIGHTS_INSTRUMENTATIONKEY"             = var.enable_appi_webapp ? azurerm_application_insights.appi_webapp[0].connection_string : null,
      "APPLICATIONINSIGHTS_CONNECTION_STRING"      = var.enable_appi_webapp ? azurerm_application_insights.appi_webapp[0].connection_string : null,
      "ApplicationInsightsAgent_EXTENSION_VERSION" = var.enable_appi_webapp ? "~3" : null
      # Outras configurações padrão que sejam comuns a todos os sistemas
    },
    var.app_settings_variables
  )

  https_only                 = true
  client_affinity_enabled    = false
  client_certificate_enabled = false #correspondente à client_cert_enabled no azurerm_app_service
}






locals {
  app_service = var.web_app_os == "windows" ? azurerm_windows_web_app.app_webapp[0] : azurerm_linux_web_app.app_webapp[0]
}
/*

  Para podermos acessar corretamente o recurso de web app desejado, criamos um *local*, onde teremos um condicional
  que irá atribuir ao nome app_service o valor correto definido na variável web_app_os, podendo ser azurerm_windows_web_app ou azurerm_linux_web_app

*/







### Criação de App Service Plan ###

resource "azurerm_service_plan" "asp_webapp" {
  count               = var.enable_asp ? 1 : 0
  name                = "asp-${var.system}-${var.environment}"
  location            = var.location
  resource_group_name = var.rg_name
  os_type             = var.asp_kind_os # corresponde à kind  no azurerm_app_service_plan
  # reserved            = true          o argumento reserved, é definido automaticamente pelo azurerm_service_plan, de acordo com o web_app_os escolhido. 
  sku_name = var.asp_size


  /*
  sku_name substitui o bloco sku, e encapsula ambos tier e size, em uma simples string.
  ex:


          old sku block                |                New  sku_name value
    tier = "Standard", size = "S1"                              "S2"

  */

}




### Criação do Workspace log Analitcs do Diagnostics ###
resource "azurerm_log_analytics_workspace" "log_workspace_diagnostics" {
  count               = var.enable_diagnostics ? 1 : 0
  name                = "log-app-${var.system}-${var.environment}"
  location            = var.location
  resource_group_name = var.rg_name
  sku                 = "PerGB2018"
  retention_in_days   = 30
}

### Criação do Diagnostics ###
resource "azurerm_monitor_diagnostic_setting" "diagnostics_webapp" {
  count                      = var.enable_diagnostics ? 1 : 0
  name                       = "diag-${local.app_service.name}"
  target_resource_id         = local.app_service.id
  log_analytics_workspace_id = azurerm_log_analytics_workspace.log_workspace_diagnostics[0].id

  enabled_log {
    category = "AppServiceConsoleLogs"
  }

  enabled_log {
    category = "AppServiceAppLogs"
  }

  enabled_log {
    category = "AppServicePlatformLogs"
  }

  metric {
    category = "AllMetrics"
    enabled  = false
  }



  depends_on = [azurerm_log_analytics_workspace.log_workspace_diagnostics]
}

resource "azurerm_log_analytics_workspace" "log_workspace_appi" {
  count               = var.enable_appi_webapp ? 1 : 0
  name                = "log-appi-${var.system}-${var.environment}"
  location            = var.location
  resource_group_name = var.rg_name
  sku                 = "PerGB2018"
  retention_in_days   = 30
}

resource "azurerm_application_insights" "appi_webapp" {
  count               = var.enable_appi_webapp ? 1 : 0
  name                = "appi-${var.system}-${var.environment}"
  location            = var.location
  resource_group_name = var.rg_name
  application_type    = var.type
  workspace_id        = var.enable_appi_webapp ? azurerm_log_analytics_workspace.log_workspace_appi[0].id : null
}

### Criação do Slot para web app linux ###
resource "azurerm_linux_web_app_slot" "app_webapp_slot" {

  count = var.enable_slot && var.web_app_os == "linux" ? 1 : 0

  name = var.app_webapp_slot_name
  # app_service_name    = local.app_service.name
  # resource_group_name = local.app_service.resource_group_name
  # location            = local.app_service.location
  app_service_id        = local.app_service.id

  site_config {
    always_on           = local.app_service.site_config[0].always_on
    linux_fx_version    = local.app_service.site_config[0].linux_fx_version
    http2_enabled       = local.app_service.site_config[0].http2_enabled
    worker_count        = local.app_service.site_config[0].worker_count        # correspondente à number_of_workers no azurerm_app_service_slot
    minimum_tls_version = local.app_service.site_config[0].minimum_tls_version # correspondente à min_tls_version no azurerm_app_service_slot
    ftps_state          = local.app_service.site_config[0].ftps_state
  }

  app_settings = local.app_service.app_settings
}



### Criação do Slot para web app windows ###
resource "azurerm_windows_web_app_slot" "app_webapp_slot" {

  count = var.enable_slot && var.web_app_os == "windows" ? 1 : 0

  name = var.app_webapp_slot_name
  # app_service_name    = local.app_service.name
  # resource_group_name = local.app_service.resource_group_name
  # location            = local.app_service.location
  app_service_id        = local.app_service.id
  site_config {
    always_on           = local.app_service.site_config[0].always_on
    http2_enabled       = local.app_service.site_config[0].http2_enabled
    worker_count        = local.app_service.site_config[0].worker_count        # correspondente à number_of_workers no azurerm_app_service_slot
    minimum_tls_version = local.app_service.site_config[0].minimum_tls_version # correspondente à min_tls_version no azurerm_app_service_slot
    ftps_state          = local.app_service.site_config[0].ftps_state
  }

  app_settings = local.app_service.app_settings
}