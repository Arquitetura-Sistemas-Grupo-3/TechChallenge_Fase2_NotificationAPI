FROM mcr.microsoft.com/dotnet/sdk:10.0 AS build
WORKDIR /src

COPY NotificationsAPI/NotificationsAPI.csproj NotificationsAPI/
RUN dotnet restore NotificationsAPI/NotificationsAPI.csproj

COPY NotificationsAPI/ NotificationsAPI/
RUN dotnet publish NotificationsAPI/NotificationsAPI.csproj \
    -c Release \
    -o /app/publish \
    --no-restore

FROM mcr.microsoft.com/dotnet/aspnet:10.0 AS runtime
WORKDIR /app

RUN adduser --disabled-password --gecos "" --uid 1001 appuser
USER appuser

COPY --from=build --chown=appuser:appuser /app/publish .

ENV ASPNETCORE_URLS=http://+:8080
EXPOSE 8080

ENTRYPOINT ["dotnet", "NotificationsAPI.dll"]
