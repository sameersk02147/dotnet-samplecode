FROM mcr.microsoft.com/dotnet/core/sdk:3.0 AS build

WORKDIR /repo

COPY MyMicroservice.sln .
COPY src/MyMicroservice/MyMicroservice.csproj ./src/MyMicroservice/MyMicroservice.csproj

RUN dotnet restore

COPY . ./

RUN dotnet publish ./src/MyMicroservice/MyMicroservice.csproj -c Release -o /app/

FROM mcr.microsoft.com/dotnet/core/aspnet:3.0 AS runtime

COPY --from=build /app/ /app/
WORKDIR /app

ENTRYPOINT ["dotnet", "MyMicroservice.dll"]
