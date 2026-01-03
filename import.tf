import {
  to = azurerm_resource_group.terrak8s-practice-3-rg
  id = "/subscriptions/4da54369-4d96-441f-b882-9428583467ad/resourceGroups/terrak8s-practice-3-dev"
}

import {
  to = azurerm_linux_web_app.terrak8s-practice-3-app
  id = "/subscriptions/4da54369-4d96-441f-b882-9428583467ad/resourceGroups/terrak8s-practice-3-dev/providers/Microsoft.Web/sites/terrak8s-practice-3-app"
}

import {
  to = azurerm_service_plan.terrak8s-practice-3-asp
  id = "/subscriptions/4da54369-4d96-441f-b882-9428583467ad/resourceGroups/terrak8s-practice-3-dev/providers/Microsoft.Web/serverFarms/terrak8s-practice-3-plan"
}

import {
  to = azurerm_application_insights.terrak8s-practice-3-appinsights
  id = "/subscriptions/4da54369-4d96-441f-b882-9428583467ad/resourceGroups/terrak8s-practice-3-dev/providers/Microsoft.Insights/components/terrak8s-practice-3-logs"
}
