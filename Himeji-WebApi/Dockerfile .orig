#See https://aka.ms/containerfastmode to understand how Visual Studio uses this Dockerfile to build your images for faster debugging.

FROM mcr.microsoft.com/dotnet/aspnet:6.0 AS base
WORKDIR /app
EXPOSE 80

FROM mcr.microsoft.com/dotnet/sdk:6.0 AS build
WORKDIR /src
COPY ["Himeji-WebApi/Himeji-WebApi.csproj", "Himeji-WebApi/"]
RUN dotnet restore "Himeji-WebApi/Himeji-WebApi.csproj"
COPY . .
WORKDIR "/src/Himeji-WebApi"
RUN dotnet build "Himeji-WebApi.csproj" -c Release -o /app/build

FROM build AS publish
RUN dotnet publish "Himeji-WebApi.csproj" -c Release -o /app/publish

FROM base AS final
WORKDIR /app
COPY --from=publish /app/publish .
ENTRYPOINT ["dotnet", "Himeji-WebApi.dll"]