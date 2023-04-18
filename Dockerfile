FROM sagcr.azurecr.io/webmethods-microservicesruntime:10.15.0.2

COPY HNRG/ /opt/softwareag/IntegrationServer/packages/HNRG
COPY WmJDBCAdapter/ /opt/softwareag/IntegrationServer/packages/WmJDBCAdapter
COPY WmCloud/ /opt/softwareag/IntegrationServer/packages/WmCloud
COPY HNRGAPI/ /opt/softwareag/IntegrationServer/packages/HNRGAPI