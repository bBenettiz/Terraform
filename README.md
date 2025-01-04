<!-- BEGIN_TF_DOCS -->
## Requirements

No requirements.

## Providers

| Name | Version |
|------|---------|
| <a name="provider_azurerm"></a> [azurerm](#provider\_azurerm) | n/a |

## Modules

No modules.

## Resources

| Name | Type |
|------|------|
| [azurerm_application_insights.appi_webapp](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/application_insights) | resource |
| [azurerm_linux_web_app.app_webapp](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/linux_web_app) | resource |
| [azurerm_linux_web_app_slot.app_webapp_slot](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/linux_web_app_slot) | resource |
| [azurerm_log_analytics_workspace.log_workspace_appi](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/log_analytics_workspace) | resource |
| [azurerm_log_analytics_workspace.log_workspace_diagnostics](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/log_analytics_workspace) | resource |
| [azurerm_monitor_diagnostic_setting.diagnostics_webapp](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/monitor_diagnostic_setting) | resource |
| [azurerm_service_plan.asp_webapp](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/service_plan) | resource |
| [azurerm_windows_web_app.app_webapp](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/windows_web_app) | resource |
| [azurerm_windows_web_app_slot.app_webapp_slot](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/windows_web_app_slot) | resource |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_app_settings_variables"></a> [app\_settings\_variables](#input\_app\_settings\_variables) | n/a | `any` | n/a | yes |
| <a name="input_app_webapp_slot_name"></a> [app\_webapp\_slot\_name](#input\_app\_webapp\_slot\_name) | n/a | `any` | n/a | yes |
| <a name="input_asp_id"></a> [asp\_id](#input\_asp\_id) | n/a | `any` | n/a | yes |
| <a name="input_asp_kind_os"></a> [asp\_kind\_os](#input\_asp\_kind\_os) | n/a | `any` | n/a | yes |
| <a name="input_asp_size"></a> [asp\_size](#input\_asp\_size) | n/a | `any` | n/a | yes |
| <a name="input_enable_appi_webapp"></a> [enable\_appi\_webapp](#input\_enable\_appi\_webapp) | n/a | `any` | n/a | yes |
| <a name="input_enable_asp"></a> [enable\_asp](#input\_enable\_asp) | n/a | `any` | n/a | yes |
| <a name="input_enable_diagnostics"></a> [enable\_diagnostics](#input\_enable\_diagnostics) | n/a | `any` | n/a | yes |
| <a name="input_enable_health_check_path"></a> [enable\_health\_check\_path](#input\_enable\_health\_check\_path) | n/a | `any` | n/a | yes |
| <a name="input_enable_slot"></a> [enable\_slot](#input\_enable\_slot) | n/a | `any` | n/a | yes |
| <a name="input_environment"></a> [environment](#input\_environment) | n/a | `any` | n/a | yes |
| <a name="input_health_check_eviction_time_in_min"></a> [health\_check\_eviction\_time\_in\_min](#input\_health\_check\_eviction\_time\_in\_min) | n/a | `any` | n/a | yes |
| <a name="input_health_check_path"></a> [health\_check\_path](#input\_health\_check\_path) | n/a | `any` | n/a | yes |
| <a name="input_language_version"></a> [language\_version](#input\_language\_version) | n/a | `any` | n/a | yes |
| <a name="input_location"></a> [location](#input\_location) | n/a | `any` | n/a | yes |
| <a name="input_rg_name"></a> [rg\_name](#input\_rg\_name) | n/a | `any` | n/a | yes |
| <a name="input_system"></a> [system](#input\_system) | n/a | `any` | n/a | yes |
| <a name="input_type"></a> [type](#input\_type) | n/a | `any` | n/a | yes |
| <a name="input_web_app_os"></a> [web\_app\_os](#input\_web\_app\_os) | n/a | `any` | n/a | yes |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_ip_output_list"></a> [ip\_output\_list](#output\_ip\_output\_list) | n/a |
| <a name="output_webapp_name"></a> [webapp\_name](#output\_webapp\_name) | n/a |
<!-- END_TF_DOCS -->