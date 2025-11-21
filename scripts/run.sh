declare -a rest=()

#!/usr/bin/env bash
set -xe

# Always use the project root as context, regardless of where this script is called from
SCRIPT_DIR="$(cd -- "$(dirname -- "${BASH_SOURCE[0]}")" &>/dev/null && pwd)"
PROJECT_ROOT="$(cd -- "$SCRIPT_DIR/.." && pwd)"

# On MSYS (Git Bash) convert paths to Windows form for Docker Desktop
if [ "$MSYSTEM" ]; then
  # prevent MSYS automatic path conversion and convert paths explicitly
  export MSYS=enable_pcon
  export MSYS_NO_PATHCONV=1
  if command -v cygpath >/dev/null 2>&1; then
    WIN_PROJECT_ROOT="$(cygpath -w "$PROJECT_ROOT")"
  else
    WIN_PROJECT_ROOT="$PROJECT_ROOT"
  fi
  BUILD_CONTEXT="$WIN_PROJECT_ROOT/runner"
  VOLUME_PROJECT="$WIN_PROJECT_ROOT:/workspace"
else
  BUILD_CONTEXT="$PROJECT_ROOT/runner"
  VOLUME_PROJECT="$PROJECT_ROOT:/workspace"
fi



while [ $# -gt 0 ]; do
  case "$1" in
    --docker) bin=docker ;;
    --podman) bin=podman ;;
    *) rest+=("$1") ;;
  esac
  shift
done

if [ ! "$bin" ]; then
  if command -v podman &>/dev/null; then
    bin=podman
  elif command -v docker &>/dev/null; then
    bin=docker
  else
    echo "error: docker/podman not found" >&2
    exit 1
  fi
fi


# Remove previous supportdraken container
"$bin" rm -f supportdraken &>/dev/null || :
"$bin" build -t supportdraken "$BUILD_CONTEXT"

"$bin" volume create docker-cache || :
"$bin" volume create maven-cache || :
"$bin" volume create mariadb-data || :

"$bin" run -it --rm --privileged \
  --name supportdraken \
  -v docker-cache:/var/lib/docker \
  -v maven-cache:/root/.m2 \
  -v mariadb-data:/var/lib/mysql \
  -v "$VOLUME_PROJECT" \
  -w /workspace \
  -p 3000:3000 \
  -p 3001:3001 \
  -p 7001:7001 \
  -p 8092:8092 \
  -p 8091:8091 \
  -p 8080:8080 \
  -p 8083:8083 \
  -p 8088:8088 \
  -p 8084:8084 \
  -p 8090:8090 \
  -p 8081:8081 \
  -p 8089:8089 \
  -p 8082:8082 \
  -p 8087:8087 \
  -p 8086:8086 \
  supportdraken "${rest[@]}"
