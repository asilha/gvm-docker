#!/usr/bin/env bash

set -e

# default - vars
STAGE="stable"
[ -z "${BUILD}" ] && BUILD=""

# build gvmlibs
gvmlibs_version=20.8.0
build_gvmlibs="${BUILD}"
echo "
################################################################################
################### Build gvmlibs ##############################################
################################################################################
Image: asilha/gvmlibs:${gvmlibs_version}${build_gvmlibs}"
docker build -f ./Dockerfile-gvmlibs --build-arg STAGE=${STAGE} \
  -t "asilha/gvmlibs:${gvmlibs_version}${build_gvmlibs}" \
  -t "asilha/gvmlibs:latest" .

# build gvmd
gvmd_version=20.8.0
build_gvmd="${BUILD}"
echo "
################################################################################
################### Build gvmd #################################################
################################################################################
Image: asilha/gvmd:${gvmd_version}${build_gvmd}"
docker build -f ./Dockerfile-gvmd --build-arg STAGE=${STAGE} \
  -t "asilha/gvmd:${gvmd_version}${build_gvmd}" \
  -t "asilha/gvmd:latest" .

# build openvas
openvas_version=20.8.0
build_openvas="${BUILD}"
echo "
################################################################################
################### Build openvas ##############################################
################################################################################
Image: asilha/openvas:${openvas_version}${build_openvas}"
docker build -f ./Dockerfile-openvas --build-arg STAGE=${STAGE} \
  -t "asilha/openvas:${openvas_version}${build_openvas}" \
  -t "asilha/openvas:latest" .

# build gsa
gsa_version=20.8.0
build_gsa="${BUILD}"
echo "
################################################################################
################### Build gsa ##################################################
################################################################################
Image: asilha/gsa:${gsa_version}${build_gsa}"
docker build -f ./Dockerfile-gsa --build-arg STAGE=${STAGE} \
  -t "asilha/gsa:${gsa_version}${build_gsa}" \
  -t "asilha/gsa:latest" .

postgres_gvm_version=11
build_postgres_gvm="${BUILD}"
echo "
################################################################################
################### Build postgres-gvm #########################################
################################################################################
Image: asilha/postgres-gvm:${postgres_gvm_version}${build_postgres_gvm}"
docker build -f ./Dockerfile-postgres-gvm --build-arg STAGE=${STAGE} \
  -t "asilha/postgres-gvm:${postgres_gvm_version}${build_postgres_gvm}" \
  -t "asilha/postgres-gvm:latest" .

# push
if [ "${1}" == "push" ]; then
  docker push "asilha/gvmlibs:${gvmlibs_version}${build_gvmlibs}"
  docker push "asilha/gvmlibs:latest"

  docker push "asilha/gvmd:${gvmd_version}${build_gvmd}"
  docker push "asilha/gvmd:latest"

  docker push "asilha/openvas:${openvas_version}${build_openvas}"
  docker push "asilha/openvas:latest"

  docker push "asilha/gsa:${gsa_version}${build_gsa}"
  docker push "asilha/gsa:latest"

  docker push "asilha/postgres-gvm:${postgres_gvm_version}${build_postgres_gvm}"
  docker push "asilha/postgres-gvm:latest"
fi
