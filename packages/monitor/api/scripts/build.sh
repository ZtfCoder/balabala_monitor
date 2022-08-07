#!/bin/bash

echo -e "\033[47;34m<<Cleaning Old Files>>\033[0m"
yarn del-cli src dist types
echo -e "\033[47;32m<<Old Files Cleaned>>\033[0m"


echo -e "\033[47;34m<<Generating API SourceFiles>>\033[0m"
yarn openapi -i openapi.json -o src -c xhr --name MonitorApiClient --useOptions --exportSchemas true
echo -e "\033[47;32m<<API SourceFiles Generated>>\033[0m"


echo -e "\033[47;34m<<Fixing API SourceFiles>>\033[0m"
yarn rexreplace "(public readonly )(: Service;)" "\$1service\$2" src/MonitorApiClient.ts
yarn rexreplace "(this.)( = new Service\(this.request\);)" "\$1service\$2" src/MonitorApiClient.ts
echo -e "\033[47;32m<<API SourceFiles Fixed>>\033[0m"


echo -e "\033[47;34m<<Compiling TypeScript As ESModule>>\033[0m"
yarn tsc --build
echo -e "\033[47;32m<<TypeScript Compiled As ESModule>>\033[0m"


echo -e "\033[47;34m<<Compiling TypeScript As UMDModule>>\033[0m"
yarn tsc --build tsconfig.umd.json
echo -e "\033[47;32m<<TypeScript Compiled As UMDModule>>\033[0m"


echo -e "\033[47;34m<<Formatting API SourceFiles>>\033[0m"
yarn prettier --write src --ignore-unknown
echo -e "\033[47;32m<<API SourceFiles Formatted>>\033[0m"
